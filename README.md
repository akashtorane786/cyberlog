# CyberLog 📱🔐

CyberLog is a Flutter-based portfolio application developed as part of classroom and portfolio assignments.  
The app focuses on **cyber awareness**, **local storage**, and **Android permission handling** following modern Android guidelines.

---

## 🚀 Features

### ✅ Session 9
- Save user preferences locally using SharedPreferences
- Automatically load saved settings on app startup
- Dark mode support

### ✅ Session 10 (Permission-Based Features)

#### 📷 Camera
- Camera permission declared in AndroidManifest
- Runtime permission request
- Opens device camera using Flutter camera plugin

#### 📁 Storage
- Storage permission declared
- Runtime permission handling implemented
- Permission status handled and shown to the user

#### 🌐 Internet
- Internet permission declared in AndroidManifest
- Used to fetch cyber tips dynamically via API

---

## 🛡 Permissions Used

| Permission | Purpose |
|----------|--------|
| CAMERA | Capture images using device camera |
| READ_EXTERNAL_STORAGE | Demonstrates storage permission handling |
| INTERNET | Fetch cyber tips from online source |

> Note: On Android 13+, storage permission is deprecated and may be auto-denied by the system. Runtime handling is still implemented as required.

---

## 🧠 Technical Stack

- Flutter
- Dart
- Android Studio
- camera plugin
- permission_handler
- SharedPreferences

---

## 📂 Project Structure

lib/
├── main.dart
├── camera_screen.dart
└── services/
├── app_settings_service.dart
└── cyber_tip_service.dart
## Session 11 Updates
- Implemented Flutter MethodChannel
- Fetched native Android device model
- Displayed device model and Android version in Settings page
