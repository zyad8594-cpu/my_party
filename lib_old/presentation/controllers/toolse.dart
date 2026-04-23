// import 'package:flutter/cupertino.dart' show Widget;
import 'package:get/get.dart' show Rx;

// typedef WGFunc = Widget Function();

class Toolse {

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  static final RegExp _numRegex = RegExp(r'^[0-9]{1,}$');
  static final RegExp _cCRegex = RegExp(r'^[A-Z]{1,}$');
  static final RegExp _sCRegex = RegExp(r'^[a-z]{1,}$');
  static final RegExp _cCHRegex = RegExp(r'''^[\.!@#$%^&*(-{+})~`"'\\/]{1,}$''');
  static final int _minPasswordLength = 7;
  static final int _maxPasswordLength = 50;

  static bool strLenBetween(String password, int min, int max) => (
    password.length >= min && 
    password.length <= max
  );

  
  static bool passwordIsLengthValid<T>(T password){
    return (password is String)?
        strLenBetween(password, _minPasswordLength, _maxPasswordLength)
    : (password is Rx<String>)?
        strLenBetween(password.value, _minPasswordLength, _maxPasswordLength)
    : false;
  }
  
  static bool emailIsValid(String email) => _emailRegex.hasMatch(email);
  static bool passwordIsValid(String password) => (
    _numRegex.hasMatch(password) && 
    _cCRegex.hasMatch(password) &&
    _sCRegex.hasMatch(password) &&
    _cCHRegex.hasMatch(password) && 
    passwordIsLengthValid(password)
  );
  
  static T set<T>(Rx<T> ele, [T? value])
  {
    ele.value = value ?? ele.value;
    return ele.value;
  } 
}
  
