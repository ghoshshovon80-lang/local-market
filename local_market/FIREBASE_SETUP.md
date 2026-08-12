# Local Market — Firebase Integration & Deployment Setup Guide

This document provides a comprehensive step-by-step setup guide for connecting **Firebase Cloud Backend Platform** to the **Local Market** Flutter application.

---

## 1. Overview & Free-Tier Portfolio Policy

Local Market uses a **₹0-cost open-source architecture** leveraging Firebase's generous Free Tier (Spark Plan):

| Service | Free Tier Allocation (Spark Plan) | Local Market Usage |
| :--- | :--- | :--- |
| **Firebase Auth** | Unlimited Email/Password sign-ins | Buyer & Seller authentication |
| **Cloud Firestore** | 50,000 reads/day, 20,000 writes/day, 1 GB storage | Shops, products, users & orders persistence |
| **Firebase Storage** | 5 GB storage, 1 GB transfer/day | Original seller product photo uploads |

---

## 2. Firebase Console Project Creation

1. Open the [Firebase Console](https://console.firebase.google.com/).
2. Click **Create a project** (or **Add project**).
3. Name your project `local-market-app`.
4. (Optional) Disable Google Analytics to keep setup fast and ₹0 cost.
5. Click **Create Project**.

---

## 3. Automated Configuration via FlutterFire CLI

1. Install the Firebase CLI in your system terminal:
   ```bash
   npm install -g firebase-tools
   firebase login
   ```

2. Install `flutterfire_cli`:
   ```bash
   dart pub global activate flutterfire_cli
   ```

3. Navigate to the Flutter project directory and run configuration:
   ```bash
   cd d:/Local_Market_workspace/local_market
   flutterfire configure --project=local-market-app
   ```
   *This command generates `lib/firebase_options.dart` automatically.*

---

## 4. Manual Android & iOS App Configuration

### Android Configuration (`google-services.json`)
1. In Firebase Console, go to **Project Settings** $\rightarrow$ **General**.
2. Under **Your apps**, select **Android**.
3. Package Name: `com.example.local_market` (matching `android/app/build.gradle`).
4. Download `google-services.json` and move it to:
   ```text
   local_market/android/app/google-services.json
   ```

### iOS Configuration (`GoogleService-Info.plist`)
1. In Firebase Console, select **iOS**.
2. Bundle ID: `com.example.localMarket` (matching Xcode Bundle Identifier).
3. Download `GoogleService-Info.plist` and move it to:
   ```text
   local_market/ios/Runner/GoogleService-Info.plist
   ```

---

## 5. Firebase Authentication Setup

1. In Firebase Console sidebar, click **Authentication** $\rightarrow$ **Get Started**.
2. Under **Sign-in method**, select **Email/Password**.
3. Enable **Email/Password** and click **Save**.

---

## 6. Cloud Firestore Database Setup

1. In Firebase Console sidebar, click **Firestore Database** $\rightarrow$ **Create Database**.
2. Select database location (e.g. `asia-south1` for India / local region).
3. Select **Start in production mode**.
4. In the **Rules** tab, paste the contents of [`firestore.rules`](file:///d:/Local_Market_workspace/local_market/firestore.rules):

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isAuthenticated() { return request.auth != null; }
    function isOwner(userId) { return isAuthenticated() && request.auth.uid == userId; }

    match /users/{userId} {
      allow read: if isAuthenticated();
      allow create, update: if isOwner(userId);
    }
    match /shops/{shopId} {
      allow read: if true;
      allow create, update, delete: if isAuthenticated();
    }
    match /products/{productId} {
      allow read: if true;
      allow create, update, delete: if isAuthenticated();
    }
    match /orders/{orderId} {
      allow read, create, update: if isAuthenticated();
    }
  }
}
```
5. Click **Publish**.

---

## 7. Firebase Storage Setup

1. In Firebase Console sidebar, click **Storage** $\rightarrow$ **Get Started**.
2. Select **Start in production mode** and choose your bucket region.
3. In the **Rules** tab, paste the contents of [`storage.rules`](file:///d:/Local_Market_workspace/local_market/storage.rules):

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /products/{shopId}/{fileName} {
      allow read: if true;
      allow write: if request.auth != null 
                   && request.resource.size < 5 * 1024 * 1024
                   && request.resource.contentType.matches('image/.*');
    }
  }
}
```
4. Click **Publish**.

---

## 8. Open Source Security & Git Protection

The following private secrets and credentials **MUST NEVER BE COMMITTED TO GITHUB**:

```text
# Excluded in .gitignore
google-services.json
GoogleService-Info.plist
firebase_options.dart
*.pem
*.p12
service-account.json
```

---

## 9. Running Tests & Offline Development Fallback

The project features a **safe fallback architecture**:
- When `AppConfig.useFirebase = false` (default during unit tests), mock repositories run seamlessly offline.
- When `AppConfig.useFirebase = true` (after `FirebaseService.instance.initializeFirebase()`), production Firestore and Storage APIs execute.

To run analyzer and tests:
```bash
flutter analyze
flutter test
```
