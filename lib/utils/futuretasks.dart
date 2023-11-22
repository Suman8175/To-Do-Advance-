import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/common/messageshowinpopup.dart';
import 'package:todos/config/themes/apptheme.dart';
import 'package:todos/constants/appconstants.dart';
import 'package:todos/providers/todo_provider.dart';
import 'package:todos/providers/xpansion_provider.dart';
import 'package:todos/screens/tasks/update_task_screen.dart';
import 'package:todos/screens/todo/todo_tile.dart';
import 'package:todos/widgets/expansion_tile.dart';

class FutureList extends ConsumerWidget {
  const FutureList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(toDoStateProvider);
    List future = ref.watch(toDoStateProvider.notifier).upcommingtasks();
    var tomorrowtasks = todos.where((element) =>
        future.any((futureDate) => element.date!.contains(futureDate)));
    return XpansionTile(
      text1: 'Future Task',
      text2: '',
      onExpansionChanged: (expanded) {
        ref.read(xpansionState0Provider.notifier).setStart(!expanded);
      },
      trailing: ref.watch(xpansionState0Provider)
          ? const Icon(
              Icons.arrow_circle_down,
              color: AppTheme.greenColor,
            )
          : const Icon(
              Icons.cancel,
              color: Colors.white,
            ),
      children: [
        for (final todo in tomorrowtasks)
          ToDoTile(
            title: todo.title,
            desc: todo.desc,
            start: todo.date!.substring(0, 10),
            delete: () {
              Message(
                buttontext: 'Delete',
                title: 'Confirm Delete',
                msg: 'Do you want to delete it?',
                onTrue: () {
                  ref.read(toDoStateProvider.notifier).deleteToDo(todo.id ?? 0);
                  Navigator.pop(context);
                },
              ).onPressed(context);
            },
            editWidget: GestureDetector(
              onTap: () {
                titles = todo.title.toString();
                descs = todo.desc.toString();
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => UpdateTask(id: todo.id ?? 0)));
              },
              child: Icon(
                Icons.edit,
                color: AppTheme.greenColor,
              ),
            ),
          )
      ],
    );
  }
}
