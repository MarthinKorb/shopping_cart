import 'package:flutter/cupertino.dart';

class CounterState {
  int _value = 1;
  void increment() => _value++;
  void decrement() => _value--;
  int get value => _value;

  bool diff(CounterState oldValue) {
    return oldValue == null || oldValue._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  CounterProvider({Widget child}) : super(child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
