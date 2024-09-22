import 'package:flutter/material.dart';

extension Args on BuildContext {
  T args<T>() {
    return ModalRoute.of(this)!.settings.arguments! as T;
  }
}
