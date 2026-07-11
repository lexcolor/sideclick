import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api/clickup_client.dart';
import '../core/db/app_database.dart';
import '../core/storage/secure_store.dart';
import '../repositories/attachment_repository.dart';
import '../repositories/auth_repository.dart';
import '../repositories/comment_repository.dart';
import '../repositories/task_repository.dart';
import '../repositories/time_repository.dart';

/// Single shared API client (holds the in-memory token).
final clickUpClientProvider = Provider<ClickUpClient>((ref) => ClickUpClient());

final secureStoreProvider = Provider<SecureStore>((ref) => SecureStore());

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.watch(clickUpClientProvider),
    ref.watch(secureStoreProvider),
  ),
);

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => TaskRepository(ref.watch(clickUpClientProvider)),
);

final commentRepositoryProvider = Provider<CommentRepository>(
  (ref) => CommentRepository(ref.watch(clickUpClientProvider)),
);

final attachmentRepositoryProvider = Provider<AttachmentRepository>(
  (ref) => AttachmentRepository(ref.watch(clickUpClientProvider)),
);

final timeRepositoryProvider = Provider<TimeRepository>(
  (ref) => TimeRepository(ref.watch(clickUpClientProvider)),
);
