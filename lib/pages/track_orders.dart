import 'package:flutter/material.dart';

class track_orders extends StatefulWidget {
  @override
  State<track_orders> createState() => _track_ordersState();
}

class _track_ordersState extends State<track_orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRACK ORDERS',
          style: TextStyle(
              letterSpacing: 2.0,
              fontSize: 20.0,
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 2.0,
                  offset: const Offset(0.0, 1.5),
                )
              ],
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xF73A2DCD),
        toolbarHeight: 100,
      ),
    );
  }
}
