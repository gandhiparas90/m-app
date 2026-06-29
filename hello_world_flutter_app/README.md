# Gesture Studio Flutter Lab

Gesture Studio is a two-screen Flutter app for the Gesture-Controlled Interface
lab. The home screen introduces the lab and opens the interactive gesture
screen. The gesture screen uses `GestureDetector` to handle tap, long press, and
horizontal swipe interactions.

## Gestures Used

The tap gesture changes the card color and updates the status message. This
gives immediate feedback and makes the interaction easy to understand. The long
press gesture toggles focus mode and displays a short SnackBar message, giving
the user visible confirmation that a less common gesture was recognized.

The horizontal swipe gesture moves between gesture cards. A small velocity
threshold prevents weak accidental swipes from changing the card, which is the
refinement made after testing. If the swipe is too light, the app updates the
status panel and asks the user to try a stronger swipe.

## Screenshots to Submit

Use the generated screenshots in the repository-level `screenshots` folder:

1. `gesture_lab_home.png`
2. `gesture_lab_initial.png`
3. `gesture_lab_tap.png`
4. `gesture_lab_long_press.png`
5. `gesture_lab_swipe.png`

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```
