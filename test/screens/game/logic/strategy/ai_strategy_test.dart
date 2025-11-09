import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/strategy/ai_strategy.dart';

void main() {
  group('EasyAiStrategy', () {
    test('chooses random available move', () {
      const strategy = EasyAiStrategy();
      final random = Random(42);
      final state = GameBoardState.initial();

      final move = strategy.chooseMove(state, random);

      expect(move, isNotNull);
      expect(move, greaterThanOrEqualTo(0));
      expect(move, lessThan(9));
      expect(state.board[move!], GamePiece.none);
    });

    test('returns null when no moves available', () {
      const strategy = EasyAiStrategy();
      final random = Random();
      final board = List<GamePiece>.filled(9, GamePiece.cross, growable: false);
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, null);
    });

    test('chooses from available moves only', () {
      const strategy = EasyAiStrategy();
      final random = Random(123);
      final board = List<GamePiece>.from(GameBoardState.initial().board);
      board[0] = GamePiece.cross;
      board[1] = GamePiece.circle;
      board[2] = GamePiece.cross;
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.cross);

      final move = strategy.chooseMove(state, random);

      expect(move, isNotNull);
      expect([3, 4, 5, 6, 7, 8], contains(move));
    });
  });

  group('MediumAiStrategy', () {
    test('blocks opponent winning move', () {
      const strategy = MediumAiStrategy();
      final random = Random();
      final board = List<GamePiece>.from(GameBoardState.initial().board);
      board[0] = GamePiece.cross;
      board[1] = GamePiece.cross;
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, 2);
    });

    test('takes winning move when available', () {
      const strategy = MediumAiStrategy();
      final random = Random();
      final board = List<GamePiece>.from(GameBoardState.initial().board);
      board[0] = GamePiece.circle;
      board[1] = GamePiece.circle;
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, 2);
    });

    test('chooses random move when no immediate threat or win', () {
      const strategy = MediumAiStrategy();
      final random = Random(42);
      final state = GameBoardState.initial();

      final move = strategy.chooseMove(state, random);

      expect(move, isNotNull);
      expect(move, greaterThanOrEqualTo(0));
      expect(move, lessThan(9));
    });

    test('returns null when no moves available', () {
      const strategy = MediumAiStrategy();
      final random = Random();
      final board = List<GamePiece>.filled(9, GamePiece.cross, growable: false);
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, null);
    });
  });

  group('HardAiStrategy', () {
    test('chooses optimal move to prevent loss', () {
      const strategy = HardAiStrategy();
      final random = Random();
      final board = List<GamePiece>.from(GameBoardState.initial().board);
      board[0] = GamePiece.cross;
      board[1] = GamePiece.cross;
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, 2);
    });

    test('takes winning move when available', () {
      const strategy = HardAiStrategy();
      final random = Random();
      final board = List<GamePiece>.from(GameBoardState.initial().board);
      board[0] = GamePiece.circle;
      board[1] = GamePiece.circle;
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, 2);
    });

    test('chooses valid move when board is empty', () {
      const strategy = HardAiStrategy();
      final random = Random();
      final state = GameBoardState.initial();

      final move = strategy.chooseMove(state, random);

      expect(move, isNotNull);
      expect(move, greaterThanOrEqualTo(0));
      expect(move, lessThan(9));
    });

    test('returns valid move from available moves', () {
      const strategy = HardAiStrategy();
      final random = Random();
      final board = List<GamePiece>.from(GameBoardState.initial().board);
      board[0] = GamePiece.cross;
      board[4] = GamePiece.circle;
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, isNotNull);
      expect([1, 2, 3, 5, 6, 7, 8], contains(move));
    });

    test('returns null when no moves available', () {
      const strategy = HardAiStrategy();
      final random = Random();
      final board = List<GamePiece>.filled(9, GamePiece.cross, growable: false);
      final state = GameBoardState(board: board, currentPlayer: GamePlayer.circle);

      final move = strategy.chooseMove(state, random);

      expect(move, null);
    });
  });

  group('detectWinner', () {
    test('detects horizontal win for cross', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);
      board[0] = GamePiece.cross;
      board[1] = GamePiece.cross;
      board[2] = GamePiece.cross;

      final winner = detectWinner(board);

      expect(winner, GamePlayer.cross);
    });

    test('detects horizontal win for circle', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);
      board[3] = GamePiece.circle;
      board[4] = GamePiece.circle;
      board[5] = GamePiece.circle;

      final winner = detectWinner(board);

      expect(winner, GamePlayer.circle);
    });

    test('detects vertical win', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);
      board[0] = GamePiece.cross;
      board[3] = GamePiece.cross;
      board[6] = GamePiece.cross;

      final winner = detectWinner(board);

      expect(winner, GamePlayer.cross);
    });

    test('detects diagonal win (top-left to bottom-right)', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);
      board[0] = GamePiece.circle;
      board[4] = GamePiece.circle;
      board[8] = GamePiece.circle;

      final winner = detectWinner(board);

      expect(winner, GamePlayer.circle);
    });

    test('detects diagonal win (top-right to bottom-left)', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);
      board[2] = GamePiece.cross;
      board[4] = GamePiece.cross;
      board[6] = GamePiece.cross;

      final winner = detectWinner(board);

      expect(winner, GamePlayer.cross);
    });

    test('returns null when no winner', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);
      board[0] = GamePiece.cross;
      board[1] = GamePiece.circle;

      final winner = detectWinner(board);

      expect(winner, null);
    });

    test('returns null for empty board', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);

      final winner = detectWinner(board);

      expect(winner, null);
    });
  });

  group('availableMoves', () {
    test('returns all indices for empty board', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);

      final moves = availableMoves(board);

      expect(moves.length, 9);
      expect(moves, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
    });

    test('returns only empty indices', () {
      final board = List<GamePiece>.filled(9, GamePiece.none, growable: false);
      board[0] = GamePiece.cross;
      board[1] = GamePiece.circle;
      board[2] = GamePiece.cross;

      final moves = availableMoves(board);

      expect(moves.length, 6);
      expect(moves, [3, 4, 5, 6, 7, 8]);
    });

    test('returns empty list when board is full', () {
      final board = List<GamePiece>.filled(9, GamePiece.cross, growable: false);

      final moves = availableMoves(board);

      expect(moves, isEmpty);
    });
  });

  group('pieceForPlayer', () {
    test('returns cross for cross player', () {
      expect(pieceForPlayer(GamePlayer.cross), GamePiece.cross);
    });

    test('returns circle for circle player', () {
      expect(pieceForPlayer(GamePlayer.circle), GamePiece.circle);
    });
  });
}
