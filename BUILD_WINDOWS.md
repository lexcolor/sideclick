# Building the Windows installer

Flutter Windows apps compile to native x64 binaries, so **the Windows build and
installer can only be produced on a Windows host** (Flutter has no
macOS→Windows cross-compilation). Everything below runs on a Windows 10/11
machine, a Windows VM, or a Windows CI runner.

The project is already configured (see the `msix_config:` block in
[pubspec.yaml](pubspec.yaml)) — on Windows it's two commands.

## Easiest path: build in the cloud (no Windows machine needed)

The repo includes a GitHub Actions workflow
([.github/workflows/windows-release.yml](.github/workflows/windows-release.yml))
that builds the `.msix` on a GitHub-hosted Windows runner and publishes it to a
GitHub Release. To cut a release:

```bash
# bump msix_version in pubspec.yaml first (e.g. 1.0.0.0 -> 1.0.1.0), then:
git tag v1.0.1
git push origin v1.0.1
```

A few minutes later the installer appears:
- attached to the **Release** at `github.com/lexcolor/sideclick/releases`, and
- as a downloadable **artifact** on the Actions run.

You can also trigger it manually from the **Actions** tab ("Run workflow"),
which produces the artifact without creating a Release.

**Free-tier note:** public repos get unlimited Actions minutes; private repos
get 2,000 min/month billed at a 2× multiplier for Windows (a build is ~8–15
min, so ~16–30 min charged per run — plenty for occasional releases).

**Signing in CI:** the workflow self-signs by default (fine for your own use).
To sign with a real certificate so other machines trust it without a SmartScreen
warning, add `MSIX_CERT_BASE64` and `MSIX_CERT_PASSWORD` repo secrets and follow
the commented block in the workflow file.

### Installing a self-signed release

Each release ships `sideclick.msix` **and** `sideclick_certificate.cer`. Because
the package is self-signed, Windows greys out the **Install** button (error
`0x800B010A`) until you trust that certificate:

```powershell
# PowerShell as Administrator, in the folder with the downloaded files:
Import-Certificate -FilePath .\sideclick_certificate.cer `
  -CertStoreLocation Cert:\LocalMachine\TrustedPeople
```

Then double-click `sideclick.msix` — Install is now enabled (or run
`Add-AppxPackage .\sideclick.msix`). This is only needed once per machine.

## Building locally instead

## One-time setup on the Windows machine

1. **Install Visual Studio 2022** (Community is fine) with the
   **"Desktop development with C++"** workload. This provides MSVC, the Windows
   SDK, and CMake that Flutter needs.
2. **Install the Flutter SDK** and add it to `PATH`.
3. Verify the toolchain:
   ```powershell
   flutter doctor
   ```
   The **"Visual Studio - develop Windows apps"** line must show a ✓.
4. Get dependencies:
   ```powershell
   flutter pub get
   ```

## Build the app

```powershell
flutter build windows --release
```

Output: `build\windows\x64\runner\Release\` — this folder contains
`sideclick.exe` and its DLLs. It **is** the runnable app (you can zip this folder
for a portable, no-install distribution), but it is not yet an installer.

## Produce the MSIX installer

```powershell
dart run msix:create
```

This runs the release build (if needed) and packages it into a single
**`build\windows\x64\runner\Release\sideclick.msix`** — a modern Windows
installer with proper install/uninstall.

### Installing the MSIX locally

MSIX packages must be signed to install. `msix:create` produces a **self-signed**
package by default. To install a self-signed build on your own machine:

1. Trust the generated test certificate (one-time, run as Administrator):
   ```powershell
   # msix:create prints the cert path; import it into Trusted People:
   Import-Certificate -FilePath "path\to\generated.cer" `
     -CertStoreLocation Cert:\LocalMachine\TrustedPeople
   ```
2. Double-click the `.msix`, or:
   ```powershell
   Add-AppxPackage .\build\windows\x64\runner\Release\sideclick.msix
   ```

For distribution to **other people's machines**, sign with a real code-signing
certificate: set `certificate_path` / `certificate_password` under `msix_config`
in `pubspec.yaml`, and make sure the `publisher:` field exactly matches the
certificate's subject (`CN=...`). Without a trusted signature, Windows
SmartScreen will warn other users.

### Microsoft Store submission (optional)

```powershell
dart run msix:create --store
```

This builds a Store-compliant package (unsigned; the Store signs it). You must
first reserve the app name in Partner Center and set `publisher` /
`identity_name` / `publisher_display_name` to the values Partner Center assigns.

## Config reference

The installer identity lives in `pubspec.yaml`:

```yaml
msix_config:
  display_name: SideClick
  publisher_display_name: Alex Colorado
  identity_name: com.sideclick.sideclick
  publisher: CN=SideClick        # must match the signing cert subject
  msix_version: 1.0.0.0          # bump for each release (a.b.c.d)
  logo_path: assets/icon/sideclick_icon.png
  capabilities: internetClient   # outbound network only
  architecture: x64
```

- Bump `msix_version` on every release you distribute.
- Replace `publisher` with your real certificate subject before shipping.

## Alternative installers

If you'd rather ship a classic setup wizard instead of MSIX:
- **Inno Setup** or **WiX Toolset** can wrap the `Release\` folder into a
  traditional `.exe` installer. These need their own script but produce the
  familiar "Next → Next → Install" experience and don't require MSIX signing.
