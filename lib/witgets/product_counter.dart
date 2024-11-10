import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Product Counter'),
        ),
        body: Center(
          child: ProductCounter(),
        ),
      ),
    );
  }
}

class ProductCounter extends StatefulWidget {
  const ProductCounter({super.key});

  @override
  _ProductCounterState createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrementCounter,
          ),
          Text(
            '$_counter',
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _incrementCounter,
          ),
        ],
      ),
    );
  }
}
