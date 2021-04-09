import 'package:flutter/material.dart';

class SelectorWidget<T> extends StatefulWidget {
  final String title;
  final List<T> values;
  final String Function(T value) toText;
  final ValueChanged<T> onChangedValue;

  const SelectorWidget({
    Key? key,
    required this.title,
    required this.values,
    required this.toText,
    required this.onChangedValue,
  }) : super(key: key);

  @override
  _SelectorWidgetState<T> createState() => _SelectorWidgetState<T>();
}

class _SelectorWidgetState<T> extends State<SelectorWidget<T>> {
  T? value;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: Colors.white),
          Text(widget.title, style: TextStyle(color: Colors.white)),
          buildButtons(),
        ],
      );

  Widget buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: previous,
          ),
          Text(
            widget.toText(currentValue),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: next,
          ),
        ],
      );

  T get currentValue => value ?? widget.values.first;

  void previous() {
    final index = widget.values.indexOf(currentValue);
    final hasPrevious = index > 0;

    final newIndex = hasPrevious ? index - 1 : widget.values.length - 1;
    updateIndex(newIndex);
  }

  void next() {
    final index = widget.values.indexOf(currentValue);
    final hasNext = index + 1 < widget.values.length;

    final newIndex = hasNext ? index + 1 : 0;
    updateIndex(newIndex);
  }

  void updateIndex(int index) {
    setState(() => value = widget.values[index]);

    widget.onChangedValue(value!);
  }
}
