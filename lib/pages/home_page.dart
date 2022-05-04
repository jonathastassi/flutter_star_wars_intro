import 'package:flutter/material.dart';
import 'package:star_wars_intro_app/widgets/star.dart';
import 'dart:math' as math;

import 'package:star_wars_intro_app/widgets/star_wars_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final text = '''
It is a period of civil war.
Rebel spaceships, striking
from a hidden base, have won
their first victory against
the evil Galactic Empire.

During the battle, Rebel
spies managed to steal secret
plans to the Empire's
ultimate weapon, the DEATH
STAR, an armored space
station with enough power to
destroy an entire planet.

Pursued by the Empire's
sinister agents, Princess
Leia races home aboard her
starship, custodian of the
stolen plans that can save
her people and restore
freedom to the galaxy....''';

  late AnimationController _animationController;
  late Animation<double> _fontDecreaseAnimation;
  late Animation<double> _scrollAnimation;

  bool showButtonRepeat = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            showButtonRepeat = true;
          });
        }
      });

    _scrollAnimation = Tween<double>(begin: -0.9, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 1),
      ),
    );

    _fontDecreaseAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.03),
      ),
    );

    _animationController.forward();
  }

  double getRandomNumber(int max, double min) =>
      math.Random().nextInt(max) + min;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Wrap(
                children: List.generate(
                  2000,
                  (index) => Padding(
                    padding: EdgeInsets.fromLTRB(
                      getRandomNumber(80, 2),
                      getRandomNumber(80, 2),
                      getRandomNumber(80, 2),
                      getRandomNumber(80, 2),
                    ),
                    child: Star(
                      size: getRandomNumber(2, 1),
                    ),
                  ),
                ).toList(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (_, __) {
                  return StarWarsTitle(
                    width: 1620 * _fontDecreaseAnimation.value,
                  );
                },
              ),
            ),
            Positioned(
              top: -size.height,
              left: size.height * 0.48,
              right: size.height * 0.48,
              bottom: 0,
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(-0.9),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) {
                    return Stack(
                      children: [
                        Positioned(
                          bottom: (size.height * _scrollAnimation.value),
                          left: 0,
                          right: 0,
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'SFDistantGalaxy',
                              fontSize: 30,
                              height: 1.9,
                              color: Color(0xfff8b210),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: showButtonRepeat
          ? FloatingActionButton(
              backgroundColor: const Color(0xfff8b210),
              onPressed: () {
                setState(() {
                  showButtonRepeat = false;
                });
                _animationController.reset();
                _animationController.forward();
              },
              child: const Icon(
                Icons.replay_rounded,
              ),
            )
          : null,
    );
  }
}
