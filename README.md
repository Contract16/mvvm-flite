A Simple MVVM implementation for Flutter with a basic service locator.

> Currently under development

## Features

- `ViewModel` base class
- `ViewModelWidget` base widget class
- `ServiceLocatorProvider` for gaining access to singleton services, repositories etc throughout the app via a context

## Usage

The most basic usage involves creating a `ViewModel` and a widget which consumes the `ViewModel` as a `ViewModelWidget`, and implementing the `build(context, model)` functions as required:

### ViewModel

```dart
class HomeViewModel extends ViewModel {
    final String displayName = 'HomeViewModel';
}
```

### ViewModelWidget

```dart
class HomePage extends ViewModelWidget<HomeViewModel> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      body: Center(
        child: Text('${model.displayName}'),
      ),
    );
  }
}
```

The `build` function will provide a reference to the `ViewModel` defined in the `model(context)` function (defaults to attempting to retrieve a `ViewModel` from the `ServiceLocator`), which is then registered behind the scenes as an `InheritedNotifier`.

`void model(BuildContext context)` can be overriden if you are not using the `ServiceLocator` as part of your implementation, such as is you are using GetIt, BloC or Riverpod.

Inside the `ViewModel`, you can call `notifyListeners()` to update the UI to any new state, just as how the provider library acts.

## Service Locator

There is also a `ServiceLocator` and `ServiceLocatorProvider` included which can be used to register singleton objects for the rest of app to use. This should be placed above the `App` class:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceLocatorProvider.locator(
      locator: locator,
      child: MaterialApp(
        title: 'Simple MVVM Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
```

`ServiceLocatorProvider.locator` accepts a `ServiceLocator` as an arg, which can be referenced from elsewhere in the codebase and is a simple class to register singleton objects.
`ServiceLocatorProvider.services` accepts a list of objects as an arg, which are then registered to a `ServiceLocator` internal to the `ServiceLocatorProvider`.

### Registering services of the same type

Registering an object will fail if an object is already registered of the same type and `name`. `name` is optional, and is for registering multiple dependencies of the same type.

## TODO:

- [ ] Support passing params when registering dependencies (for factories);
