import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // Todo for String.
  Future<String> onGetSharedPreferencesValue(final String keyName) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final String keyValue = sharedPreferences.getString(keyName);
    if (keyValue != null && keyValue.isNotEmpty) {
      return keyValue;
    }
    return null;
  }

  Future<void> onSetSharedPreferencesValue(
      final String keyName, final String keyValue) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    await sharedPreferences.setString(keyName, keyValue);
  }

  // Todo for int.
  Future<int> onGetSharedPrefIntValue(final String keyName) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final int keyValue = sharedPreferences.getInt(keyName);
    if (keyValue != null) {
      return keyValue;
    }
    return keyValue;
  }

  Future<void> onSetSharedPrefIntValue(
      final String keyName, final int keyValue) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    await sharedPreferences.setInt(keyName, keyValue);
  }

  Future<void> onEmptySharedPreference() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  Future<void> onEmptySinglePref(String key) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }
}