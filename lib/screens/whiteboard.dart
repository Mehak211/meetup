import 'package:flutter/material.dart';
import 'package:whiteboard/whiteboard.dart';

class Whiteboard extends StatefulWidget {
  const Whiteboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WhiteboardScreenState createState() => _WhiteboardScreenState();
}

class _WhiteboardScreenState extends State {
  late WhiteBoardController whiteBoardController;

  @override
  void initState() {
    super.initState();
    whiteBoardController = WhiteBoardController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whiteboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: WhiteBoard(
                backgroundColor: Colors.white,
                controller: whiteBoardController,
                strokeWidth: 5,
                strokeColor: const Color.fromARGB(255, 76, 144, 175),
                isErasing: false,
                onRedoUndo: (t, m) {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    whiteBoardController.clear();
                  },
                  child: Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    whiteBoardController.redo();
                  },
                  child: Text('Redo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    whiteBoardController.undo();
                  },
                  child: Text('Undo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
