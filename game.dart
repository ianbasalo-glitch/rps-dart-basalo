import 'dart:io';
/// these is the move that they used to the game.
const List<String> vdm = ['rock', 'paper', 'scissors'];

/// these print a title banner when the game is started.
void printBanner() {
  print('===== ROCK, PAPER, SCISSORS =====');
}

/// print 30 blank lines to hide the move for player 1.
void clearScreen() {
  for (int i = 0; i < 30; i++) {
    print('');
  }
}

///ask for the name player and gave default name if blank
String getPlayerName(int plyNumber) {
  stdout.write('Enter Player $plyNumber name: ');

  String? input = stdin.readLineSync();
  String? name = input?.trim();

  if (name == null || name.isEmpty) {
    print('(No name entered. Using "Player $plyNumber".)');
    return 'Player $plyNumber';
  }

  return name;
}

/// check if valid to move and return into lowercase.
String? validateMove(String? input) {
  if (input == null) {
    return null;
  }

  String move = input.trim().toLowerCase();

  if (vdm.contains(move)) {
    return move;
  }

  return null;
}

/// ask the player until he/she gave the valid move
String getMove(String PrName) {
  String? move;

  while (move == null) {
    stdout.write('$PrName, enter your move (rock/paper/scissors): ');

    String? input = stdin.readLineSync();
    move = validateMove(input);

    if (move == null) {
      print('Invalid move. Please type rock, paper, or scissors.');
    }
  }

  return move;
}

/// decide who win the round or draw
String? decideWinner(
  String plyerwanName,
  String plyerwanMove,
  String plyertoName,
  String plyertoMove,
) {
  if (plyerwanMove == plyertoMove) {
    return null;
  }

  if (plyerwanMove == 'rock' && plyertoMove == 'scissors') {
    return plyerwanName;
  } else if (plyerwanMove == 'rock' && plyertoMove == 'paper') {
    return plyertoName;
  } else if (plyerwanMove == 'paper' && plyertoMove == 'rock') {
    return plyerwanName;
  } else if (plyerwanMove == 'paper' && plyertoMove == 'scissors') {
    return plyertoName;
  } else if (plyerwanMove == 'scissors' && plyertoMove == 'paper') {
    return plyerwanName;
  } else {
    return plyertoName;
  }
}

void main() {
  printBanner();

  String P_wanName = getPlayerName(1);
  String P_toName = getPlayerName(2);

  int P_wanScore = 0;
  int P_toScore = 0;
  int R_Number = 1;

  String? P_Again;

  do {
    print('--- Round $R_Number ---');

    String playerOneMove = getMove(P_wanName);

    ///“Clear the screen so Player 2 can’t see Player 1 move.”
    clearScreen();

    String playerTwoMove = getMove(P_toName);

    print(
      '$P_wanName chose $playerOneMove. '
      '$P_toName chose $playerTwoMove.',
    );

    String? winner = decideWinner(
      P_wanName,
      playerOneMove,
      P_toName,
      playerTwoMove,
    );

    if (winner == P_wanName) {
      P_wanScore++;
    } else if (winner == P_toName) {
      P_toScore++;
    }

    String result = winner ?? "It's a draw!";

    if (winner != null) {
      result = '$winner wins the round!';
    }

    print('Result: $result');

    print(
      'Score -> $P_wanName: $P_wanScore | '
      '$P_toName: $P_toScore',
    );

    stdout.write('Play again? (y/n): ');
    P_Again = stdin.readLineSync()?.trim().toLowerCase();

    R_Number++;
  } while (P_Again != 'n');

  print('===== FINAL SCORE =====');
  print(
    '$P_wanName: $P_wanScore | '
    '$P_toName: $P_toScore',
  );

  if (P_wanScore > P_toScore) {
    print('Overall winner: $P_wanName');
  } else if (P_toScore > P_wanScore) {
    print('Overall winner: $P_toName');
  } else {
    print("Overall winner: It's a tie!");
  }
}