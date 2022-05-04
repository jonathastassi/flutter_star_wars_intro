import 'package:flutter/material.dart';

class StarWarsTitle extends StatelessWidget {
  const StarWarsTitle({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Text(
          'star\nwars',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Starjhol',
            color: Color(0xffffa600),
            height: 0.8,
          ),
        ),
      ),
    );
  }
}
