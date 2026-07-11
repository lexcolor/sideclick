import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Persists the ClickUp personal API token (and lightweight selections) in a
/// local file, AES-encrypted with a per-device random key.
///
/// This avoids any OS Keychain / code-signing requirement (which blocks
/// unsigned desktop builds), while keeping the token from being stored in
/// plaintext. The key material lives in a sibling file with restricted
/// permissions; it is device-specific and never leaves the machine.
class SecureStore {
  static const _tokenKey = 'clickup_api_token';
  static const _teamKey = 'selected_team_id';
  static const _statusFilterKey = 'status_filter';
  static const _themeModeKey = 'theme_mode';
  static const _dataFile = 'sideclick_store.enc';
  static const _keyFile = 'sideclick_store.key';

  Directory? _dirOverride;
  Encrypter? _encrypter;

  /// [directory] is injectable for tests.
  SecureStore({Directory? directory}) : _dirOverride = directory;

  Future<Directory> _dir() async {
    return _dirOverride ??= await getApplicationSupportDirectory();
  }

  Future<Encrypter> _cipher() async {
    if (_encrypter != null) return _encrypter!;
    final dir = await _dir();
    final keyFile = File(p.join(dir.path, _keyFile));
    String base64Key;
    if (await keyFile.exists()) {
      base64Key = (await keyFile.readAsString()).trim();
    } else {
      final rnd = Random.secure();
      final bytes = List<int>.generate(32, (_) => rnd.nextInt(256));
      base64Key = base64Encode(bytes);
      await keyFile.writeAsString(base64Key, flush: true);
      // Best-effort tighten permissions on POSIX platforms.
      if (!Platform.isWindows) {
        try {
          await Process.run('chmod', ['600', keyFile.path]);
        } catch (_) {}
      }
    }
    final key = Key.fromBase64(base64Key);
    _encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return _encrypter!;
  }

  Future<Map<String, String>> _readAll() async {
    final dir = await _dir();
    final file = File(p.join(dir.path, _dataFile));
    if (!await file.exists()) return {};
    try {
      final cipher = await _cipher();
      // Stored format: "<base64 iv>:<base64 ciphertext>".
      final raw = (await file.readAsString()).trim();
      final sep = raw.indexOf(':');
      if (sep < 0) return {};
      final iv = IV.fromBase64(raw.substring(0, sep));
      final encrypted = Encrypted.fromBase64(raw.substring(sep + 1));
      final json = cipher.decrypt(encrypted, iv: iv);
      final map = jsonDecode(json) as Map<String, dynamic>;
      return map.map((k, v) => MapEntry(k, v as String));
    } catch (_) {
      // Corrupt or key mismatch — treat as empty (forces re-login).
      return {};
    }
  }

  Future<void> _writeAll(Map<String, String> data) async {
    final dir = await _dir();
    final file = File(p.join(dir.path, _dataFile));
    final cipher = await _cipher();
    final iv = IV.fromSecureRandom(16);
    final encrypted = cipher.encrypt(jsonEncode(data), iv: iv);
    await file.writeAsString('${iv.base64}:${encrypted.base64}', flush: true);
    if (!Platform.isWindows) {
      try {
        await Process.run('chmod', ['600', file.path]);
      } catch (_) {}
    }
  }

  Future<String?> readToken() async => (await _readAll())[_tokenKey];

  Future<void> writeToken(String token) async {
    final data = await _readAll();
    data[_tokenKey] = token;
    await _writeAll(data);
  }

  Future<void> clearToken() async {
    final data = await _readAll();
    data.remove(_tokenKey);
    await _writeAll(data);
  }

  Future<String?> readSelectedTeam() async => (await _readAll())[_teamKey];

  Future<void> writeSelectedTeam(String teamId) async {
    final data = await _readAll();
    data[_teamKey] = teamId;
    await _writeAll(data);
  }

  /// Persists the theme mode preference as 'system' | 'light' | 'dark'.
  Future<String?> readThemeMode() async => (await _readAll())[_themeModeKey];

  Future<void> writeThemeMode(String mode) async {
    final data = await _readAll();
    data[_themeModeKey] = mode;
    await _writeAll(data);
  }

  /// Persists the selected status-filter set as a newline-separated string.
  Future<Set<String>> readStatusFilter() async {
    final raw = (await _readAll())[_statusFilterKey];
    if (raw == null || raw.isEmpty) return {};
    return raw.split('\n').where((s) => s.isNotEmpty).toSet();
  }

  Future<void> writeStatusFilter(Set<String> statuses) async {
    final data = await _readAll();
    data[_statusFilterKey] = statuses.join('\n');
    await _writeAll(data);
  }

  /// Clears everything — used on sign-out.
  Future<void> clearAll() async {
    final dir = await _dir();
    final file = File(p.join(dir.path, _dataFile));
    if (await file.exists()) await file.delete();
  }
}
