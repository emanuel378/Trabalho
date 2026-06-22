// TODO Implement this library.
// lib/pages/questoes/tts_service.dart
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();

  Future<void> configurar() async {
    await _tts.setLanguage('pt-BR');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  Future<void> falar(String texto) async {
    await _tts.stop();
    await _tts.speak(texto);
  }

  Future<void> parar() async {
    await _tts.stop();
  }
}