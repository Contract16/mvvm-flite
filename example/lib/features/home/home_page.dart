import 'package:example/features/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

class HomePage extends ViewModelWidget<HomeViewModel> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Simple MVVM Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: <Widget>[
            const Text('CounterService count:'),
            Text(
              '${model.serviceCount}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              onPressed: model.incrementServiceCount,
              icon: const Icon(Icons.add),
            ),
            Divider(),
            const Text('ViewModel count:'),
            Text(
              '${model.count}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              onPressed: model.incrementCount,
              icon: const Icon(Icons.add),
            ),
            Divider(),
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              ),
              child: Text('New Page'),
            )
          ],
        ),
      ),
    );
  }
}
