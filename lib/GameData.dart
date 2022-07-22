enum gameStat { Player1Won, Player2Won, Tie, InProgress }

class GameInfo {
  String player1 = "";
  String player2 = "";
  bool player1Turn = true;
  String wonMsg = "";
  List<List<int>> gameMatrix = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];

  void updateTurn(int row, int column) {
    print('$row  $column');
    int player = player1Turn ? 1 : 2;
    if (gameMatrix[row][column] != 0) return;
    gameMatrix[row][column] = player;
    player1Turn = !player1Turn;
    gameStat result = checkGameWon(player);
    switch (result) {
      case gameStat.Player1Won:
        wonMsg = "Player1 won!";
        player1Turn = !player1Turn;
        break;
      case gameStat.Player2Won:
        wonMsg = "Player2 won!";
        player1Turn = !player1Turn;
        break;
      case gameStat.Tie:
        wonMsg = "Match Tie!";
        break;
    }
  }

  void reset() {
    wonMsg = "";
    gameMatrix = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];
  }

  gameStat checkGameWon(int player) {
    int j;
    for (int i = 0; i < 3; i++) {
      for (j = 0; j < 3; j++) {
        if (gameMatrix[i][j] == player)
          continue;
        else
          break;
      }
      if (j == 3) {
        return player == 1 ? gameStat.Player1Won : gameStat.Player2Won;
      }
      for (j = 0; j < 3; j++) {
        if (gameMatrix[j][i] == player)
          continue;
        else
          break;
      }
      if (j == 3) {
        return player == 1 ? gameStat.Player1Won : gameStat.Player2Won;
      }
    }
    for (j = 0; j < 3; j++) {
      if (gameMatrix[j][j] == player)
        continue;
      else
        break;
    }
    if (j == 3) {
      return player == 1 ? gameStat.Player1Won : gameStat.Player2Won;
    }
    for (j = 0; j < 3; j++) {
      if (gameMatrix[j][2 - j] == player)
        continue;
      else
        break;
    }
    if (j == 3) {
      return player == 1 ? gameStat.Player1Won : gameStat.Player2Won;
    }
    return isGameComplete();
  }

  gameStat isGameComplete() {
    bool hasEnded = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (gameMatrix[i][j] != 0) hasEnded = false;
      }
    }
    return hasEnded ? gameStat.Tie : gameStat.InProgress;
  }
}
