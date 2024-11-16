import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill, // 0 <> 1
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(8)),
              gradient: LinearGradient(
                colors: [Colors.black,Colors.indigo,Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )

              //color: isDarkMode
                  // ? Theme.of(context).colorScheme.secondary
                  // : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
