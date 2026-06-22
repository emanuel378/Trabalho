import 'package:flutter/material.dart';

import 'pages/splash/splash.dart';
import 'pages/bemvindo/bemvindas.dart';
import 'pages/cadastro/cadastro.dart';
import 'pages/login/login.dart';
import 'pages/esqueci_senha/esqueci_senha.dart';

import 'pages/galaxia/galaxia_selecao.dart';
import 'pages/galaxia/galaxia_techtron.dart';

import 'pages/mapa/mapa_galaxia.dart';

import 'pages/questoes/Historia.dart';
import 'pages/questoes/quest01Explicacao.dart';
import 'pages/questoes/quest01Atv.dart';

import 'pages/IA/lua_ia.dart';
import 'pages/perfil/perfil.dart'; // ← import adicionado

void main() {
  runApp(const AstrolumApp());
}

class AstrolumApp extends StatelessWidget {
  const AstrolumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astrolume',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00CFFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash':             (ctx) => const SplashPage(),
        '/bemvindo':           (ctx) => const BemvindasPage(),
        '/cadastro':           (ctx) => const CadastroPage(),
        '/login':              (ctx) => const LoginPage(),
        '/esqueci-senha':      (ctx) => const EsqueciSenhaPage(),
        '/galaxia':            (ctx) => const GalaxiaSelecaoPage(),
        '/galaxia-techtron':   (ctx) => GalaxiaTechPage(),
        '/galaxia-vita':       (ctx) => GalaxiaVitaPage(),
        '/galaxia-commercium': (ctx) => GalaxiaCommerciumPage(),
        '/mapa':               (ctx) => const MapaGalaxiaPage(),
        '/historia':           (ctx) => const HistoriaPage(),
        '/quest01':            (ctx) => const Quest01ExplicacaoPage(),
        '/quest01-exp':        (ctx) => const Quest01ExplicacaoPage(),
        '/quest01-atv':        (ctx) => const Quest01AtvPage(),
        '/lua-ia':             (ctx) => const LuaIAPage(),
        '/perfil':             (ctx) => const PerfilPage(), // ← rota corrigida
      },
    );
  }
}