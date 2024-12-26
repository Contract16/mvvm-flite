import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

void main() {
  testWidgets('ViewModelWidget uses correct ViewModel', (tester) async {
    // Arrange
    final model = _TestViewModel();
    final widget = ServiceLocatorProvider.services(
      services: [model],
      child: MaterialApp(
        home: Builder(
          builder: (context) => _TestViewModelWidget(),
        ),
      ),
    );

    // Act
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    // Assert
    expect(find.text(model.testString), findsOneWidget);
  });

  testWidgets('View updates correctly on notifyListeners', (tester) async {
    // Arrange
    final model = _TestViewModel();
    final widget = ServiceLocatorProvider.services(
      services: [model],
      child: MaterialApp(
        home: Builder(
          builder: (context) => _TestViewModelWidget(),
        ),
      ),
    );

    // Act
    await tester.pumpWidget(widget);

    // Assert
    expect(find.text(model.testString), findsOneWidget);

    // Act
    model.testString = 'updated string';
    await tester.pump();

    // Assert
    expect(find.text('updated string'), findsOneWidget);
  });
}

class _TestViewModelWidget extends ViewModelWidget<_TestViewModel> {
  @override
  Widget build(BuildContext context, _TestViewModel model) =>
      Text(model.testString);
}

class _TestViewModel extends ViewModel {
  String _testString = 'test';
  String get testString => _testString;
  set testString(String s) {
    _testString = s;
    notifyListeners();
  }
}
