// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class I18n {
  I18n();

  static I18n? _current;

  static I18n get current {
    assert(
      _current != null,
      'No instance of I18n was loaded. Try to initialize the I18n delegate before accessing I18n.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I18n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I18n();
      I18n._current = instance;

      return instance;
    });
  }

  static I18n of(BuildContext context) {
    final instance = I18n.maybeOf(context);
    assert(
      instance != null,
      'No instance of I18n present in the widget tree. Did you add I18n.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static I18n? maybeOf(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  /// `PRESS START`
  String get splash_screen_press_start {
    return Intl.message(
      'PRESS START',
      name: 'splash_screen_press_start',
      desc:
          'Texte clignotant affiché sur le splash screen pour inviter à démarrer',
      args: [],
    );
  }

  /// `JOUEUR 1\nÀ TOI DE JOUER`
  String get game_status_player1_turn {
    return Intl.message(
      'JOUEUR 1\nÀ TOI DE JOUER',
      name: 'game_status_player1_turn',
      desc: 'Message affiché quand c\'est au tour du joueur 1',
      args: [],
    );
  }

  /// `JOUEUR 2\nÀ TOI DE JOUER`
  String get game_status_player2_turn {
    return Intl.message(
      'JOUEUR 2\nÀ TOI DE JOUER',
      name: 'game_status_player2_turn',
      desc: 'Message affiché quand c\'est au tour du joueur 2',
      args: [],
    );
  }

  /// `JOUEUR 1 GAGNE !`
  String get game_status_player1_wins {
    return Intl.message(
      'JOUEUR 1 GAGNE !',
      name: 'game_status_player1_wins',
      desc: 'Message affiché quand le joueur 1 gagne',
      args: [],
    );
  }

  /// `JOUEUR 2 GAGNE !`
  String get game_status_player2_wins {
    return Intl.message(
      'JOUEUR 2 GAGNE !',
      name: 'game_status_player2_wins',
      desc: 'Message affiché quand le joueur 2 gagne',
      args: [],
    );
  }

  /// `MATCH NUL !`
  String get game_status_draw {
    return Intl.message(
      'MATCH NUL !',
      name: 'game_status_draw',
      desc: 'Message affiché en cas d\'égalité',
      args: [],
    );
  }

  /// `L'IA RÉFLÉCHIT...`
  String get game_status_ai_turn {
    return Intl.message(
      'L\'IA RÉFLÉCHIT...',
      name: 'game_status_ai_turn',
      desc: 'Message affiché quand c\'est au tour de l\'IA',
      args: [],
    );
  }

  /// `REJOUER`
  String get game_action_restart {
    return Intl.message(
      'REJOUER',
      name: 'game_action_restart',
      desc: 'Libellé du bouton rejouer',
      args: [],
    );
  }

  /// `SÉLECTION DU JOUEUR`
  String get game_selection_title_player_select {
    return Intl.message(
      'SÉLECTION DU JOUEUR',
      name: 'game_selection_title_player_select',
      desc: 'Titre de la section de sélection du mode de jeu',
      args: [],
    );
  }

  /// `2 JOUEURS`
  String get game_selection_mode_two_player {
    return Intl.message(
      '2 JOUEURS',
      name: 'game_selection_mode_two_player',
      desc: 'Option pour jouer à deux joueurs',
      args: [],
    );
  }

  /// `1 JOUEUR`
  String get game_selection_mode_one_player {
    return Intl.message(
      '1 JOUEUR',
      name: 'game_selection_mode_one_player',
      desc: 'Option pour jouer contre l\'IA',
      args: [],
    );
  }

  /// `DIFFICULTÉ`
  String get game_selection_title_difficulty {
    return Intl.message(
      'DIFFICULTÉ',
      name: 'game_selection_title_difficulty',
      desc: 'Titre de la section de sélection de la difficulté',
      args: [],
    );
  }

  /// `FACILE`
  String get game_selection_difficulty_easy {
    return Intl.message(
      'FACILE',
      name: 'game_selection_difficulty_easy',
      desc: 'Option de difficulté facile',
      args: [],
    );
  }

  /// `MOYEN`
  String get game_selection_difficulty_medium {
    return Intl.message(
      'MOYEN',
      name: 'game_selection_difficulty_medium',
      desc: 'Option de difficulté moyenne',
      args: [],
    );
  }

  /// `DIFFICILE`
  String get game_selection_difficulty_hard {
    return Intl.message(
      'DIFFICILE',
      name: 'game_selection_difficulty_hard',
      desc: 'Option de difficulté difficile',
      args: [],
    );
  }

  /// `DÉMARRER`
  String get game_selection_action_start {
    return Intl.message(
      'DÉMARRER',
      name: 'game_selection_action_start',
      desc: 'Bouton pour démarrer le jeu',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I18n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
