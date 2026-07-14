# SideClick

A focused, cross-platform ClickUp client that shows **only your assigned tasks** —
without the clutter of the web UI. Built with Flutter for Windows, macOS, Android, and iOS.

## Features

- **Your tasks only** — pulls every task assigned to you across the whole workspace.
- **Urgency swatch** on each card:
  - **red** — overdue
  - **yellow** — due within 7 days
  - **green** — due later
  - **blue** — no due date
- **Priority chip** (urgent / high / normal / low).
- **Quick filters & sort** — overdue, due-this-week, include-closed; sort by due date,
  priority, or name.
- **Inline status changes** — tap a task's status (or long-press the card) to update it.
- **Comments** — read comments and reply.
- **@mentions** — tag teammates in a comment so they get notified (uses ClickUp's rich
  comment tag format).
- **Attachments** — view and upload files on a task.
- **Time tracking** — start/stop the timer with a live running-timer badge in the app bar,
  see per-task totals and individual entries.
- **Offline cache** — tasks are cached locally (SQLite) and shown instantly on launch;
  status changes made offline are queued and synced automatically when you reconnect.
- **Multiple workspaces** — auto-selects your first workspace, switchable from the app bar.

## Getting your API token

1. In ClickUp: avatar → **Settings** → **Apps**.
2. Under **API Token**, click **Generate** and copy the token (starts with `pk_`).
3. Paste it into SideClick's login screen. It's stored in the OS secure store
   (Keychain / Keystore / Windows Credential Locker) and sent only to `api.clickup.com`.

## Architecture

| Layer | What |
|---|---|
| `core/api` | Dio client with auth interceptor + typed error mapping (`ClickUpClient`) |
| `core/db` | Drift (SQLite) — `cached_tasks` + `queued_actions` |
| `core/storage` | `flutter_secure_storage` for the token |
| `models` | freezed + json_serializable immutable models |
| `repositories` | auth, task, comment, attachment, time |
| `providers` | Riverpod wiring (auth session, tasks, detail, running timer) |
| `sync` | `SyncService` — flushes queued mutations on reconnect |
| `features` | login, task list + card + filters, task detail (comments / files / time) |

## Development

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # regenerate models/db
flutter test          # unit tests (urgency logic, mention payload)
flutter analyze

flutter run -d macos      # or -d windows / an Android device / iOS simulator
```

Codegen (`*.freezed.dart`, `*.g.dart`) is required after touching any model or the
Drift database.

### Packaging

- **App icons** (all platforms): `dart run flutter_launcher_icons` — source art in
  `assets/icon/`, config under `flutter_launcher_icons:` in `pubspec.yaml`.
- **Windows installer** (`.msix`): must be built on a Windows host — see
  [BUILD_WINDOWS.md](BUILD_WINDOWS.md). Config is under `msix_config:` in `pubspec.yaml`.
- **Android**: `flutter build apk` (or `appbundle`). **macOS**: `flutter build macos`.

## ClickUp API — implemented & possible extensions

Everything here uses the ClickUp **v2** API (`https://api.clickup.com/api/v2`).

**Implemented:** `GET /user`, `GET /user/team`, `GET /team/{id}/task` (assignee-filtered,
paged), `GET/PUT /task/{id}`, `GET/POST /task/{id}/comment`, `POST /comment/{id}/thread`,
`GET/POST /task/{id}/attachment`, time-tracking `start`/`stop`/`current`/`time_entries`.

**Possible future features** (all supported by the API):
- Subtasks & checklists view per task.
- Tag and custom-field display/editing.
- Webhooks for real-time comment/mention push (needs a small relay for mobile push).
- Docs API integration.
- Grouping the list by List/Space.

## Platform notes

- **macOS**: deployment target pinned to 12.0; sandbox entitlements grant network-client
  and user-selected file access (for attachment upload).
- **Android**: `compileSdk` pinned to 36 (some plugins require it); `INTERNET` permission
  declared.
