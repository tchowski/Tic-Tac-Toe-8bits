part of 'game_selection_screen_cubit.dart';

enum GameSelectionScreenMode { twoPlayer, onePlayer }

enum GameSelectionScreenDifficulty { easy, medium, hard }

sealed class GameSelectionScreenState extends Equatable {
  const GameSelectionScreenState({
    this.mode = GameSelectionScreenMode.onePlayer,
    this.difficulty = GameSelectionScreenDifficulty.easy,
  });

  final GameSelectionScreenMode mode;
  final GameSelectionScreenDifficulty difficulty;

  @override
  List<Object> get props => [mode, difficulty];
}

final class GameSelectionScreenInitial extends GameSelectionScreenState {}

final class GameSelectionChangeMode extends GameSelectionScreenState {
  const GameSelectionChangeMode({required super.mode, required super.difficulty});
}

final class GameSelectionChangeDifficulty extends GameSelectionScreenState {
  const GameSelectionChangeDifficulty({required super.difficulty, required super.mode});
}
