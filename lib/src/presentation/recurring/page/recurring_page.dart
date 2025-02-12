import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../data/recurring/model/recurring.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../../widgets/small_size_fab.dart';

class RecurringPage extends StatelessWidget {
  const RecurringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(
        context.loc.recurring,
      ),
      floatingActionButton: SmallSizeFab(
        onPressed: () {
          GoRouter.of(context).pushNamed(recurringName);
        },
        icon: Icons.add,
      ),
      body: ValueListenableBuilder<Box<RecurringModel>>(
        valueListenable: getIt.get<Box<RecurringModel>>().listenable(),
        builder: (_, value, child) {
          final List<RecurringModel> recurringModels = value.values.toList();
          if (recurringModels.isEmpty) {
            return EmptyWidget(
              title: context.loc.recurringEmptyMessageTitle,
              description: context.loc.recurringEmptyMessageSubTitle,
              icon: MdiIcons.cashSync,
              actionTitle: context.loc.recurringAction,
              onActionPressed: () {
                GoRouter.of(context).pushNamed(recurringName);
              },
            );
          }
          return RecurringListWidget(recurringModels: recurringModels);
        },
      ),
    );
  }
}

class RecurringListWidget extends StatelessWidget {
  const RecurringListWidget({super.key, required this.recurringModels});
  final List<RecurringModel> recurringModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: recurringModels.length,
      itemBuilder: (context, index) {
        final RecurringModel expense = recurringModels[index];
        return ListTile(
          title: Text(expense.name),
          subtitle: Text(
              '${expense.recurringType.name(context)} - ${expense.recurringDate.shortDayString}'),
          trailing: IconButton(
            onPressed: () async {
              await expense.delete();
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
