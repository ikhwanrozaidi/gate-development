import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Here! at Page 1');

    return const Material(
        color: Colors.green, child: Center(child: Text('Page 1')));
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Here! at Page 2');

    return const Material(
        color: Colors.red, child: Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Here! at Page 3');

    return const Material(
        color: Colors.blue, child: Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
        color: Colors.white, child: Center(child: Text('Page 4')));
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
        color: Colors.white, child: Center(child: Text('Page 5')));
  }
}
