import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;
  bool isInitialized = false;
  double _musicVolume = 1.0;
  double _sfxVolume = 0.6;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  Future<void> initialize() async {
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(_musicVolume);
    await _sfxPlayer.setVolume(_sfxVolume);
    isInitialized = true;
  }

  Future<void> playMusic(String assetPath) async {
    if (!_isMusicEnabled) return;

    await _musicPlayer.stop();
    await _musicPlayer.play(AssetSource(assetPath));
  }

  Future<void> playSfx(String assetPath) async {
    if (!_isSfxEnabled) return;

    await _sfxPlayer.stop();
    await _sfxPlayer.play(AssetSource(assetPath), volume: _sfxVolume);
  }

  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    _isSfxEnabled = !_isSfxEnabled;
    if (!_isMusicEnabled && !_isSfxEnabled) {
      _musicPlayer.stop();
      _sfxPlayer.stop();
    } else {
      _musicPlayer.resume();
      _sfxPlayer.resume();
    }
  }

  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
  }

  Future<void> setMusicVolume(double volume) async {
    _musicVolume = volume.clamp(0.0, 1.0);
    await _musicPlayer.setVolume(_musicVolume);
  }

  Future<void> setSfxVolume(double volume) async {
    _sfxVolume = volume.clamp(0.0, 1.0);
    await _sfxPlayer.setVolume(_sfxVolume);
  }

  Future<void> stopMusic() async {
    await _musicPlayer.stop();
  }

  Future<void> pauseMusic() async {
    await _musicPlayer.pause();
  }

  Future<void> resumeMusic() async {
    await _musicPlayer.resume();
  }

  void dispose() {
    _musicPlayer.dispose();
    _sfxPlayer.dispose();
  }
}
