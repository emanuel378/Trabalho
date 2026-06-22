import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class GalaxiaPage extends StatefulWidget {
  const GalaxiaPage({super.key});

  @override
  State<GalaxiaPage> createState() => _GalaxiaPageState();
}

class _GalaxiaPageState extends State<GalaxiaPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09051E),

      body: Stack(
        children: [
          const _BackgroundGlow(),

          const _StarField(),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    "Galáxia",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                    ),
                  ),

                  ShaderMask(
                    shaderCallback:
                        (bounds) => const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 6, 245, 10),
                            Color(0xFF3E8BFF),
                          ],
                        ).createShader(bounds),

                    child: const Text(
                      "Vita",
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),

                    child: _GlassCard(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          // TROCAR DEPOIS
                         Image.asset(
 "lib/assets/images/orionTectron.png"
),

                          const SizedBox(height: 25),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: const [
                              _Icone(
                                Icons.smart_toy,
                                Color.fromARGB(255, 9, 144, 38),
                              ),

                              SizedBox(width: 28),

                              _Icone(
                                Icons.eco,
                                Colors.green,
                              ),

                              SizedBox(width: 28),

                              _Icone(
                                Icons.trending_up,
                                Colors.orange,
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 58,

                            child: ElevatedButton(
                              onPressed: () {},

                              style:
                                  ElevatedButton.styleFrom(
                                    elevation: 0,

                                    backgroundColor:
                                        Colors.transparent,

                                    shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                18,
                                              ),
                                        ),
                                  ),

                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        18,
                                      ),

                                  gradient:
                                      const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 1, 48, 5),
                                          Color.fromARGB(255, 21, 128, 2),
                                        ],
                                      ),

                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(255, 48, 196, 3)
                                          .withOpacity(
                                            .6,
                                          ),

                                      blurRadius: 25,
                                    ),
                                  ],
                                ),

                                child: Container(
                                  alignment:
                                      Alignment.center,

                                  child: const Text(
                                    "Escolher",

                                    style: TextStyle(
                                      color:
                                          Colors.white,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),

                    child: _GlassCard(
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback:
                                (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 14, 197, 47),

                                        Color.fromARGB(255, 1, 191, 45),
                                      ],
                                    ).createShader(
                                      bounds,
                                    ),

                            child: const Text(
                              "O Futuro nas\nSuas Mãos",

                              textAlign:
                                  TextAlign.center,

                              style: TextStyle(
                                fontSize: 26,
                                color:
                                    Colors.white,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          const Text(
                            "Saúde e bem-estar, com mundos que vão dos segredos do corpo humano aos avanços da biotecnologia.",

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(
                              color:
                                  Colors.white70,

                              height: 1.7,

                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(
            30,
          ),

      child: BackdropFilter(
        filter:
            ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),

        child: Container(
          padding:
              const EdgeInsets.all(
                24,
              ),

          decoration:
              BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                      30,
                    ),

                color: Colors.white
                    .withOpacity(.05),

                border: Border.all(
                  color:
                      Colors.cyan
                          .withOpacity(
                            .25,
                          ),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors
                        .cyan
                        .withOpacity(
                          .15,
                        ),

                    blurRadius:
                        35,
                  )
                ],
              ),

          child: child,
        ),
      ),
    );
  }
}

class _Icone extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _Icone(
    this.icon,
    this.color,
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: 58,
      height: 58,

      decoration:
          BoxDecoration(
            shape:
                BoxShape.circle,

            color:
                color.withOpacity(
                  .15,
                ),

            border:
                Border.all(
                  color:
                      color,
                ),
          ),

      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}

class _BackgroundGlow
    extends StatelessWidget {
  const _BackgroundGlow();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -50,

          child: glow(
            250,
            Colors.purple,
          ),
        ),

        Positioned(
          bottom: 80,
          left: -60,

          child: glow(
            220,
            Colors.cyan,
          ),
        ),
      ],
    );
  }

  Widget glow(
    double size,
    Color color,
  ) {
    return Container(
      width: size,
      height: size,

      decoration:
          BoxDecoration(
            shape:
                BoxShape.circle,

            boxShadow: [
              BoxShadow(
                color:
                    color.withOpacity(
                      .4,
                    ),

                blurRadius:
                    180,
              )
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
    BuildContext context,
  ) {
    return CustomPaint(
      size: MediaQuery.of(
        context,
      ).size,

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
    Size size,
  ) {
    final random =
        math.Random(
          20,
        );

    final paint =
        Paint();

    for (
      int i = 0;
      i < 150;
      i++
    ) {
      paint.color =
          Colors.white
              .withOpacity(
                .6,
              );

      canvas.drawCircle(
        Offset(
          random.nextDouble() *
              size.width,

          random.nextDouble() *
              size.height,
        ),

        random.nextDouble() *
            2,

        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    CustomPainter oldDelegate,
  ) =>
      false;
}


