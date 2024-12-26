import 'dart:async';

class CounterService {
  int _currentCount = 0;
  int get currentCount => _currentCount;

  final StreamController<int> _countController = StreamController.broadcast();
  Stream<int> get count => _countController.stream;

  void increment() {
    _currentCount++;
    _countController.add(_currentCount);
  }
}
