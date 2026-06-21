# Study Buddy Flutter Lab

Study Buddy is a simple two-screen Flutter app for the Mobile App Lab UI
Design assignment. The home screen introduces the app and navigates to a notes
screen. The notes screen lets the user type a study note, save it, and clear it
so the UI visibly updates during interaction.

## Widgets Used

This app uses both `StatelessWidget` and `StatefulWidget`. `StudyBuddyApp` and
`HomeScreen` are stateless widgets because they display fixed UI elements such
as the app title, icon, description, and navigation button. These widgets do not
store changing data internally. The `Navigator.push` call moves the user from
the home screen to the notes screen.

`NotesScreen` is a `StatefulWidget` because it manages dynamic content. It uses
a `TextField` with a `TextEditingController` to capture user input, a Save Note
button to update the displayed note, and a Clear Note button to reset the
screen. When either button is pressed, `setState()` updates `_noteText` and
rebuilds the widget so the current note shown on screen changes immediately.

## Screenshots to Submit

Capture these views after running the app:

1. Home screen with the Study Buddy title and Go to Notes button.
2. Notes screen before entering text.
3. Notes screen after typing a study note and pressing Save Note.
4. Optional: notes screen after pressing Clear Note.

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```
