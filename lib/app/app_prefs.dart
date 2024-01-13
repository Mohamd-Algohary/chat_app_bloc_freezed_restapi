import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '/domain/model/model.dart';
import 'constants.dart';

class AppPreferences {
  final SharedPreferences _preferences;
  String? _token;
  String? _userId;
  String? _email;
  DateTime? _expiryDate;
  Timer? _authTimer;

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    } else {
      return null;
    }
  }

  String? get userId {
    return _userId;
  }

  String? get email {
    return _email;
  }

  AppPreferences(
    this._preferences,
  );

  Future<void> setUserLoggedin(Authentication authData) async {
    _token = authData.idToken;
    _userId = authData.localId;
    _email = authData.email;
    _expiryDate =
        DateTime.now().add(Duration(seconds: int.parse(authData.expiresIn)));

    _preferences.setString('token', _token!);
    _preferences.setString('userId', _userId!);
    _preferences.setString('email', _email!);
    _preferences.setString('expiryDate', _expiryDate!.toIso8601String());

    Constants.token = token ?? "";
  }

  bool isUserLoggedin() {
    if (!_preferences.containsKey('expiryDate') ||
        !_preferences.containsKey('token') ||
        !_preferences.containsKey('userId') ||
        !_preferences.containsKey('email')) {
      return false;
    }

    _expiryDate = DateTime.parse(_preferences.getString('expiryDate')!);
    if (_expiryDate!.isBefore(DateTime.now())) {
      return false;
    }

    _token = _preferences.getString('token');
    _userId = _preferences.getString('userId');
    _email = _preferences.getString('email');

    Constants.token = token!;
    autoLogout();

    return true;
  }

  Future<void> logout() async {
    _preferences.clear();
    _token = null;
    _userId = null;
    _email = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
  }

  Future<void> autoLogout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
