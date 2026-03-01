import 'package:fashion_shop/core/data/local/secure_storage_helper.dart';

class AppData {
  // Storage keys
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _phoneNumberKey = 'phone_number';

  // In-memory cached data
  static bool isLoggedIn = false;
  static String? phoneNumber;

  static Future<void> loadFromStorage() async {
    final loggedIn = await SecureStorageHelper.getData(key: _isLoggedInKey);
    isLoggedIn = loggedIn == 'true';

    if (isLoggedIn) {
      phoneNumber = await SecureStorageHelper.getData(key: _phoneNumberKey);
    }
  }

  static Future<void> saveLogin(String phone) async {
    isLoggedIn = true;
    phoneNumber = phone;

    await SecureStorageHelper.saveData(key: _isLoggedInKey, value: 'true');
    await SecureStorageHelper.saveData(key: _phoneNumberKey, value: phone);
  }

  static Future<void> logout() async {
    isLoggedIn = false;
    phoneNumber = null;

    await SecureStorageHelper.removeData(key: _isLoggedInKey);
    await SecureStorageHelper.removeData(key: _phoneNumberKey);
  }
}
