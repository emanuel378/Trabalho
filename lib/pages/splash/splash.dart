import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _star1Controller;
  late AnimationController _star2Controller;
  late AnimationController _star3Controller;
  late AnimationController _bgTransitionController;
  late AnimationController _logoController;

  late Animation<double> _star1Opacity;
  late Animation<double> _star2Opacity;
  late Animation<double> _star3Opacity;
  late Animation<double> _bgTransition;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoScale;

  int _phase = 1;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    _star1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _star1Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _star1Controller, curve: Curves.easeIn),
    );

    _star2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _star2Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _star2Controller, curve: Curves.easeInOut),
    );

    _star3Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _star3Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _star3Controller, curve: Curves.easeIn),
    );

    _bgTransitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _bgTransition = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgTransitionController, curve: Curves.easeInOut),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );
    _logoScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => _phase = 2);
    await _star1Controller.forward();
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() => _phase = 3);
    _star1Controller.reverse();
    await _star2Controller.forward();
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() => _phase = 4);
    _star2Controller.reverse();
    await _star3Controller.forward();
    await Future.delayed(const Duration(milliseconds: 200));

    _star3Controller.reverse();
    await _bgTransitionController.forward();

    setState(() => _phase = 5);
    await _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/bemvindo');    }
  }

  @override
  void dispose() {
    _star1Controller.dispose();
    _star2Controller.dispose();
    _star3Controller.dispose();
    _bgTransitionController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _star1Controller,
          _star2Controller,
          _star3Controller,
          _bgTransitionController,
          _logoController,
        ]),
        builder: (context, child) {
          final bgColor = Color.lerp(
            const Color(0xFF00CFFF),
            const Color(0xFF0A0E1A),
            _bgTransition.value,
          )!;

          return Container(
            width: double.infinity,
            height: double.infinity,
            color: bgColor,
            child: Center(
              child: _buildContent(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    if (_phase == 2) {
      return FadeTransition(
        opacity: _star1Opacity,
        child: Image.asset('lib/assets/images/estrelaSplash1.png', width: 80),
      );
    }
    if (_phase == 3) {
      return FadeTransition(
        opacity: _star2Opacity,
        child: Image.asset('lib/assets/images/estrelaSplash2.png', width: 120),
      );
    }
    if (_phase == 4) {
      return FadeTransition(
        opacity: _star3Opacity,
        child: Image.asset('lib/assets/images/estrelaSplash3.png', width: 90),
      );
    }
    if (_phase == 5) {
      return FadeTransition(
        opacity: _logoOpacity,
        child: ScaleTransition(
          scale: _logoScale,
          child: Image.asset('lib/assets/images/logo.png', width: 220),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}