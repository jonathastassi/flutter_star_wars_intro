import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  const Star({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            spreadRadius: size,
            blurRadius: size,
            offset: const Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
