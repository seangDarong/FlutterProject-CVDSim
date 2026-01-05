# 👁️ CVD Sim — Color Vision Deficiency Simulator

> Ever wondered how people with color blindness see the world? Now you can find out.

CVD Sim is a mobile app that lets you experience the world through the eyes of someone with color vision deficiency. Point your camera at anything and instantly see how it looks to people with different types of color blindness.

---

## 🎯 Why We Built This

Color blindness affects about **8% of men** and **0.5% of women** worldwide — that's roughly 300 million people! Yet most of us have no idea what they actually see.

I built this app to:

- Help designers check if their work is accessible
- Let teachers explain color blindness to students
- Give everyone a chance to understand what color-blind friends and family experience daily

---

## ✨ Features

| Feature                | What it does                                          |
| ---------------------- | ----------------------------------------------------- |
| **Live Camera Filter** | See CVD simulation in real-time through your camera   |
| **Multiple CVD Types** | Protanopia, Deuteranopia, Tritanopia + Normal vision  |
| **Compare Mode**       | Split-screen to compare two filter types side by side |
| **Capture & Save**     | Take photos and save them to your gallery             |
| **Switch Cameras**     | Works with front and back cameras                     |
| **Educational Info**   | Learn about each type of color blindness              |

---

## 🛠️ Tech Stack

- **Flutter** — Cross-platform UI framework
- **Dart** — Programming language
- **camera** — Access device cameras
- **path_provider** — Local file storage
- **uuid** — Unique filenames for saved images
- **go_router** — Navigation

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── data/
│   ├── cvd_types.dart        # CVD type definitions & matrices
│   └── mock_images.dart      # Sample data for testing
├── models/
│   ├── cvd_type.dart         # CVD type model
│   ├── image_session.dart    # Session state model
│   ├── simulation_mode.dart  # Single/dual mode enum
│   └── stored_image.dart     # Saved image model
├── ui/
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── landing_screen.dart
│   │   ├── simulator_screen.dart
│   │   └── gallery/
│   │       ├── gallery_screen.dart
│   │       └── image_screen.dart
│   └── widgets/
│       ├── filter_button.dart
│       ├── filter_row.dart
│       ├── image_viewer.dart
│       └── simulator/
│           ├── camera_control_bar.dart
│           ├── filter_info_card.dart
│           ├── mode_toggle.dart
│           └── simulation_camera_section.dart
└── utils/
    ├── cvd_filters.dart      # Color matrix helpers
    └── image_storing.dart    # Save/load/delete images
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- iOS device/simulator or Android device/emulator
- A device with a camera (simulator cameras work too)

### Installation

```bash
# Clone the repo
git clone https://github.com/yourusername/cvd_sim.git
cd cvd_sim

# Install dependencies
flutter pub get

# Run on your device
flutter run
```

### iOS Setup

Add these to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to simulate color vision deficiency</string>
```

### Android Setup

Add these to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

---

## 🎨 How the Filters Work

The app applies **color transformation matrices** to the camera feed in real-time. Each CVD type has a specific 4x5 matrix that simulates how colors appear to someone with that condition.

```dart
// Example: Protanopia matrix
ColorFilter.matrix(protanopiaMatrix)
```

The magic happens in `ColorFiltered` widget wrapping the `CameraPreview` — Flutter handles the GPU-accelerated color transformation for us. Fast and smooth! ⚡

---

## 📸 Saving Images

When you capture an image:

1. Camera takes a picture → `XFile`
2. Read as bytes → `Uint8List`
3. Generate unique filename → `uuid.jpg`
4. Save to `Documents/images/` folder
5. Return `StoredImage` with metadata

All images stay on your device. No cloud uploads. Your photos, your privacy. 🔒

---

## 🤝 Contributing

Found a bug? Have an idea? Contributions are welcome!

1. Fork the repo
2. Create your branch (`git checkout -b feature/cool-feature`)
3. Commit changes (`git commit -m 'Add cool feature'`)
4. Push (`git push origin feature/cool-feature`)
5. Open a Pull Request

---

## 📝 License

MIT License — do whatever you want with it! Just don't blame me if something breaks 😄

---

## 🙏 Acknowledgments

- Color blindness simulation matrices based on research by Machado, Oliveira, and Fernandes
- Built for Mobile Development course, Year 3


**Made with ❤️ and Flutter**
