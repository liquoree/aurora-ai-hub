# Aurora AI Hub: GitHub-hosted CI feasibility check

This is a **diagnostic workflow**, not a build or an RPM validation.

## Why not enable a required Aurora build check yet?

Aurora SDK 5.2.1 for Linux documents at least 45 GB of free disk space. Standard
GitHub-hosted Ubuntu runners provide 14 GB SSD. The Aurora 5.2 build engine
uses Docker; running the emulator inside GitHub's virtual machine is not a
reliable supported guarantee.

## How to run

1. Copy `.github/workflows/aurora-hosted-probe.yml` into the repository.
2. Commit it to a branch and merge it into `main`.
3. Open **GitHub > Actions > Aurora hosted runner probe > Run workflow**.
4. Inspect disk, Docker and KVM output.
5. Do not make this probe a required merge check: it does not build the app.

## Next step to achieve a real build gate

Provision a runner with enough disk and a working Aurora SDK 5.2.1.200
installation, including its exact x86_64 build target. Verify that `sfdk build`
produces the expected RPM and `sfdk check` succeeds. Only then configure
branch protection to require that real build job.

An x86_64 build does not validate ARM hardware or runtime QML behavior.

Official docs:
- https://developer.auroraos.ru/doc/sdk/app_development/setup/setup_linux
- https://developer.auroraos.ru/doc/sdk/app_development/build/build_engine/sfdk
- https://docs.github.com/en/actions/reference/runners/github-hosted-runners
