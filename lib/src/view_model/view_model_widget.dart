import 'package:flutter/widgets.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

abstract class ViewModelWidget<T extends ViewModel> extends StatefulWidget {
  const ViewModelWidget({super.key});

  @override
  State<ViewModelWidget> createState() => _ViewModelWidgetState<T>();

  T model(BuildContext context) => context.get<T>();

  Widget build(BuildContext context, T model);
}

class _ViewModelWidgetState<T extends ViewModel>
    extends State<ViewModelWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return _ViewModel<T>(
      notifier: widget.model(context),
      child: _ViewModelBuilder<T>(child: widget.build),
    );
  }
}

class _ViewModelBuilder<T extends ViewModel> extends StatefulWidget {
  const _ViewModelBuilder({
    super.key,
    required this.child,
  });

  final Widget Function(BuildContext context, T model) child;

  @override
  State<_ViewModelBuilder> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends ViewModel>
    extends State<_ViewModelBuilder<T>> {
  late T model;

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    model = _ViewModel.of<T>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(
      context,
      model,
    );
  }
}

final class _ViewModel<T extends ViewModel> extends InheritedNotifier<T> {
  const _ViewModel({super.key, super.notifier, required super.child});

  static T of<T extends ViewModel>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ViewModel<T>>()!.notifier!;
}
