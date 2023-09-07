import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_of_life/model/item_model.dart';
import 'package:game_of_life/store/atom/board_atoms.dart';
import 'package:game_of_life/store/reducer/board_reducers.dart';
import 'package:rx_notifier/rx_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BoardReducer reducer = BoardReducer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        updateCells();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RxBuilder(
        builder: (context) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: 500,
              width: 500,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: board.value.length, childAspectRatio: 1.0),
                itemCount: board.value.length * board.value[0].length,
                itemBuilder: (context, index) {
                  final row = index ~/ board.value.length;
                  final col = index % board.value.length;
                  return Container(
                    decoration: BoxDecoration(
                      color: board.value[row][col].isItemALive
                          ? Colors.green
                          : Colors.black,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text("Col $col Row $row"),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_timer.isActive) {
              _timer.cancel();
            } else {
              _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
                setState(() {
                  updateCells();
                });
              });
            }
          });
        },
        tooltip: 'Control',
        child: Icon(_timer.isActive ? Icons.pause : Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
