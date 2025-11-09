import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:injectable/injectable.dart';
import '../managers/audio_manager.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
  if (!getIt.isRegistered<AudioManager>()) {
    getIt.registerLazySingleton<AudioManager>(() => AudioManager());
  }
}
