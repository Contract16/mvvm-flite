import 'package:flutter/widgets.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

extension ServiceLocatorExtension on BuildContext {
  T get<T>() => ServiceLocator.of(this).get<T>();
}
