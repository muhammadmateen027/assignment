import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static Widget customMessage(String error) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text(
        "${error}",
        textAlign: TextAlign.center,
      ),
    );
  }
}