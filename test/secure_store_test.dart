import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sideclick/core/storage/secure_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late SecureStore store;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('sideclick_test');
    store = SecureStore(directory: tempDir);
  });

  tearDown(() async {
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  test('token round-trips through encrypted file', () async {
    expect(await store.readToken(), isNull);
    await store.writeToken('pk_secret_123');
    expect(await store.readToken(), 'pk_secret_123');
  });

  test('theme mode round-trips and survives a fresh instance', () async {
    expect(await store.readThemeMode(), isNull);
    await store.writeThemeMode('dark');
    expect(await store.readThemeMode(), 'dark');

    final store2 = SecureStore(directory: tempDir);
    expect(await store2.readThemeMode(), 'dark');
  });

  test('status filter round-trips and survives a fresh instance', () async {
    expect(await store.readStatusFilter(), isEmpty);
    await store.writeStatusFilter({'in progress', 'review'});
    expect(await store.readStatusFilter(), {'in progress', 'review'});

    final store2 = SecureStore(directory: tempDir);
    expect(await store2.readStatusFilter(), {'in progress', 'review'});
  });

  test('empty status filter persists as empty', () async {
    await store.writeStatusFilter({'done'});
    await store.writeStatusFilter({});
    expect(await store.readStatusFilter(), isEmpty);
  });

  test('token is not stored in plaintext', () async {
    await store.writeToken('pk_supersecret');
    final contents = await tempDir
        .list()
        .where((f) => f is File && f.path.endsWith('.enc'))
        .cast<File>()
        .first
        .then((f) => f.readAsString());
    expect(contents.contains('pk_supersecret'), isFalse);
  });

  test('selected team persists alongside token', () async {
    await store.writeToken('pk_x');
    await store.writeSelectedTeam('team_42');
    expect(await store.readSelectedTeam(), 'team_42');
    expect(await store.readToken(), 'pk_x');
  });

  test('a fresh store instance reads previously written data', () async {
    await store.writeToken('pk_persist');
    final store2 = SecureStore(directory: tempDir);
    expect(await store2.readToken(), 'pk_persist');
  });

  test('clearAll removes the token', () async {
    await store.writeToken('pk_gone');
    await store.clearAll();
    expect(await store.readToken(), isNull);
  });
}
