# CyberLog – Named Routes Navigation (Session 6)

## 📌 Assignment Overview

This project demonstrates **Named Routes navigation in Flutter**, which is used for structured navigation in larger applications (similar to website URLs).

The app contains **three screens**:

* Screen A
* Screen B
* Screen C

Navigation between screens is handled using **Navigator.pushNamed()**.

---

## 🚀 Features Implemented

* Multiple screens created using StatelessWidget
* Named routes defined inside `MaterialApp`
* Navigation using route names instead of `MaterialPageRoute`
* Clean and simple UI structure

---

## 🧭 Navigation Flow

* Screen A → Screen B
* Screen B → Screen C

Navigation is done using:

```
Navigator.pushNamed(context, '/screenB');
Navigator.pushNamed(context, '/screenC');
```

---

## 🛠 Technologies Used

* Flutter
* Dart
* Material UI

---

## ▶ How to Run the App

1. Clone the repository
2. Open the project in Android Studio or VS Code
3. Start an Android Emulator
4. Run the command:

```
flutter run
```

---

## 📚 What I Learned

* Difference between direct navigation and named routes
* How named routes help in managing navigation for large apps
* Proper structure of routes in `MaterialApp`

---

## 👤 Author

**Akash Torane**
