import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

void main() {
  test('ViewModel fires registered listeners correctly on notify', () {
    // Arrange
    bool listener1Notified = false;
    listener1() {
      listener1Notified = true;
    }

    bool listener2Notified = false;
    listener2() {
      listener2Notified = true;
    }

    ViewModel model = TestViewModel();
    model.addListener(listener1);
    model.addListener(listener2);

    // Act
    model.notifyListeners();

    // Assert
    expect(listener1Notified, isTrue);
    expect(listener2Notified, isTrue);
  });

  test('ViewModel throws exception on addListener after dispose', () {
    // Arrange
    ViewModel model = TestViewModel();

    // Act
    model.dispose();

    // Assert
    expect(() => model.addListener(() {}), throwsA(isA<Error>()));
  });

  test('ViewModel throws exception on notifyListeners after dispose', () {
    // Arrange
    ViewModel model = TestViewModel();

    // Act
    model.dispose();

    // Assert
    expect(() => model.notifyListeners(), throwsA(isA<Error>()));
  });
}

class TestViewModel extends ViewModel {}
