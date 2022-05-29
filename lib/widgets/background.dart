import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget? child;
  const Background({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/background.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.background.withOpacity(0.8),
            BlendMode.srcOver,
          ),
        ),
      ),
      child: child,
    );
  }
}
