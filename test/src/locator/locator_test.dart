import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

void main() {
  group('Singleton', () {
    test('Locator registers singleton objects correctly', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.register(TestService());
      final actual = locator.get<TestService>();

      // Assert
      expect(actual, isA<TestService>());
      expect(actual.name, equals('test_service'));
    });

    test('Locator cannot register the same object type more than once', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.register(TestService());

      // Assert
      expect(() => locator.register(TestService()), throwsA(isA<Exception>()));
    });

    test('Locator can register same object type again after unregistering', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.register(TestService());
      locator.unregister<TestService>();
      locator.register(TestService());
      final actual = locator.get<TestService>();

      // Assert
      expect(actual, isA<TestService>());
      expect(actual.name, equals('test_service'));
    });

    test('Locator can register same object type with different names', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.register(TestService(), 'first');
      locator.register(TestService(), 'second');
      final actualFirst = locator.get<TestService>('first');
      final actualSecond = locator.get<TestService>('second');

      // Assert
      expect(actualFirst, isA<TestService>());
      expect(actualSecond, isA<TestService>());
    });
  });

  group('Factory', () {
    test('Locator registers factory objects correctly', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.registerFactory(() => TestService());
      final actual = locator.get<TestService>();

      // Assert
      expect(actual, isA<TestService>());
      expect(actual.name, equals('test_service'));
    });

    test('Locator cannot register the same object type more than once', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.registerFactory(() => TestService());

      // Assert
      expect(() => locator.registerFactory(() => TestService()),
          throwsA(isA<Exception>()));
    });

    test('Locator can register same object type again after unregistering', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.registerFactory(() => TestService());
      locator.unregister<TestService>();
      locator.registerFactory(() => TestService());
      final actual = locator.get<TestService>();

      // Assert
      expect(actual, isA<TestService>());
      expect(actual.name, equals('test_service'));
    });

    test('Locator can register same object type with different names', () {
      // Arrange
      ServiceLocator locator = ServiceLocator();

      // Act
      locator.registerFactory(() => TestService(), 'first');
      locator.registerFactory(() => TestService(), 'second');
      final actualFirst = locator.get<TestService>('first');
      final actualSecond = locator.get<TestService>('second');

      // Assert
      expect(actualFirst, isA<TestService>());
      expect(actualSecond, isA<TestService>());
    });
  });
}

class TestService {
  final String name = 'test_service';
}
