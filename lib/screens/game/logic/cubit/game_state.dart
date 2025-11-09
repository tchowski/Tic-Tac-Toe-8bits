import 'package:equatable/equatable.dart';

enum GamePiece { none, cross, circle }

enum GamePlayer { cross, circle }

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => const [];
}

final class GameBoardState extends GameState {
  GameBoardState({required List<GamePiece> board, required this.currentPlayer, this.winner, this.isDraw = false})
    : board = List<GamePiece>.unmodifiable(board);

  factory GameBoardState.initial() => GameBoardState(
    board: List<GamePiece>.filled(9, GamePiece.none, growable: false),
    currentPlayer: GamePlayer.cross,
  );

  final List<GamePiece> board;
  final GamePlayer currentPlayer;
  final GamePlayer? winner;
  final bool isDraw;

  GameBoardState copyWith({List<GamePiece>? board, GamePlayer? currentPlayer, GamePlayer? winner, bool? isDraw}) {
    return GameBoardState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: winner ?? this.winner,
      isDraw: isDraw ?? this.isDraw,
    );
  }

  @override
  List<Object?> get props => [
    board.map((piece) => piece.index).toList(growable: false),
    currentPlayer,
    winner ?? 'none',
    isDraw,
  ];
}
