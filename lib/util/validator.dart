import 'dart:core';

class ValidationMixin {
  String validateNik(String val) {
    if (val.isEmpty) {
      return 'Required!';
    } else if (val.length < 5) {
      return 'NIK must be at least 5 characters long';
    }
    return null;
  }

  String validatePassword(String val) {
    if (val.isEmpty) {
      return 'Required!';
    } else if (val.length < 4) {
      return 'Password must be at least 4 characters long';
    }
    return null;
  }

  String validatePasswordConfirm(String val, String val2) {
    if (val.isEmpty) {
      return 'Required!';
    } else if (val.length < 4) {
      if(val != val2){
        return 'email didnt match';
      }else{
        return 'Password must be at least 4 characters long';
      }
    }
    return null;
  }

  String validateEmail(String val) {
    if (val.isEmpty) {
      return 'Required!';
    } else if (!val.contains("@") || !val.contains(".")) {
      return 'Wrong email format';
    }
    return null;
  }

  String validateRequired(dynamic val) {
    print("Validator Required ${val}");
    if (val == null || val.isEmpty) {
      return 'Required!';
    }
    return null;
  }

  String validateRequiredNumber(String val) {
    if (val.isEmpty) {
      return 'Required!';
    } else if (!isNumeric(val)) {
      return 'Only Number!';
    }
    return null;
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }


}