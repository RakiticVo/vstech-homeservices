# Universal Flutter CI/CD & Store Publishing Blueprint for AI Agents

> **Source of Truth & Agent Protocol**: This document serves as the canonical, cross-project blueprint for AI Agents and DevOps engineers to implement, adapt, and run automated CI/CD deployment pipelines for Flutter mobile applications (Android & iOS) targeting **Firebase App Distribution**, **Google Play Store**, and **Apple App Store Connect / TestFlight**.
>
> Grounded in real-world production runs, this guide documents all mandatory directory layouts, code signing mechanisms, build configurations, and battle-tested edge-case resolutions.

---

## 📑 Table of Contents

1. [Architecture & Deployment Flow](#1-architecture--deployment-flow)
2. [Configuration Classification Matrix](#2-configuration-classification-matrix)
3. [Mandatory File & Directory Layout](#3-mandatory-file--directory-layout)
4. [Step-by-Step Agent Implementation Playbook](#4-step-by-step-agent-implementation-playbook)
5. [Complete Universal Code Templates](#5-complete-universal-code-templates)
   - [5.1 GitHub Actions Workflow (`.github/workflows/release.yml`)](#51-github-actions-workflow)
   - [5.2 Android Fastlane & Bundler Setup](#52-android-fastlane--bundler-setup)
   - [5.3 iOS Fastlane & Match Code Signing Setup](#53-ios-fastlane--match-code-signing-setup)
   - [5.4 Android Gradle Signing Configuration (`build.gradle.kts`)](#54-android-gradle-signing-configuration)
6. [Critical Agent Invariants & Battle-Tested Gotchas](#6-critical-agent-invariants--battle-tested-gotchas)
7. [Pre-Flight Verification Checklist](#7-pre-flight-verification-checklist)

---

## 1. Architecture & Deployment Flow

The pipeline follows a **tag-driven, decoupled branching strategy**:

```text
                     ┌─────────────────────────────────────────────────────────┐
                     │          Developer pushes Git Tag (v*)                  │
                     └────────────────────────────┬────────────────────────────┘
                                                  │
                                   ┌──────────────┴──────────────┐
                                   ▼                             ▼
                      Branch check: dev or prod?      Tag format validation
                                   │                             │
                     ┌─────────────┴─────────────┐               │
                     ▼                           ▼               ▼
           Tag: `vX.Y.Z-uat`               Tag: `vX.Y.Z` (Clean)
         (Target: UAT Testers)           (Target: Production Stores)
                     │                           │
          ┌──────────┴──────────┐     ┌──────────┴──────────┐
          ▼                     ▼     ▼                     ▼
     Android UAT             iOS UAT Android Prod        iOS Prod
     (APK to Firebase   (IPA to TestFlight (AAB to Google (IPA to App Store
      Distribution)       Internal)    Play Console)      Connect / TestFlight)
          │                     │     │                     │
          └──────────┬──────────┘     └──────────┬──────────┘
                     ▼                           ▼
          Report Version to Backend     Report Version to Backend
```

### Key Architectural Invariants

1. **Security Guardrail (Branch Isolation)**:
   - Release tags (`v*`) are **only permitted** on commits belonging to `origin/dev` (for UAT) or `origin/prod` (for Production).
   - Any tag pushed on an unmerged feature branch is immediately rejected by CI to prevent unverified code from reaching testers or users.
2. **UAT Environment (`vX.Y.Z-uat`)**:
   - Target Android: APK uploaded to Firebase App Distribution with release notes extracted from the tag message.
   - Target iOS: IPA uploaded to TestFlight (Internal Testers group).
   - API Configuration: Injects `--dart-define=API_BASE_URL=$API_BASE_URL_UAT`.
3. **Production Environment (`vX.Y.Z`)**:
   - Target Android: App Bundle (`.aab`) deployed to Google Play Store (Internal, Closed Alpha, or Production track).
   - Target iOS: IPA deployed to App Store Connect / TestFlight Production.
   - API Configuration: Injects `--dart-define=API_BASE_URL=$API_BASE_URL_PROD`.
4. **Backend Webhook Sync**:
   - Upon successful binary upload, CI calls the backend endpoint `POST /app-version` with header `x-ci-token` to synchronize the active mobile app version.

---

## 2. Configuration Classification Matrix

When onboarding a new project, AI Agents must strictly distinguish between **Auto-Extracted Parameters** (read directly from code) and **User-Provided Secrets** (must be configured in GitHub Secrets). Never ask the user for values that already exist in code.

```text
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           CONFIG CLASSIFICATION MATRIX                          │
├───────────────────────────────┬───────────────────────────────┬─────────────────┤
│  🙋‍♂️ TYPE 1: USER SECRETS      │  🔍 TYPE 2: AUTO-EXTRACTED    │ ⚙️ TYPE 3:      │
│  (Configured in GitHub)       │  (Inspected from Repository)  │ SYSTEM CONSTANTS│
└───────────────────────────────┴───────────────────────────────┴─────────────────┘
```

### 🙋‍♂️ Type 1: User-Provided Secrets (GitHub Repository Secrets)

| Secret Name | Purpose & Source | Target Platform |
|---|---|---|
| `ANDROID_KEYSTORE_BASE64` | Base64-encoded string of the release keystore `.jks` file | Android |
| `ANDROID_KEYSTORE_PASSWORD` | Password of the Android release keystore | Android |
| `ANDROID_KEY_ALIAS` | Key alias inside the keystore (e.g., `app_alias`) | Android |
| `ANDROID_KEY_PASSWORD` | Password for the key alias | Android |
| `PLAY_STORE_JSON_KEY` | Google Play Console GCP Service Account JSON key text | Android Prod |
| `FIREBASE_APP_DISTRIBUTION_CREDENTIALS` | Firebase GCP Service Account JSON key text | Android UAT |
| `FIREBASE_ANDROID_APP_ID` | Mobile app ID in Firebase Console (e.g., `1:123456:android:...`) | Android UAT |
| `APPLE_ID` | Apple Developer Account email address | iOS |
| `APPLE_TEAM_ID` | 10-character Apple Developer Team ID | iOS |
| `APP_STORE_CONNECT_KEY_ID` | App Store Connect API Key ID (e.g., `SACK5N6YM4`) | iOS |
| `APP_STORE_CONNECT_ISSUER_ID` | App Store Connect Issuer UUID | iOS |
| `APP_STORE_CONNECT_API_KEY_P8` | Complete content of Apple private key `.p8` file | iOS |
| `MATCH_GIT_URL` | SSH Git URL of the private code-signing repository | iOS |
| `MATCH_PASSWORD` | Passphrase used to encrypt/decrypt certificates in Match repo | iOS |
| `MATCH_SSH_KEY` | Private SSH Key with write access to `MATCH_GIT_URL` | iOS |
| `API_BASE_URL_UAT` | Backend API root URL for UAT builds | Android & iOS |
| `API_BASE_URL_PROD` | Backend API root URL for Production builds | Android & iOS |
| `APP_VERSION_CI_TOKEN` | Token for authenticating version update webhook with backend | Both (Optional) |

---

### 🔍 Type 2: Auto-Extracted Parameters (Inspect Target Repo)

AI Agents **MUST inspect these files** in the target workspace and substitute them into the templates:

| Configuration Item | Location in Target Project | Regex / Search Pattern |
|---|---|---|
| **App Name** | `pubspec.yaml` | `^name:\s*(.+)` |
| **Flutter SDK Version** | `pubspec.yaml` | `sdk:\s*">=([0-9.]+)"` |
| **Android Package Name** | `android/app/build.gradle.kts` (or `.gradle`) | `applicationId = "([^"]+)"` or `namespace = "([^"]+)"` |
| **Android Keystore Filename** | `android/app/build.gradle.kts` (or `.gradle`) | `storeFile = file\("([^"]+)"\)` |
| **iOS Bundle Identifier** | `ios/Runner.xcodeproj/project.pbxproj` | `PRODUCT_BUNDLE_IDENTIFIER = ([^;]+);` |
| **iOS Development Team** | `ios/Runner.xcodeproj/project.pbxproj` | `DEVELOPMENT_TEAM = ([^;]+);` |
| **Xcode Scheme / Workspace**| `ios/` directory | Defaults to `Runner` / `Runner.xcworkspace` |

---

### ⚙️ Type 3: Fixed System Constants & Invariants

| Constant / Path | Standard Value | Rationale |
|---|---|---|
| **Standardized Apple API Key Path** | `ios/fastlane/api_key.p8` | Fixed destination for decoded `.p8` key in CI |
| **Play Store Key Path** | `android/fastlane/fastlane-play-store.json` | Standardized destination for Google Play JSON key |
| **Firebase Credentials Path** | `android/fastlane/firebase-distribution.json` | Standardized destination for Firebase JSON key |
| **Ruby Version** | `3.1` | **Avoids CFPropertyList & psych incompatibility on Ruby 3.3+** |
| **Java Version** | `17` (Zulu distribution) | Compatible with Gradle 7.x & 8.x and Android SDK 34+ |
| **CI Runner OS** | Ubuntu (`ubuntu-latest`) for Android; macOS (`macos-latest`) for iOS | Cost-effective and matches platform build requirements |

---

## 3. Mandatory File & Directory Layout

Agents must adhere to the exact directory layout below. Placing `Gemfile` inside `fastlane/` instead of `android/` or `ios/` is a **critical mistake** that breaks Bundler and caching on GitHub Actions:

```text
TARGET_FLUTTER_PROJECT/
├── .github/
│   └── workflows/
│       └── release.yml                             <-- Unified CI/CD Pipeline
├── android/
│   ├── Gemfile                                     <-- MUST BE AT android/Gemfile
│   ├── Gemfile.lock                                <-- Checked into Git
│   ├── app/
│   │   ├── build.gradle.kts (or build.gradle)      <-- Contains signingConfigs & applicationId
│   │   └── <app_keystore>.jks                      <-- Created dynamically on CI runner (Git-ignored)
│   └── fastlane/
│       ├── Appfile                                 <-- Fastlane Android app metadata
│       ├── Fastfile                                <-- Fastlane Android deployment lanes
│       ├── Pluginfile                              <-- Declares fastlane-plugin-firebase_app_distribution
│       ├── firebase-distribution.json               <-- Created dynamically on CI runner (Git-ignored)
│       └── fastlane-play-store.json                <-- Created dynamically on CI runner (Git-ignored)
├── ios/
│   ├── Gemfile                                     <-- MUST BE AT ios/Gemfile
│   ├── Gemfile.lock                                <-- Checked into Git
│   ├── Runner.xcworkspace                          <-- Standard Flutter iOS workspace
│   └── fastlane/
│       ├── Appfile                                 <-- Fastlane iOS app metadata
│       ├── Fastfile                                <-- Fastlane iOS deployment lanes
│       ├── Matchfile                               <-- Fastlane Match git-storage config
│       └── api_key.p8                              <-- Created dynamically on CI runner (Git-ignored)
└── pubspec.yaml                                    <-- Contains version: X.Y.Z+build
```

---

## 4. Step-by-Step Agent Implementation Playbook

When tasked with setting up or repairing CI/CD in any Flutter repository, follow this execution sequence:

### Phase 1: Codebase Inspection
1. Open `pubspec.yaml`: note `name` and Flutter SDK version.
2. Open `android/app/build.gradle.kts`:
   - Identify `applicationId`.
   - Verify `signingConfigs { create("release") { ... } }` exists and note the target keystore filename (e.g. `upload_keystore.jks`).
3. Open `ios/Runner.xcodeproj/project.pbxproj`:
   - Search for `PRODUCT_BUNDLE_IDENTIFIER` (e.g., `com.company.app`).
   - Search for `DEVELOPMENT_TEAM`.

### Phase 2: Configuration Scaffolding
1. Create `android/Gemfile` and `android/fastlane/Pluginfile`.
2. Create `android/fastlane/Appfile` and `android/fastlane/Fastfile`.
3. Create `ios/Gemfile`.
4. Create `ios/fastlane/Appfile`, `ios/fastlane/Matchfile`, and `ios/fastlane/Fastfile`.
5. Create `.github/workflows/release.yml`.
6. Update `.gitignore` to ensure generated credentials (`*.jks`, `*.p8`, `*.json`) are never committed.

### Phase 3: Bundler Lockfile Generation
- On a Mac or Linux environment, run `bundle install` inside both `android/` and `ios/` to generate `Gemfile.lock`.
- If on Windows, note that Windows developers do not need Ruby locally; GitHub Actions with `bundler-cache: true` will resolve gems automatically on the runner.

### Phase 4: Secrets Audit
- Generate an audit list for the user outlining all required GitHub Secrets based on [Section 2](#2-configuration-classification-matrix).
- Provide step-by-step instructions for obtaining any missing credentials.

---

## 5. Complete Universal Code Templates

### 5.1 GitHub Actions Workflow

Path: `.github/workflows/release.yml`

```yaml
name: CI/CD Release Pipeline

on:
  push:
    tags:
      - 'v*'

env:
  ACTIONS_ALLOW_USE_UNSECURE_NODE_VERSION: 'true'
  FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: 'true'

jobs:
  # -------------------------------------------------------------
  # STAGE 1: Code Verification & Static Analysis
  # -------------------------------------------------------------
  test:
    name: Flutter Tests & Analysis
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Validate Tag Branch Integrity
        run: |
          git fetch --all
          TAG_COMMIT=$(git rev-parse HEAD)
          CONTAINED_BRANCHES=$(git branch -r --contains $TAG_COMMIT)
          echo "Branches containing commit $TAG_COMMIT:"
          echo "$CONTAINED_BRANCHES"
          if ! echo "$CONTAINED_BRANCHES" | grep -qE 'origin/(prod|dev)'; then
            echo "::error::Release tags are only allowed on 'origin/prod' or 'origin/dev' branches!"
            exit 1
          fi

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Install Dependencies
        run: flutter pub get

      - name: Run Static Analyzer
        run: flutter analyze --no-fatal-infos --no-fatal-warnings

      - name: Run Automated Tests
        run: flutter test

  # -------------------------------------------------------------
  # STAGE 2A: Android UAT (Firebase App Distribution)
  # -------------------------------------------------------------
  android-uat:
    name: Android UAT Deployment
    needs: test
    if: contains(github.ref, '-uat')
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Extract Release Notes from Tag Message
        run: |
          TAG_MSG=$(git tag -l --format='%(contents)' ${{ github.ref_name }})
          if [ -z "$TAG_MSG" ]; then
            TAG_MSG=$(git log -1 --pretty=%B)
          fi
          # Flatten multi-line notes for GitHub Actions env safely
          TAG_MSG=$(echo "$TAG_MSG" | tr '\n' ' ')
          echo "RELEASE_NOTES=$TAG_MSG" >> $GITHUB_ENV

      - name: Setup Java 17
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Setup Ruby 3.1
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true
          working-directory: android

      - name: Decode Android Keystore & Firebase Credentials
        run: |
          # Replace 'upload_keystore.jks' with the filename defined in build.gradle.kts
          echo "${{ secrets.ANDROID_KEYSTORE_BASE64 }}" | grep -v "CERTIFICATE" | base64 --decode > app/upload_keystore.jks
          printf "%s" "$FIREBASE_APP_DISTRIBUTION_CREDENTIALS" > firebase-distribution.json
          printf "%s" "$FIREBASE_APP_DISTRIBUTION_CREDENTIALS" > fastlane/firebase-distribution.json
        working-directory: android
        env:
          ANDROID_KEYSTORE_BASE64: ${{ secrets.ANDROID_KEYSTORE_BASE64 }}
          FIREBASE_APP_DISTRIBUTION_CREDENTIALS: ${{ secrets.FIREBASE_APP_DISTRIBUTION_CREDENTIALS }}

      - name: Build APK & Deploy to Firebase App Distribution
        run: bundle exec fastlane distribute_firebase
        working-directory: android
        env:
          FIREBASE_ANDROID_APP_ID: ${{ secrets.FIREBASE_ANDROID_APP_ID }}
          ANDROID_KEYSTORE_PASSWORD: ${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
          ANDROID_KEY_ALIAS: ${{ secrets.ANDROID_KEY_ALIAS }}
          ANDROID_KEY_PASSWORD: ${{ secrets.ANDROID_KEY_PASSWORD }}
          API_BASE_URL: ${{ secrets.API_BASE_URL_UAT }}
          RELEASE_NOTES: ${{ env.RELEASE_NOTES }}

  # -------------------------------------------------------------
  # STAGE 2B: Android Production (Google Play Store)
  # -------------------------------------------------------------
  android-prod:
    name: Android Production Deployment
    needs: test
    if: "!contains(github.ref, '-uat') && !contains(github.ref, '-beta')"
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Extract Release Notes
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          TAG_MSG=$(git tag -l --format='%(contents)' ${{ github.ref_name }})
          if [ -z "$TAG_MSG" ] && [ "${{ github.ref_name }}" = "prod" ]; then
            PR_BODY=$(gh pr list --base prod --state merged --json body,mergeCommit --jq ".[] | select(.mergeCommit.oid == \"$GITHUB_SHA\") | .body")
            if [ -n "$PR_BODY" ]; then
              TAG_MSG="$PR_BODY"
            fi
          fi
          if [ -z "$TAG_MSG" ]; then
            TAG_MSG=$(git log -1 --pretty=%B)
          fi
          CLEANED_NOTES=$(echo "$TAG_MSG" | tr '\n' ' ')
          echo "RELEASE_NOTES=$CLEANED_NOTES" >> $GITHUB_ENV

      - name: Setup Java 17
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Setup Ruby 3.1
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true
          working-directory: android

      - name: Decode Keystore & Play Store Service Account
        run: |
          echo "${{ secrets.ANDROID_KEYSTORE_BASE64 }}" | grep -v "CERTIFICATE" | base64 --decode > app/upload_keystore.jks
          printf "%s" "$PLAY_STORE_JSON_KEY" > fastlane-play-store.json
          printf "%s" "$PLAY_STORE_JSON_KEY" > fastlane/fastlane-play-store.json
        working-directory: android
        env:
          ANDROID_KEYSTORE_BASE64: ${{ secrets.ANDROID_KEYSTORE_BASE64 }}
          PLAY_STORE_JSON_KEY: ${{ secrets.PLAY_STORE_JSON_KEY }}

      - name: Build AAB & Deploy to Google Play Console
        run: bundle exec fastlane deploy_play_store
        working-directory: android
        env:
          ANDROID_KEYSTORE_PASSWORD: ${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
          ANDROID_KEY_ALIAS: ${{ secrets.ANDROID_KEY_ALIAS }}
          ANDROID_KEY_PASSWORD: ${{ secrets.ANDROID_KEY_PASSWORD }}
          API_BASE_URL: ${{ secrets.API_BASE_URL_PROD }}
          PLAY_STORE_TRACK: ${{ secrets.PLAY_STORE_TRACK || 'internal' }}
          RELEASE_NOTES: ${{ env.RELEASE_NOTES }}

  # -------------------------------------------------------------
  # STAGE 3A: iOS UAT (TestFlight Internal)
  # -------------------------------------------------------------
  ios-uat:
    name: iOS UAT Deployment (TestFlight)
    needs: test
    if: contains(github.ref, '-uat')
    runs-on: macos-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Extract Release Notes from Tag Message
        run: |
          TAG_MSG=$(git tag -l --format='%(contents)' ${{ github.ref_name }})
          if [ -z "$TAG_MSG" ]; then
            TAG_MSG=$(git log -1 --pretty=%B)
          fi
          TAG_MSG=$(echo "$TAG_MSG" | tr '\n' ' ')
          echo "RELEASE_NOTES=$TAG_MSG" >> $GITHUB_ENV

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Setup SSH Key for Fastlane Match
        uses: webfactory/ssh-agent@v0.9.0
        with:
          ssh-private-key: ${{ secrets.MATCH_SSH_KEY }}

      - name: Setup Ruby 3.1
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true
          working-directory: ios

      - name: Install Flutter Dependencies
        run: flutter pub get

      - name: Generate Flutter iOS Configurations
        run: flutter build ios --config-only --no-codesign

      - name: Setup App Store Connect API Key
        run: |
          printf "%s" "$APP_STORE_CONNECT_API_KEY_P8" > ios/fastlane/api_key.p8
        env:
          APP_STORE_CONNECT_API_KEY_P8: ${{ secrets.APP_STORE_CONNECT_API_KEY_P8 }}

      - name: Build IPA & Deploy to TestFlight
        run: bundle exec fastlane deploy_app_store
        working-directory: ios
        env:
          APPLE_ID: ${{ secrets.APPLE_ID }}
          APPLE_TEAM_ID: ${{ secrets.APPLE_TEAM_ID }}
          MATCH_GIT_URL: ${{ secrets.MATCH_GIT_URL }}
          MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
          APP_STORE_CONNECT_KEY_ID: ${{ secrets.APP_STORE_CONNECT_KEY_ID }}
          APP_STORE_CONNECT_ISSUER_ID: ${{ secrets.APP_STORE_CONNECT_ISSUER_ID }}
          API_BASE_URL: ${{ secrets.API_BASE_URL_UAT }}
          RELEASE_NOTES: ${{ env.RELEASE_NOTES }}

  # -------------------------------------------------------------
  # STAGE 3B: iOS Production (App Store Connect / TestFlight)
  # -------------------------------------------------------------
  ios-prod:
    name: iOS Production Deployment
    needs: test
    if: "!contains(github.ref, '-uat') && !contains(github.ref, '-beta')"
    runs-on: macos-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Extract Release Notes
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          TAG_MSG=$(git tag -l --format='%(contents)' ${{ github.ref_name }})
          if [ -z "$TAG_MSG" ] && [ "${{ github.ref_name }}" = "prod" ]; then
            PR_BODY=$(gh pr list --base prod --state merged --json body,mergeCommit --jq ".[] | select(.mergeCommit.oid == \"$GITHUB_SHA\") | .body")
            if [ -n "$PR_BODY" ]; then
              TAG_MSG="$PR_BODY"
            fi
          fi
          if [ -z "$TAG_MSG" ]; then
            TAG_MSG=$(git log -1 --pretty=%B)
          fi
          CLEANED_NOTES=$(echo "$TAG_MSG" | tr '\n' ' ')
          echo "RELEASE_NOTES=$CLEANED_NOTES" >> $GITHUB_ENV

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Setup SSH Key for Fastlane Match
        uses: webfactory/ssh-agent@v0.9.0
        with:
          ssh-private-key: ${{ secrets.MATCH_SSH_KEY }}

      - name: Setup Ruby 3.1
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true
          working-directory: ios

      - name: Install Flutter Dependencies
        run: flutter pub get

      - name: Generate Flutter iOS Configurations
        run: flutter build ios --config-only --no-codesign

      - name: Setup App Store Connect API Key
        run: |
          printf "%s" "$APP_STORE_CONNECT_API_KEY_P8" > ios/fastlane/api_key.p8
        env:
          APP_STORE_CONNECT_API_KEY_P8: ${{ secrets.APP_STORE_CONNECT_API_KEY_P8 }}

      - name: Build IPA & Deploy to App Store Connect
        run: bundle exec fastlane deploy_app_store
        working-directory: ios
        env:
          APPLE_ID: ${{ secrets.APPLE_ID }}
          APPLE_TEAM_ID: ${{ secrets.APPLE_TEAM_ID }}
          MATCH_GIT_URL: ${{ secrets.MATCH_GIT_URL }}
          MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
          APP_STORE_CONNECT_KEY_ID: ${{ secrets.APP_STORE_CONNECT_KEY_ID }}
          APP_STORE_CONNECT_ISSUER_ID: ${{ secrets.APP_STORE_CONNECT_ISSUER_ID }}
          API_BASE_URL: ${{ secrets.API_BASE_URL_PROD }}
          RELEASE_NOTES: ${{ env.RELEASE_NOTES }}

  # -------------------------------------------------------------
  # STAGE 4: Backend Version Synchronization Webhook
  # -------------------------------------------------------------
  notify-backend-uat:
    name: Notify Backend (UAT)
    needs: [android-uat, ios-uat]
    if: contains(github.ref, '-uat')
    runs-on: ubuntu-latest
    steps:
      - name: Report Active UAT Version to Backend
        env:
          API_BASE_URL: ${{ secrets.API_BASE_URL_UAT }}
          APP_VERSION_CI_TOKEN: ${{ secrets.APP_VERSION_CI_TOKEN }}
        run: |
          if [ -z "$APP_VERSION_CI_TOKEN" ]; then
            echo "APP_VERSION_CI_TOKEN is not configured. Skipping webhook."
            exit 0
          fi
          RAW_TAG="${{ github.ref_name }}"
          CLEAN_VERSION=$(echo "$RAW_TAG" | sed -E 's/^v//; s/-.*//')
          echo "Reporting UAT release version $CLEAN_VERSION to $API_BASE_URL/app-version..."
          curl -s -X POST "$API_BASE_URL/app-version" \
            -H "Content-Type: application/json" \
            -H "x-ci-token: $APP_VERSION_CI_TOKEN" \
            -d "{\"version\": \"$CLEAN_VERSION\"}"

  notify-backend-prod:
    name: Notify Backend (Production)
    needs: [android-prod, ios-prod]
    if: "!contains(github.ref, '-uat') && !contains(github.ref, '-beta')"
    runs-on: ubuntu-latest
    steps:
      - name: Report Active Production Version to Backend
        env:
          API_BASE_URL: ${{ secrets.API_BASE_URL_PROD }}
          APP_VERSION_CI_TOKEN: ${{ secrets.APP_VERSION_CI_TOKEN }}
        run: |
          if [ -z "$APP_VERSION_CI_TOKEN" ]; then
            echo "APP_VERSION_CI_TOKEN is not configured. Skipping webhook."
            exit 0
          fi
          RAW_TAG="${{ github.ref_name }}"
          CLEAN_VERSION=$(echo "$RAW_TAG" | sed -E 's/^v//; s/-.*//')
          echo "Reporting Production release version $CLEAN_VERSION to $API_BASE_URL/app-version..."
          curl -s -X POST "$API_BASE_URL/app-version" \
            -H "Content-Type: application/json" \
            -H "x-ci-token: $APP_VERSION_CI_TOKEN" \
            -d "{\"version\": \"$CLEAN_VERSION\"}"
```

---

### 5.2 Android Fastlane & Bundler Setup

#### Path: `android/Gemfile`
> ⚠️ **Must be located directly at `android/Gemfile` (never inside `android/fastlane/`)**.

```ruby
source "https://rubygems.org"

gem "fastlane"
gem "rubyzip", "~> 2.3.0"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
```

#### Path: `android/fastlane/Pluginfile`
```ruby
# Autogenerated by fastlane
# Do not delete this file if you use fastlane plugins

gem 'fastlane-plugin-firebase_app_distribution'
```

#### Path: `android/fastlane/Appfile`
```ruby
# Path is relative to the android/fastlane directory
json_key_file("fastlane-play-store.json")
package_name("{{PACKAGE_NAME}}") # e.g. com.example.app
```

#### Path: `android/fastlane/Fastfile`
```ruby
default_platform(:android)

platform :android do
  desc "Submit a new Internal Build to Firebase App Distribution"
  lane :distribute_firebase do
    api_base_url = ENV["API_BASE_URL"].to_s.strip
    sh("flutter build apk --release --dart-define=API_BASE_URL=#{api_base_url}")
    
    firebase_app_distribution(
      app: ENV["FIREBASE_ANDROID_APP_ID"],
      service_credentials_file: "firebase-distribution.json",
      groups: "internal-testers",
      release_notes: ENV["RELEASE_NOTES"] || "Build triggered via GitHub Actions tag push.",
      apk_path: "../build/app/outputs/flutter-apk/app-release.apk"
    )
  end

  desc "Deploy a new version to the Google Play Store"
  lane :deploy_play_store do
    api_base_url = ENV["API_BASE_URL"].to_s.strip
    sh("flutter build appbundle --release --dart-define=API_BASE_URL=#{api_base_url}")
    
    release_notes_text = ENV["RELEASE_NOTES"] || "Release update."
    changelog_dir = "metadata/android/vi-VN/changelogs"
    FileUtils.mkdir_p(changelog_dir)
    File.write("#{changelog_dir}/default.txt", release_notes_text)

    track = ENV["PLAY_STORE_TRACK"].to_s.strip
    track = "internal" if track.empty?

    upload_to_play_store(
      track: track,
      aab: "../build/app/outputs/bundle/release/app-release.aab",
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
      skip_upload_changelogs: true
    )
  end
end
```

---

### 5.3 iOS Fastlane & Match Code Signing Setup

#### Path: `ios/Gemfile`
> ⚠️ **Must be located directly at `ios/Gemfile` (never inside `ios/fastlane/`)**.

```ruby
source "https://rubygems.org"

gem "fastlane"
gem "rubyzip", "~> 2.3.0"
```

#### Path: `ios/fastlane/Appfile`
```ruby
# app_identifier accepts a single String
app_identifier("{{IOS_BUNDLE_IDENTIFIER}}") # e.g. com.example.app
apple_id(ENV["APPLE_ID"])
team_id(ENV["APPLE_TEAM_ID"])
```

#### Path: `ios/fastlane/Matchfile`
> ⚠️ **Critical Rule**: Never put dummy fallback URLs (like `git@github.com:YourOrg/...`) inside `Matchfile`. Always read cleanly from `ENV["MATCH_GIT_URL"]`.
> Notice that `app_identifier` in `Matchfile` accepts an **Array of strings `[...]`**.

```ruby
git_url(ENV["MATCH_GIT_URL"])
storage_mode("git")
type("appstore")
app_identifier(["{{IOS_BUNDLE_IDENTIFIER}}"]) # Array of strings!
username(ENV["APPLE_ID"])
clone_branch_directly(true)
```

#### Path: `ios/fastlane/Fastfile`
```ruby
require 'base64'

default_platform(:ios)

platform :ios do
  desc "Push a new build to App Store Connect / TestFlight"
  lane :deploy_app_store do
    setup_ci if ENV["CI"]
    
    # Authenticate via App Store Connect API Key
    api_key = app_store_connect_api_key(
      key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
      issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
      key_filepath: "fastlane/api_key.p8",
      in_house: false
    )
    
    # Synchronize certificates and profiles in read-only mode on CI
    match(
      type: "appstore",
      readonly: true,
      api_key: api_key
    )
    
    api_base_url = ENV["API_BASE_URL"].to_s.strip
    
    # Base64 encode dart defines for Xcode xcargs compatibility
    dart_defines = "API_BASE_URL=#{api_base_url}"
    encoded_defines = Base64.strict_encode64(dart_defines)

    # Resolve Swift Package Manager deployment target incompatibilities
    package_swift_path = "Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage/Package.swift"
    if File.exist?(package_swift_path)
      UI.message("Adjusting iOS deployment target in #{package_swift_path} to 15.0...")
      content = File.read(package_swift_path)
      content = content.gsub('.iOS("13.0")', '.iOS("15.0")')
      File.write(package_swift_path, content)
    end

    app_id = "{{IOS_BUNDLE_IDENTIFIER}}"
    profile_name = ENV["sigh_#{app_id}_appstore"] || "match AppStore #{app_id}"

    # Build the signed iOS IPA archive using gym
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      configuration: "Release",
      output_directory: "../build/ios/ipa",
      output_name: "{{APP_NAME}}.ipa",
      export_method: "app-store",
      xcargs: "DART_DEFINES=#{encoded_defines} DEVELOPMENT_TEAM=#{ENV['APPLE_TEAM_ID']} CODE_SIGN_STYLE=Manual PROVISIONING_PROFILE_SPECIFIER='#{profile_name}'"
    )
    
    # Locate upload-symbols binary dynamically from SPM checkouts if Crashlytics is used
    spm_binary_path = Dir["/Users/runner/Library/Developer/Xcode/DerivedData/Runner-*/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols"].first
    binary_option = {}
    if spm_binary_path && File.exist?(spm_binary_path)
      UI.message("Found SPM Crashlytics upload-symbols at: #{spm_binary_path}")
      binary_option[:binary_path] = spm_binary_path
    end

    # Upload dSYM files if Crashlytics GoogleService-Info.plist exists
    if File.exist?("Runner/GoogleService-Info.plist") && File.exist?("../build/ios/ipa/{{APP_NAME}}.app.dSYM.zip")
      upload_symbols_to_crashlytics(
        dsym_path: "../build/ios/ipa/{{APP_NAME}}.app.dSYM.zip",
        gsp_path: "Runner/GoogleService-Info.plist",
        **binary_option
      )
    end

    # Upload IPA to TestFlight
    upload_to_testflight(
      ipa: "../build/ios/ipa/{{APP_NAME}}.ipa",
      skip_waiting_for_build_processing: true,
      api_key: api_key,
      changelog: ENV["RELEASE_NOTES"] || "New release build."
    )
  end
end
```

---

### 5.4 Android Gradle Signing Configuration

In `android/app/build.gradle.kts` (or `build.gradle`), ensure the release signing configuration reads from environment variables on CI, with fallback to local `key.properties`:

```kotlin
import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        create("release") {
            // Priority: Environment variables (GitHub Actions) -> local key.properties
            val envKeystorePassword = System.getenv("ANDROID_KEYSTORE_PASSWORD")
            val envKeyAlias = System.getenv("ANDROID_KEY_ALIAS")
            val envKeyPassword = System.getenv("ANDROID_KEY_PASSWORD")

            storeFile = file("upload_keystore.jks")
            storePassword = envKeystorePassword ?: keystoreProperties.getProperty("storePassword")
            keyAlias = envKeyAlias ?: keystoreProperties.getProperty("keyAlias")
            keyPassword = envKeyPassword ?: keystoreProperties.getProperty("keyPassword")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}
```

---

## 6. Critical Agent Invariants & Battle-Tested Gotchas

Based on real-world debugging cycles across multiple projects, agents must review these specific operational traps:

| Trap Area | What Goes Wrong (Failure Mode) | The Mandatory Fix |
|---|---|---|
| **Ruby Version Incompatibility** | Runner fails with `CFPropertyList::Parser::ParserError` or `psych` undefined method errors when using default Ruby 3.3+. | Lock Ruby to `3.1` using `ruby/setup-ruby@v1` with `ruby-version: '3.1'` across all jobs. |
| **Misplaced `Gemfile`** | Placing `Gemfile` in `android/fastlane/` or `ios/fastlane/` causes Bundler cache to miss, running without fastlane plugins. | `Gemfile` **must always** be at root of `android/` and `ios/`. Fastlane plugins are imported via `eval_gemfile('fastlane/Pluginfile')`. |
| **Fastlane Match Git Clone Failure** | Leaving dummy default URLs like `git@github.com:YourOrg/...` in `Matchfile` causes `fastlane match` to clone a nonexistent repo when the secret is unset. | Use clean `git_url(ENV["MATCH_GIT_URL"])` without fallback literals. |
| **Matchfile vs Appfile Array Syntax** | `Matchfile` errors out with `app_identifier should be an Array` if passed a raw string. | In `Matchfile`: `app_identifier(["..."])` (array). In `Appfile`: `app_identifier("...")` (string). |
| **Dynamic Provisioning Profile Name** | Fastlane `build_app` fails signing with `Provisioning profile specifier not found`. | Always dynamically read the generated profile name from `ENV["sigh_#{bundle_id}_appstore"] || "match AppStore #{bundle_id}"`. |
| **Dart Defines in Xcode xcargs** | Special characters in API URLs (e.g. `https://api...`) break Xcode CLI parser if passed as raw `DART_DEFINES`. | Base64-encode the define string: `Base64.strict_encode64("API_BASE_URL=#{url}")` and pass `DART_DEFINES=#{encoded_defines}`. |
| **SPM Deployment Target Mismatch** | `FlutterGeneratedPluginSwiftPackage` errors with `target requires iOS 15.0 but Package.swift declares 13.0`. | Automatically patch `Package.swift` in the Fastlane lane before running `build_app`: replace `.iOS("13.0")` with `.iOS("15.0")`. |
| **Missing SPM dSYM upload-symbols** | Crashlytics fails to upload symbols because CocoaPods binary path does not exist under Swift Package Manager. | Dynamically scan `DerivedData` for `checkouts/firebase-ios-sdk/Crashlytics/upload-symbols` as demonstrated in `ios/fastlane/Fastfile`. |
| **Multi-line Release Notes Break GitHub Env** | Multi-line tag messages cause `GITHUB_ENV` variable truncation or syntax errors. | Cleanse newlines in shell before exporting: `TAG_MSG=$(echo "$TAG_MSG" | tr '\n' ' ')`. |

---

## 7. Pre-Flight Verification Checklist

Before pushing any release tag or handing off a new CI/CD setup, execute this checklist:

```markdown
- [ ] 1. Verified `android/Gemfile` and `ios/Gemfile` are committed to Git.
- [ ] 2. Verified `android/fastlane/Pluginfile` declares `fastlane-plugin-firebase_app_distribution`.
- [ ] 3. Verified `android/app/build.gradle.kts` release signingConfig matches the Keystore filename in CI.
- [ ] 4. Verified `ios/fastlane/Matchfile` has array syntax for `app_identifier`.
- [ ] 5. Verified `pubspec.yaml` version has been bumped (`X.Y.Z+build`).
- [ ] 6. Verified current working branch is fully merged into `dev` (or `prod`).
- [ ] 7. Checked that all 15+ GitHub Secrets from Section 2 are populated in repository settings.
- [ ] 8. Pushed tag matching pattern:
       - UAT: `git tag -a vX.Y.Z-uat -m "UAT Release Notes" && git push origin vX.Y.Z-uat`
       - Prod: `git tag -a vX.Y.Z -m "Production Release Notes" && git push origin vX.Y.Z`
```

---

## 8. Summary for AI Agents

When instructed to configure CI/CD on a new project:
1. **Never copy-paste hardcoded project IDs** (`gocsuaapp`, `AuthKey_SACK5N6YM4.p8`, etc.) from old projects.
2. **Scan the new project** for `applicationId`, `PRODUCT_BUNDLE_IDENTIFIER`, and Flutter SDK version.
3. **Scaffold the exact templates** from Section 5 with the extracted identifiers.
4. **Instruct the user** which GitHub Secrets need to be filled in according to the Type 1 table.
5. **Verify with a dry-run tag** (`v1.0.0-uat`) on the `dev` branch.
