import 'package:flutter/material.dart';

abstract class BaseView<T> {
  void setPresenter(T presenter);
}
