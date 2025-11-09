import 'dart:math';

import '../cubit/game_state.dart';

sealed class AiStrategy {
  const AiStrategy();

  int? chooseMove(GameBoardState state, Random random);
}

class EasyAiStrategy extends AiStrategy {
  const EasyAiStrategy();

  @override
  int? chooseMove(GameBoardState state, Random random) {
    final available = availableMoves(state.board);
    if (available.isEmpty) {
      return null;
    }
    return available[random.nextInt(available.length)];
  }
}

class MediumAiStrategy extends AiStrategy {
  const MediumAiStrategy();

  @override
  int? chooseMove(GameBoardState state, Random random) {
    final available = availableMoves(state.board);
    if (available.isEmpty) {
      return null;
    }

    for (final index in available) {
      final board = List<GamePiece>.from(state.board);
      board[index] = GamePiece.circle;
      if (detectWinner(board) == GamePlayer.circle) {
        return index;
      }
    }

    for (final index in available) {
      final board = List<GamePiece>.from(state.board);
      board[index] = GamePiece.cross;
      if (detectWinner(board) == GamePlayer.cross) {
        return index;
      }
    }

    return available[random.nextInt(available.length)];
  }
}

class HardAiStrategy extends AiStrategy {
  const HardAiStrategy();

  @override
  int? chooseMove(GameBoardState state, Random random) {
    final available = availableMoves(state.board);
    if (available.isEmpty) {
      return null;
    }

    final board = List<GamePiece>.from(state.board);
    var bestScore = -1000;
    var bestMove = available.first;

    for (final index in available) {
      board[index] = GamePiece.circle;
      final score = _minimax(board, isMaximizing: false, depth: 0);
      board[index] = GamePiece.none;
      if (score > bestScore) {
        bestScore = score;
        bestMove = index;
      }
    }

    return bestMove;
  }

  int _minimax(List<GamePiece> board, {required bool isMaximizing, required int depth}) {
    final winner = detectWinner(board);
    if (winner != null) {
      if (winner == GamePlayer.circle) {
        return 10 - depth;
      }
      return depth - 10;
    }

    final available = availableMoves(board);
    if (available.isEmpty) {
      return 0;
    }

    if (isMaximizing) {
      var bestScore = -1000;
      for (final index in available) {
        board[index] = GamePiece.circle;
        final score = _minimax(board, isMaximizing: false, depth: depth + 1);
        board[index] = GamePiece.none;
        bestScore = max(bestScore, score);
      }
      return bestScore;
    } else {
      var bestScore = 1000;
      for (final index in available) {
        board[index] = GamePiece.cross;
        final score = _minimax(board, isMaximizing: true, depth: depth + 1);
        board[index] = GamePiece.none;
        bestScore = min(bestScore, score);
      }
      return bestScore;
    }
  }
}

GamePiece pieceForPlayer(GamePlayer player) => player == GamePlayer.cross ? GamePiece.cross : GamePiece.circle;

List<int> availableMoves(List<GamePiece> board) {
  final moves = <int>[];
  for (var i = 0; i < board.length; i++) {
    if (board[i] == GamePiece.none) {
      moves.add(i);
    }
  }
  return moves;
}

GamePlayer? detectWinner(List<GamePiece> board) {
  const winningCombos = <List<int>>[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (final combo in winningCombos) {
    final first = board[combo[0]];
    if (first == GamePiece.none) {
      continue;
    }

    final second = board[combo[1]];
    final third = board[combo[2]];
    if (first == second && first == third) {
      return first == GamePiece.cross ? GamePlayer.cross : GamePlayer.circle;
    }
  }

  return null;
}
