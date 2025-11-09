import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_selection_screen_state.dart';

class GameSelectionScreenCubit extends Cubit<GameSelectionScreenState> {
  GameSelectionScreenCubit() : super(GameSelectionScreenInitial());

  void setMode(GameSelectionScreenMode mode) {
    emit(GameSelectionChangeMode(mode: mode, difficulty: state.difficulty));
  }

  void setDifficulty(GameSelectionScreenDifficulty difficulty) {
    emit(GameSelectionChangeDifficulty(difficulty: difficulty, mode: state.mode));
  }
}
