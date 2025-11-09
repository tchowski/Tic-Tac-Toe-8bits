import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tic_tac_toc_8_bits/core/managers/audio_manager.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_cubit.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';
import 'package:tic_tac_toc_8_bits/screens/game_selection/cubit/game_selection_screen_cubit.dart';

class MockAudioManager implements AudioManager {
  String? lastPlayedSfx;

  @override
  bool get isMusicEnabled => true;

  @override
  bool get isSfxEnabled => true;

  @override
  bool isInitialized = false;

  @override
  double get musicVolume => 1.0;

  @override
  double get sfxVolume => 1.0;

  @override
  Future<void> initialize() async {
    isInitialized = true;
  }

  @override
  Future<void> playMusic(String assetPath) async {}

  @override
  Future<void> playSfx(String assetPath) async {
    lastPlayedSfx = assetPath;
  }

  @override
  void toggleMusic() {}

  @override
  void toggleSfx() {}

  @override
  Future<void> setMusicVolume(double volume) async {}

  @override
  Future<void> setSfxVolume(double volume) async {}

  @override
  Future<void> stopMusic() async {}

  @override
  Future<void> pauseMusic() async {}

  @override
  Future<void> resumeMusic() async {}

  @override
  void dispose() {}
}

void main() {
  group('GameCubit - Two Player Mode', () {
    late MockAudioManager mockAudioManager;

    setUp(() {
      mockAudioManager = MockAudioManager();
    });

    blocTest<GameCubit, GameState>(
      'emits initial state with empty board',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      expect: () => [],
      verify: (cubit) {
        final state = cubit.state as GameBoardState;
        expect(state.board.every((piece) => piece == GamePiece.none), true);
        expect(state.currentPlayer, GamePlayer.cross);
        expect(state.winner, null);
        expect(state.isDraw, false);
      },
    );

    blocTest<GameCubit, GameState>(
      'plays move at valid index',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) => cubit.playAt(0),
      expect:
          () => [
            isA<GameBoardState>()
                .having((state) => state.board[0], 'board[0]', GamePiece.cross)
                .having((state) => state.currentPlayer, 'currentPlayer', GamePlayer.circle),
          ],
      verify: (_) {
        expect(mockAudioManager.lastPlayedSfx, isNotNull);
      },
    );

    blocTest<GameCubit, GameState>(
      'alternates players after each move',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(0);
        cubit.playAt(1);
      },
      expect:
          () => [
            isA<GameBoardState>().having(
              (state) => state.currentPlayer,
              'currentPlayer after first move',
              GamePlayer.circle,
            ),
            isA<GameBoardState>()
                .having((state) => state.currentPlayer, 'currentPlayer after second move', GamePlayer.cross)
                .having((state) => state.board[1], 'board[1]', GamePiece.circle),
          ],
    );

    blocTest<GameCubit, GameState>(
      'does not play move at invalid index',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(10);
      },
      expect: () => [],
    );

    blocTest<GameCubit, GameState>(
      'does not play move on occupied cell',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(0);
        cubit.playAt(0);
      },
      expect: () => [isA<GameBoardState>()],
    );

    blocTest<GameCubit, GameState>(
      'detects winner for cross player',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(0);
        cubit.playAt(3);
        cubit.playAt(1);
        cubit.playAt(4);
        cubit.playAt(2);
      },
      expect:
          () => [
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>().having((state) => state.winner, 'winner', GamePlayer.cross),
          ],
    );

    blocTest<GameCubit, GameState>(
      'detects draw when board is full',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(0);
        cubit.playAt(1);
        cubit.playAt(2);
        cubit.playAt(4);
        cubit.playAt(3);
        cubit.playAt(5);
        cubit.playAt(7);
        cubit.playAt(6);
        cubit.playAt(8);
      },
      expect:
          () => [
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>().having((state) => state.isDraw, 'isDraw', true),
          ],
    );

    blocTest<GameCubit, GameState>(
      'does not allow moves after game ends',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(0);
        cubit.playAt(3);
        cubit.playAt(1);
        cubit.playAt(4);
        cubit.playAt(2);
        cubit.playAt(5);
      },
      expect:
          () => [
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
            isA<GameBoardState>(),
          ],
    );

    blocTest<GameCubit, GameState>(
      'resets game to initial state',
      build:
          () => GameCubit(
            GameSelectionScreenMode.twoPlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(0);
        cubit.reset();
      },
      expect:
          () => [
            isA<GameBoardState>(),
            isA<GameBoardState>()
                .having((state) => state.board.every((piece) => piece == GamePiece.none), 'all pieces are none', true)
                .having((state) => state.currentPlayer, 'currentPlayer', GamePlayer.cross),
          ],
    );
  });

  group('GameCubit - One Player Mode', () {
    late MockAudioManager mockAudioManager;

    setUp(() {
      mockAudioManager = MockAudioManager();
    });

    blocTest<GameCubit, GameState>(
      'allows AI to play after player move',
      build:
          () => GameCubit(
            GameSelectionScreenMode.onePlayer,
            GameSelectionScreenDifficulty.easy,
            audioManager: mockAudioManager,
          ),
      act: (cubit) {
        cubit.playAt(0);
      },
      wait: const Duration(milliseconds: 600),
      expect:
          () => [
            isA<GameBoardState>()
                .having((state) => state.board[0], 'board[0]', GamePiece.cross)
                .having((state) => state.currentPlayer, 'currentPlayer', GamePlayer.circle),
            isA<GameBoardState>().having(
              (state) => state.currentPlayer,
              'currentPlayer after AI move',
              GamePlayer.cross,
            ),
          ],
    );
  });
}
