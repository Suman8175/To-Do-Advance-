import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/common/messageshowinpopup.dart';
import 'package:todos/config/themes/apptheme.dart';
import 'package:todos/models/taskmodel.dart';
import 'package:todos/providers/todo_provider.dart';
import 'package:todos/screens/todo/todo_tile.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(toDoStateProvider);
    List last30days = ref.watch(toDoStateProvider.notifier).last30days();
    var completedList = listData
        .where((element) =>
            element.isCompleted == 1 ||
            last30days.contains(element.date!.substring(0, 10)))
        .toList();

    return ListView.builder(
        itemCount: completedList.length,
        itemBuilder: ((context, index) {
          final data = completedList[index];

          return ToDoTile(
            delete: () {
              Message(
                buttontext: 'Delete',
                title: 'Confirm Delete',
                msg: 'Do you want to delete it?',
                onTrue: () {
                  ref.read(toDoStateProvider.notifier).deleteToDo(data.id ?? 0);
                  Navigator.pop(context);
                },
              ).onPressed(context);
            },
            editWidget: const SizedBox.shrink(),
            title: data.title,
            desc: data.desc,
            start: data.starttime,
            end: data.endtime,
            color: AppTheme.greyColor2,
            switcher: const Icon(
              Icons.check_circle_rounded,
              color: AppTheme.greenColor,
            ),
          );
        }));
  }
}
