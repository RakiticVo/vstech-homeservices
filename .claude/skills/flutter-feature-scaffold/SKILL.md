---
name: flutter-feature-scaffold
description: Scaffold a new lib/features/<name> module (data/domain/presentation) following this project's feature-first clean architecture, wired into get_it/injectable and go_router. Use when starting a new feature listed in docs/reference/PHASE1_SCOPE.md (e.g. auth, booking, tracking, worker_kyc).
---

# Flutter Feature Scaffold

Use this whenever a new feature directory needs to be created under `lib/features/`. Read
[CLAUDE.md](../../../CLAUDE.md) first — this skill only encodes the mechanical scaffolding steps,
not the architectural rules themselves.

## Steps

1. **Confirm the feature name and scope** against `docs/reference/PHASE1_SCOPE.md`. Use the exact
   feature directory name already listed in CLAUDE.md's directory structure table (`auth`, `home`,
   `booking`, `tracking`, `checkout`, `messaging`, `worker_dashboard`, `worker_dispatch`,
   `worker_task`, `worker_kyc`, `wallet`). Don't invent a new top-level feature without checking
   with the user first.

2. **Create the directory skeleton:**
   ```
   lib/features/<name>/
   ├── data/
   │   ├── datasources/     # <name>_remote_datasource.dart (dio calls), local if needed
   │   ├── models/          # freezed DTOs — separate Request/Response classes, never shared
   │   └── repositories/    # <name>_repository_impl.dart
   ├── domain/
   │   ├── entities/        # freezed plain entities (no json annotations)
   │   ├── repositories/    # abstract <name>_repository.dart
   │   └── usecases/        # one class per use case, single `call()` method
   └── presentation/
       ├── bloc/            # Cubit or Bloc + State (+ Event if Bloc)
       ├── pages/           # route-level widgets
       └── widgets/         # feature-local widgets only; promote to core/widgets/ on 2nd reuse
   ```

3. **Identify the matching API module** in `docs/reference/api/` (e.g. `booking` → `02-bookings.md`).
   If wiring the datasource now, follow the `api-module-integration` skill instead of hand-rolling it.

4. **Wire dependency injection**: register the repository implementation and use cases in the
   feature's `injectable` module (or the relevant `@module` if shared), then run
   `flutter pub run build_runner build --delete-conflicting-outputs`.

5. **Wire routing**: add route name constants to `core/router/app_routes.dart` and a `GoRoute` in
   `core/router/app_router.dart` that wraps the page in `BlocProvider(create: (_) => getIt<...>())`.

6. **State classes**: sealed class hierarchy per CLAUDE.md (`Initial`, `Loading`, `Loaded`, `Error`
   at minimum) — do not use loose booleans/nullable fields to represent state.

7. Leave a `// TODO(<feature>): implement <x>` only for work explicitly deferred by the user — do not
   scaffold speculative use cases beyond what's in `PHASE1_SCOPE.md`.
