import 'package:example/features/counter/counter_service.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

ServiceLocator locator = ServiceLocator()
  ..register<CounterService>(CounterService())
  ..registerFactory<HomeViewModel>(
      () => HomeViewModel(locator.get<CounterService>()));
