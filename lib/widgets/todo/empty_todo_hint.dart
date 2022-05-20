import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A hint graphic to inform users that they have completed all todo.
class EmptyTodoHint extends StatelessWidget {
  const EmptyTodoHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 180,
            height: 160,
            child: SvgPicture.asset("assets/illustrations/todo_empty.svg"),
          ),
          const SizedBox(height: 25),
          const Text(
            "Hurray!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "You don't have more to-dos to complete.",
            style: TextStyle(color: Colors.grey[800]),
          ),
          const SizedBox(height: 5),
          Text(
            'To add a to-do, press the "+" button.',
            style: TextStyle(color: Colors.grey[800]),
          ),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}
