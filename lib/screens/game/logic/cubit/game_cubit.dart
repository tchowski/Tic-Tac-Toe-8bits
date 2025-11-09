import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../strategy/ai_strategy.dart';
import 'game_state.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_assets.dart';
import 'package:tic_tac_toc_8_bits/core/di/injection.dart';
import 'package:tic_tac_toc_8_bits/core/managers/audio_manager.dart';
import 'package:tic_tac_toc_8_bits/screens/game_selection/cubit/game_selection_screen_cubit.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this.mode, this.difficulty, {AudioManager? audioManager})
    : _aiStrategy = _buildStrategy(mode, difficulty),
      _audioManager = audioManager ?? getIt<AudioManager>(),
      super(GameBoardState.initial());

  static const _aiMoveDelay = Duration(milliseconds: 500);

  final GameSelectionScreenMode mode;
  final GameSelectionScreenDifficulty difficulty;
  final AiStrategy? _aiStrategy;
  final AudioManager _audioManager;
  final Random _random = Random();

  void playAt(int index) {
    final currentState = state;
    if (currentState is! GameBoardState) {
      return;
    }

    if (_isAiTurn(currentState)) {
      return;
    }

    if (currentState.winner != null || currentState.isDraw) {
      return;
    }

    if (!_isValidMove(currentState.board, index)) {
      return;
    }

    _playMoveSound(currentState.currentPlayer);

    final nextState = _stateAfterMove(currentState, index, currentState.currentPlayer);
    emit(nextState);
    _maybeTriggerAiMove(nextState);
  }

  void reset() {
    final resetState = GameBoardState.initial();
    emit(resetState);
    _maybeTriggerAiMove(resetState);
  }

  bool _isAiTurn(GameBoardState state) => _aiStrategy != null && state.currentPlayer == GamePlayer.circle;

  bool _isValidMove(List<GamePiece> board, int index) =>
      index >= 0 && index < board.length && board[index] == GamePiece.none;

  void _maybeTriggerAiMove(GameBoardState candidateState) {
    final strategy = _aiStrategy;
    if (strategy == null) {
      return;
    }

    if (candidateState.currentPlayer != GamePlayer.circle) {
      return;
    }

    if (candidateState.winner != null || candidateState.isDraw) {
      return;
    }

    Future.delayed(_aiMoveDelay, () {
      final latest = state;
      if (latest is! GameBoardState) {
        return;
      }

      if (latest.currentPlayer != GamePlayer.circle) {
        return;
      }

      if (latest.winner != null || latest.isDraw) {
        return;
      }

      final aiMove = strategy.chooseMove(latest, _random);
      if (aiMove == null || !_isValidMove(latest.board, aiMove)) {
        return;
      }
      _playMoveSound(GamePlayer.circle);

      final nextState = _stateAfterMove(latest, aiMove, GamePlayer.circle);
      emit(nextState);
      _maybeTriggerAiMove(nextState);
    });
  }

  GameBoardState _stateAfterMove(GameBoardState state, int index, GamePlayer player) {
    final updatedBoard = List<GamePiece>.from(state.board);
    updatedBoard[index] = pieceForPlayer(player);

    final winner = detectWinner(updatedBoard);
    if (winner != null) {
      return state.copyWith(board: updatedBoard, winner: winner, currentPlayer: player);
    }

    if (!updatedBoard.contains(GamePiece.none)) {
      return state.copyWith(board: updatedBoard, isDraw: true, currentPlayer: player);
    }

    final nextPlayer = player == GamePlayer.cross ? GamePlayer.circle : GamePlayer.cross;
    return state.copyWith(board: updatedBoard, currentPlayer: nextPlayer);
  }

  void _playMoveSound(GamePlayer player) {
    if (player == GamePlayer.cross) {
      _audioManager.playSfx(AppAssets.audioCrossSound);
    } else {
      _audioManager.playSfx(AppAssets.audioRoundSound);
    }
  }

  static AiStrategy? _buildStrategy(GameSelectionScreenMode mode, GameSelectionScreenDifficulty difficulty) {
    if (mode != GameSelectionScreenMode.onePlayer) {
      return null;
    }

    switch (difficulty) {
      case GameSelectionScreenDifficulty.easy:
        return const EasyAiStrategy();
      case GameSelectionScreenDifficulty.medium:
        return const MediumAiStrategy();
      case GameSelectionScreenDifficulty.hard:
        return const HardAiStrategy();
    }
  }
}
