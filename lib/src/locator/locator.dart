import 'package:flutter/widgets.dart';

final class ServiceLocator {
  final Map<String, dynamic> _services;

  ServiceLocator({Map<String, (bool, dynamic)>? services})
      : _services = services ?? {};

  T get<T>([String? name]) {
    final record = _services[T.serviceName(name)];
    if (record != null) {
      if (record is Function) {
        return record() as T;
      }
      return record as T;
    }
    throw Exception('Ojbect of type "$T" is not registered');
  }

  void register<T>(T service, [String? name]) {
    final serviceName = _getServiceName<T>(service, name);

    if (_services.containsKey(serviceName)) {
      throw Exception('Ojbect of type "$T" is already registered');
    }
    _services[serviceName] = service;
  }

  void registerFactory<T>(T Function() factory, [String? name]) {
    final serviceName = _getServiceName<T>(factory, name);
    if (_services.containsKey(serviceName)) {
      throw Exception('Object of type "$T" is already registered');
    }
    _services[serviceName] = factory;
  }

  void unregister<T>([String? name]) {
    _services.remove(T.serviceName(name));
  }

  String _getServiceName<T>(service, String? name) {
    // We should _never_ register a dynamic type.
    if (T.toString() == 'dynamic') {
      return service.runtimeType.serviceName(name);
    }
    return T.serviceName(name);
  }

  static ServiceLocator of(BuildContext context, [String? aspect]) =>
      _ServiceLocator.of(context, aspect);
}

final class _ServiceLocator extends InheritedModel<ServiceLocator> {
  final ServiceLocator _locator;

  const _ServiceLocator({
    required ServiceLocator locator,
    required super.child,
  }) : _locator = locator;

  static ServiceLocator? maybeOf(BuildContext context, [String? aspect]) {
    return InheritedModel.inheritFrom<_ServiceLocator>(context, aspect: aspect)
        ?._locator;
  }

  static ServiceLocator of(BuildContext context, [String? aspect]) {
    final ServiceLocator? result = maybeOf(context, aspect);
    assert(result != null, 'Unable to find an instance of ServiceLocator...');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  @override
  bool updateShouldNotifyDependent(
          covariant InheritedModel<ServiceLocator> oldWidget,
          Set<ServiceLocator> dependencies) =>
      false;
}

class ServiceLocatorProvider extends StatelessWidget {
  final ServiceLocator _locator;
  final Widget child;

  ServiceLocatorProvider.services({
    super.key,
    required this.child,
    required List<dynamic> services,
  }) : _locator = ServiceLocator() {
    for (final service in services) {
      _locator.register(service);
    }
  }

  const ServiceLocatorProvider.locator({
    super.key,
    required this.child,
    required ServiceLocator locator,
  }) : _locator = locator;

  @override
  Widget build(BuildContext context) {
    return _ServiceLocator(
      locator: _locator,
      child: child,
    );
  }
}

extension on Type {
  String serviceName([String? name]) =>
      [toString(), name].where((s) => s != null).join('+');
}
