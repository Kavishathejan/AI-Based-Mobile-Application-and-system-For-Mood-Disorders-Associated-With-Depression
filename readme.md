# Real-Time Alert System (JOYNEST)

This project is a real-time emotional monitoring and alerting system designed to support mental health awareness. It consists of three main components:

1. **JOYNEST Flutter App (Parent Interface)**
2. **Chrome Extension (Patient-side Keyword Detector)**
3. **Node.js Backend with WebSocket and Logging**

## 🔧 Features

- **Real-Time Keyword Detection**: Detects emotional or high-risk keywords searched by the patient on Chrome.
- **WebSocket Communication**: Sends detected keywords to the backend and then to the parent app.
- **Log Storage**: Captures keyword logs in a `log.json` file.
- **Parent Alerts**: Notifies the parent in the Flutter app when keywords like "sad", "pain", "depressed" are detected.
- **Firebase Integration**: Used for push notifications and optional authentication (Firebase setup required).

## 📂 Project Structure

real-time-alert-system/
│
├── joynest-app/ # Flutter Parent App
│ ├── lib/
│ ├── android/
│ ├── ios/
│ ├── pubspec.yaml
│ └── firebase_options.dart # ⚠️ Required for Firebase (Not included in repo)
│
├── word-extension-and-backend/
│ ├── backend/ # Node.js WebSocket + Logger
│ │ ├── server.js
│ │ └── log.json
│ ├── chrome-extension/ # Chrome Extension Files
│ │ ├── manifest.json
│ │ └── content.js


## 🛠️ Firebase Setup (Important)

This project uses Firebase for push notifications. To run the app, you must include the Firebase configuration files:

- For Flutter app:
  - `firebase_options.dart` (or use `flutterfire configure` to generate)
  - `google-services.json` for Android
  - `GoogleService-Info.plist` for iOS

These files are **not included** in this repository for security reasons.

### 🔐 Note:
> ⚠️ You must manually add the Firebase files (`firebase_options.dart`, `google-services.json`, etc.) after cloning this repo. Do not commit them to GitHub.

## 🧾 How to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/real-time-alert-system.git

cd word-extension-and-backend/backend
node server.js


cd joynest-app
flutter run
