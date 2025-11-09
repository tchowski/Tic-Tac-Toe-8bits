import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';

void main() {
  group('GameBoardState', () {
    test('initial state has empty board and cross player starts', () {
      final state = GameBoardState.initial();

      expect(state.board.length, 9);
      expect(state.board.every((piece) => piece == GamePiece.none), true);
      expect(state.currentPlayer, GamePlayer.cross);
      expect(state.winner, null);
      expect(state.isDraw, false);
    });

    test('copyWith updates only specified fields', () {
      final initialState = GameBoardState.initial();
      final updatedBoard = List<GamePiece>.from(initialState.board);
      updatedBoard[0] = GamePiece.cross;

      final newState = initialState.copyWith(
        board: updatedBoard,
        currentPlayer: GamePlayer.circle,
      );

      expect(newState.board[0], GamePiece.cross);
      expect(newState.currentPlayer, GamePlayer.circle);
      expect(newState.winner, null);
      expect(newState.isDraw, false);
    });

    test('copyWith preserves unchanged fields', () {
      final initialState = GameBoardState.initial();
      final updatedBoard = List<GamePiece>.from(initialState.board);
      updatedBoard[0] = GamePiece.cross;

      final newState = initialState.copyWith(board: updatedBoard);

      expect(newState.currentPlayer, GamePlayer.cross);
      expect(newState.winner, null);
      expect(newState.isDraw, false);
    });

    test('copyWith sets winner', () {
      final initialState = GameBoardState.initial();
      final updatedBoard = List<GamePiece>.from(initialState.board);
      updatedBoard[0] = GamePiece.cross;
      updatedBoard[1] = GamePiece.cross;
      updatedBoard[2] = GamePiece.cross;

      final newState = initialState.copyWith(
        board: updatedBoard,
        winner: GamePlayer.cross,
      );

      expect(newState.winner, GamePlayer.cross);
    });

    test('copyWith sets isDraw', () {
      final initialState = GameBoardState.initial();
      final updatedBoard = List<GamePiece>.filled(9, GamePiece.cross, growable: false);

      final newState = initialState.copyWith(
        board: updatedBoard,
        isDraw: true,
      );

      expect(newState.isDraw, true);
    });

    test('board is unmodifiable', () {
      final state = GameBoardState.initial();

      expect(() => state.board.add(GamePiece.cross), throwsUnsupportedError);
      expect(() => state.board[0] = GamePiece.cross, throwsUnsupportedError);
    });

    test('props includes all state fields', () {
      final state = GameBoardState.initial();
      final updatedBoard = List<GamePiece>.from(state.board);
      updatedBoard[0] = GamePiece.cross;

      final state1 = state.copyWith(board: updatedBoard);
      final state2 = state.copyWith(board: updatedBoard);

      expect(state1.props, state2.props);
    });
  });

  group('GamePiece', () {
    test('has correct enum values', () {
      expect(GamePiece.none.index, 0);
      expect(GamePiece.cross.index, 1);
      expect(GamePiece.circle.index, 2);
    });
  });

  group('GamePlayer', () {
    test('has correct enum values', () {
      expect(GamePlayer.cross.index, 0);
      expect(GamePlayer.circle.index, 1);
    });
  });
}

