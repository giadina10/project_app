import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeaturesProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  // Definisci le chiavi per le SharedPreferences
  static const String _fullNameKey = 'fullName';
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _ageKey = 'age';
  static const String _weightKey = 'weight';
  static const String _bsKey = 'bs';
  static const String _isPregnantKey = 'isPregnant';
  static const String _isSportyKey = 'isSporty';
  static const String _activityLevelKey = 'activityLevel';
  static const String _avatarKey = 'avatar';  // Nuova chiave per l'avatar

  // Variabili per memorizzare i valori
  String _fullName = '';
  String get fullName => _fullName;

  String _name = '';
  String get name => _name;

  String _email = '';
  String get email => _email;

  String _age = '';
  String get age => _age;

  String _weight = '';
  String get weight => _weight;

  int _bs = 0;
  int get bs => _bs;

  bool _isPregnant = false;
  bool get isPregnant => _isPregnant;

  bool _isSporty = false;
  bool get isSporty => _isSporty;

  double _activityLevel = 5;
  double get activityLevel => _activityLevel;

  String _avatar = '';  // Nuova variabile per l'avatar
  String get avatar => _avatar;

  FeaturesProvider() {
    _loadPrefs();
  }

  // Metodo per caricare le preferenze
  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _fullName = _prefs?.getString(_fullNameKey) ?? '';
    _name = _prefs?.getString(_nameKey) ?? '';
    _email = _prefs?.getString(_emailKey) ?? '';
    _age = _prefs?.getString(_ageKey) ?? '';
    _weight = _prefs?.getString(_weightKey) ?? '';
    _bs = _prefs?.getInt(_bsKey) ?? 0;
    _isPregnant = _prefs?.getBool(_isPregnantKey) ?? false;
    _isSporty = _prefs?.getBool(_isSportyKey) ?? false;
    _activityLevel = _prefs?.getDouble(_activityLevelKey) ?? 5;
    _avatar = _prefs?.getString(_avatarKey) ?? '';  // Carica l'avatar
    notifyListeners();
  }

  // Funzione per aggiornare le preferenze
  Future<void> updatePreferences(Map<String, dynamic> values) async {
    if (_prefs == null) return;

    values.forEach((key, value) async {
      if (value is String) {
        await _prefs?.setString(key, value);
      } else if (value is int) {
        await _prefs?.setInt(key, value);
      } else if (value is bool) {
        await _prefs?.setBool(key, value);
      } else if (value is double) {
        await _prefs?.setDouble(key, value);
      }
    });

    // Ricarica le preferenze dopo l'aggiornamento
    _loadPrefs();
  }
}
