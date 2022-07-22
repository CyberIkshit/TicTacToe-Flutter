import 'package:flutter/material.dart';

import 'GameData.dart';

void main() {
  runApp(const MaterialApp(
    title: "Tic Tac Toe",
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameInfo game = GameInfo();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tic Tac Toe",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 16,
                  child: Icon(
                    Icons.person_outline,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  game.player1Turn ? "Player 1 (X)" : "Player 2 (O)",
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            IgnorePointer(
              ignoring: game.wonMsg.isNotEmpty,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: game.gameMatrix.asMap().entries.map((entryRow) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              entryRow.value.asMap().entries.map((entryCol) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                game.updateTurn(
                                    entryRow.key.toInt(), entryCol.key.toInt());
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                ),
                                height: 80,
                                width:
                                    (MediaQuery.of(context).size.width - 20) /
                                        3,
                                child: Text(
                                  entryCol.value == 1
                                      ? "X"
                                      : entryCol.value == 2
                                          ? "O"
                                          : "",
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                            );
                          }).toList());
                    }).toList()),
              ),
            ),
            game.wonMsg.isNotEmpty
                ? Text(
                    game.wonMsg,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : const SizedBox.shrink()
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () => setState(() {
            game.reset();
          }),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Text(
              "Reset Game",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
