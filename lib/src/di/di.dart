import 'dart:io';

import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:quick_actions/quick_actions.dart';

import '../app/routes.dart';
import 'di.config.dart';
import 'module/data_module.dart';

@InjectableInit(
  asExtension: false,
  preferRelativeImports: true,
  throwOnMissingDependencies: true,
)
Future<GetIt> configInjector(
  GetIt getIt, {
  String? env,
  EnvironmentFilter? environmentFilter,
}) async {
  usePathUrlStrategy();
  await initHive();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  initAppShortcuts();
  return init(
    getIt,
    environmentFilter: environmentFilter,
    environment: env,
  );
}

Future<void> initAppShortcuts() async {
  const QuickActions quickActions = QuickActions();
  await quickActions.initialize((String shortcutType) {
    goRouter.goNamed(
      shortcutAddTransactionName,
      params: {
        'type': shortcutType == 'ic_expense'
            ? '0'
            : shortcutType == 'ic_income'
                ? '1'
                : shortcutType == 'ic_transfer'
                    ? '2'
                    : '0',
      },
    );
  });
  await quickActions.setShortcutItems([
    const ShortcutItem(
      type: 'ic_income',
      localizedTitle: 'Income',
      icon: 'ic_income',
    ),
    const ShortcutItem(
      type: 'ic_expense',
      localizedTitle: 'Expense',
      icon: 'ic_expense',
    ),
    const ShortcutItem(
      type: 'ic_transfer',
      localizedTitle: 'Transfer',
      icon: 'ic_transfer',
    ),
  ]);
}
