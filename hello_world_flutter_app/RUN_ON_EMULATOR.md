# Running the Hello World Flutter App on an Emulator

This Flutter project was created with Flutter SDK 3.44.0 from:

`/Users/parasgandhi/Project/temp/flutter`

The app source is in `lib/main.dart` and displays a centered `Hello World`
message.

## Commands

From the project directory, run:

```bash
/Users/parasgandhi/Project/temp/flutter/bin/flutter pub get
/Users/parasgandhi/Project/temp/flutter/bin/flutter devices
/Users/parasgandhi/Project/temp/flutter/bin/flutter run
```

If multiple devices are listed, run with a specific device ID:

```bash
/Users/parasgandhi/Project/temp/flutter/bin/flutter run -d <device-id>
```

## Current Local Device Status

On this machine, Flutter detected Chrome and macOS desktop targets. Android
emulator testing is blocked because the Android SDK is not installed. iOS
simulator testing is blocked because a full Xcode installation is not selected;
the active developer directory is `/Library/Developer/CommandLineTools`.

To satisfy a strict Android or iOS simulator screenshot requirement, install
Android Studio with the Android SDK/emulator or install full Xcode, then run the
app with one of the commands above and capture a simulator screenshot.
