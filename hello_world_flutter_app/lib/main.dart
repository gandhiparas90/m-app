import 'package:flutter/material.dart';

void main() {
  runApp(const GestureLabApp());
}

class GestureLabApp extends StatelessWidget {
  const GestureLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Studio'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.touch_app, size: 96, color: Colors.indigo),
            const SizedBox(height: 24),
            const Text(
              'Gesture-Controlled Interface',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Practice tap, long press, and swipe interactions with clear feedback.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const GestureScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.gesture),
              label: const Text('Open Gesture Lab'),
            ),
          ],
        ),
      ),
    );
  }
}

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  static const _cards = [
    GestureCardData(
      title: 'Tap Practice',
      body: 'Tap the card to cycle its color and status message.',
      icon: Icons.touch_app,
    ),
    GestureCardData(
      title: 'Swipe Practice',
      body: 'Swipe left or right to move between gesture cards.',
      icon: Icons.swipe,
    ),
    GestureCardData(
      title: 'Long Press Practice',
      body: 'Long press the card to toggle focus mode feedback.',
      icon: Icons.ads_click,
    ),
  ];

  static const _tapColors = [Colors.indigo, Colors.teal, Colors.deepOrange];

  int _cardIndex = 0;
  int _tapCount = 0;
  bool _focusMode = false;
  String _status = 'Ready: tap, long press, or swipe the card.';

  GestureCardData get _currentCard => _cards[_cardIndex];

  Color get _cardColor {
    if (_focusMode) {
      return Colors.black87;
    }
    return _tapColors[_tapCount % _tapColors.length];
  }

  void _handleTap() {
    setState(() {
      _tapCount += 1;
      _status =
          'Tap detected: color changed $_tapCount time${_tapCount == 1 ? '' : 's'}.';
    });
  }

  void _handleLongPress() {
    setState(() {
      _focusMode = !_focusMode;
      _status = _focusMode
          ? 'Long press detected: focus mode is on.'
          : 'Long press detected: focus mode is off.';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _focusMode ? 'Focus mode turned on' : 'Focus mode turned off',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleHorizontalSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 180) {
      setState(() {
        _status = 'Swipe was too light. Try a stronger left or right swipe.';
      });
      return;
    }

    setState(() {
      if (velocity < 0) {
        _cardIndex = (_cardIndex + 1) % _cards.length;
        _status = 'Swipe left detected: moved to ${_currentCard.title}.';
      } else {
        _cardIndex = (_cardIndex - 1 + _cards.length) % _cards.length;
        _status = 'Swipe right detected: moved to ${_currentCard.title}.';
      }
    });
  }

  void _resetGestures() {
    setState(() {
      _cardIndex = 0;
      _tapCount = 0;
      _focusMode = false;
      _status = 'Ready: tap, long press, or swipe the card.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Lab')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Try the Gestures',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap changes color, long press toggles focus mode, and swipe moves between cards.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                key: const Key('gestureCard'),
                onTap: _handleTap,
                onLongPress: _handleLongPress,
                onHorizontalDragEnd: _handleHorizontalSwipe,
                child: AnimatedContainer(
                  key: const Key('gestureCardContainer'),
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 240),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_currentCard.icon, color: Colors.white, size: 56),
                      const SizedBox(height: 16),
                      Text(
                        _currentCard.title,
                        key: const Key('gestureCardTitle'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _currentCard.body,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                key: const Key('statusPanel'),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _status,
                  key: const Key('gestureStatusText'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _resetGestures,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset Gestures'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GestureCardData {
  const GestureCardData({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final IconData icon;
}
