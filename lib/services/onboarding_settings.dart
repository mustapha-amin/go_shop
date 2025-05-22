import 'package:shared_preferences/shared_preferences.dart';

class OnboardingSettings {
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String _detailsSavedKey = 'details_saved';

  final SharedPreferences _prefs;

  OnboardingSettings(this._prefs);

  bool get hasSeenOnboarding => _prefs.getBool(_hasSeenOnboardingKey) ?? false;
  bool get detailsSaved => _prefs.getBool(_detailsSavedKey) ?? false;

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_hasSeenOnboardingKey, true);
  }

  Future<void> setDetailsSaved(bool value) async {
    await _prefs.setBool(_detailsSavedKey, value);
  }

  Future<void> resetOnboarding() async {
    await _prefs.remove(_hasSeenOnboardingKey);
    await _prefs.remove(_detailsSavedKey);
  }
}
