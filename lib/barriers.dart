import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  const MyBarrier({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0),
      width: 100,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(width: 10, color: Colors.green.shade900),
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
