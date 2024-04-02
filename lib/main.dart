import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _MiPaginaState(),
    );
  }
}

class _MiPaginaState extends StatefulWidget {
  @override
  State<_MiPaginaState> createState() => _MiPaginaStateState();
}

class _MiPaginaStateState extends State<_MiPaginaState> {
  final colorStream = StreamController<Color>();
  int counter = -1;
  final List<Color> colorList = [
    Colors.black,
    Colors.yellow,
    Colors.green,
  ];

  @override
  void dispose() {
    colorStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: colorStream.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoadingWidget();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return const Text('Fin del Stream 😮');
            }
            return Container(
              height: 150,
              width: 150,
              color: snapshot.data,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.color_lens),
        onPressed: () {
          //* Añadir informacion al stream
          //colorStream.sink.add(Colors.blue);
          counter++;
          print(counter);
          if (colorList.length > counter) {
            colorStream.sink.add(colorList[counter]);
            print(colorList[counter]);
          } else {
            colorStream.close();
          }
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Espernado clicks...'),
        SizedBox(
          height: 20,
        ),
        CircularProgressIndicator()
      ],
    );
  }
}
