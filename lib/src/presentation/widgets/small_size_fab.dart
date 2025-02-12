import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../main.dart';
import '../../core/common.dart';
import '../../core/enum/box_types.dart';

class SmallSizeFab extends StatelessWidget {
  const SmallSizeFab({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final settings = getIt.get<Box<dynamic>>(
      instanceName: BoxType.settings.name,
    );
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: settings.listenable(keys: [smallSizeFabKey]),
      builder: (context, value, child) {
        final isSmallSize = value.get(smallSizeFabKey, defaultValue: false);
        if (isSmallSize) {
          return FloatingActionButton(
            onPressed: onPressed,
            child: Icon(icon),
          );
        } else {
          return FloatingActionButton.large(
            onPressed: onPressed,
            child: Icon(icon),
          );
        }
      },
    );
  }
}
