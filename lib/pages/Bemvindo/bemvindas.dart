import 'package:flutter/material.dart';
import 'dart:math' as math;

class BemvindasPage extends StatefulWidget {
  const BemvindasPage({super.key});

  @override
  State<BemvindasPage> createState() =>
      _BemvindasPageState();
}

class _BemvindasPageState
    extends State<BemvindasPage>
    with TickerProviderStateMixin {

  late AnimationController _fadeController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _fadeController =
        AnimationController(
      vsync: this,
      duration:
          const Duration(
        milliseconds: 900,
      ),
    );

    _fadeIn =
        Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(
        0xFF070B1E,
      ),

      body: Stack(

        children: [

          const _StarField(),

          SafeArea(

            child:
                FadeTransition(

              opacity:
                  _fadeIn,

              child:
                  Padding(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 32,
                ),

                child:
                    Column(

                  children: [

                    const Spacer(),

                    const Text(

                      'A aventura\ncomeça agora',

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(

                        fontFamily:
                            'Poppins',

                        fontWeight:
                            FontWeight.w400,

                        fontSize:
                            32,

                        height:
                            1.2,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    // ORION

                    Container(

                      width: 380,

                      height: 380,

                      decoration:
                          BoxDecoration(

                        boxShadow: [

                          BoxShadow(

                            color:
                                const Color(
                              0xFF00CFFF,
                            ).withOpacity(
                              0.20,
                            ),

                            blurRadius:
                                80,

                            spreadRadius:
                                8,
                          ),

                        ],
                      ),

                      child:
                          Image.asset(

                        'lib/assets/images/orionAcenando.png',

                        fit:
                            BoxFit.contain,
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    const Text(

                      'Astro Lume',

                      style:
                          TextStyle(

                        fontFamily:
                            'Gugi',

                        fontSize:
                            42,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    RichText(

                      text:
                          const TextSpan(

                        children: [

                          TextSpan(

                            text:
                                'É sua jornada. ',

                            style:
                                TextStyle(

                              fontFamily:
                                  'Poppins',

                              color:
                                  Colors.white70,

                              fontSize:
                                  14,
                            ),
                          ),

                          TextSpan(

                            text:
                                'Brilhe!',

                            style:
                                TextStyle(

                              fontFamily:
                                  'Poppins',

                              fontWeight:
                                  FontWeight.w700,

                              color:
                                  Color(
                                0xFF00CFFF,
                              ),

                              fontSize:
                                  14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    SizedBox(

                      width:
                          double.infinity,

                      height:
                          58,

                      child:
                          ElevatedButton(

                        onPressed:
                            () {

                          Navigator.pushNamed(
                            context,
                            '/cadastro',
                          );
                        },

                        style:
                            ElevatedButton.styleFrom(

                          elevation:
                              0,

                          backgroundColor:
                              const Color(
                            0xFF00CFFF,
                          ),

                          foregroundColor:
                              const Color(
                            0xFF070B1E,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        child:
                            const Text(

                          'Criar conta',

                          style:
                              TextStyle(

                            fontFamily:
                                'Poppins',

                            fontWeight:
                                FontWeight.w700,

                            fontSize:
                                18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    SizedBox(

                      width:
                          double.infinity,

                      height:
                          58,

                      child:
                          OutlinedButton(

                        onPressed:
                            () {

                          Navigator.pushNamed(
                            context,
                            '/login',
                          );
                        },

                        style:
                            OutlinedButton.styleFrom(

                          side:
                              const BorderSide(

                            color:
                                Colors.white24,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        child:
                            const Text(

                          'Entrar',

                          style:
                              TextStyle(

                            fontFamily:
                                'Poppins',

                            fontWeight:
                                FontWeight.w700,

                            color:
                                Colors.white,

                            fontSize:
                                18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarField
    extends StatelessWidget {

  const _StarField();

  @override
  Widget build(
      BuildContext context) {

    return CustomPaint(

      size: Size(

        MediaQuery.of(
          context,
        ).size.width,

        MediaQuery.of(
          context,
        ).size.height,
      ),

      painter:
          _StarPainter(),
    );
  }
}

class _StarPainter
    extends CustomPainter {

  @override
  void paint(
      Canvas canvas,
      Size size) {

    final random =
        math.Random(
      42,
    );

    final paint =
        Paint();

    for (
      int i = 0;
      i < 120;
      i++
    ) {

      paint.color =
          Colors.white.withOpacity(
        random.nextDouble(),
      );

      canvas.drawCircle(

        Offset(

          random.nextDouble() *
              size.width,

          random.nextDouble() *
              size.height,
        ),

        random.nextDouble() *
                2 +
            0.5,

        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
          covariant CustomPainter oldDelegate) =>
      false;
}