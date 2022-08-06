import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      color: Colors.blue,
      child: Image.asset('lib/assets/images/flappys.png'),
    );
  }
}
