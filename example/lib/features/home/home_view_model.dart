import 'dart:async';

import 'package:example/features/counter/counter_service.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

class HomeViewModel extends ViewModel {
  final CounterService _counterService;

  HomeViewModel(CounterService countService) : _counterService = countService {
    _counterSubscription = _counterService.count.listen(
      (i) {
        _serviceCount = i;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _counterSubscription.cancel();
    super.dispose();
  }

  late int _serviceCount = _counterService.currentCount;
  int get serviceCount => _serviceCount;
  late StreamSubscription<int> _counterSubscription;

  int _count = 0;
  int get count => _count;

  void incrementServiceCount() => _counterService.increment();

  void incrementCount() {
    _count++;
    notifyListeners();
  }
}
