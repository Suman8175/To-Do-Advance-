import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/common/exception/exceptionshow.dart';
import 'package:todos/config/themes/apptheme.dart';
import 'package:todos/constants/appconstants.dart';
import 'package:todos/models/taskmodel.dart';
import 'package:todos/providers/dates_provider.dart';
import 'package:todos/providers/todo_provider.dart';
import 'package:todos/widgets/custom_button.dart';
import 'package:todos/widgets/textfield_common.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class UpdateTask extends ConsumerStatefulWidget {
  final int id;
  const UpdateTask({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends ConsumerState<UpdateTask> {
  TextEditingController titleController = TextEditingController(text: titles);
  TextEditingController descController = TextEditingController(text: descs);
  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var startTime = ref.watch(startTimeStateProvider);
    var endTime = ref.watch(endTimeStateProvider);
    return Scaffold(
      backgroundColor: AppTheme.greyColor2,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppTheme.greenColor, // Change this color to your desired color
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFiller(
              newController: titleController,
              textFieldTitle: 'Add Title',
              obsecure: false,
              value: titleController.text.toString(),
              iconToShow: Icons.title,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFiller(
              newController: descController,
              textFieldTitle: 'Add Description',
              obsecure: false,
              value: descController.text.toString(),
              iconToShow: Icons.description,
              keyboardAction: TextInputAction.done,
              max: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomBtn(
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2035, 6, 7),
                    theme: const picker.DatePickerTheme(
                        doneStyle: TextStyle(color: AppTheme.greenColor)),
                    onConfirm: (date) {
                  ref.read(dateStateProvider.notifier).setDate(date.toString());
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
              width: double.infinity,
              height: 52,
              text: scheduleDate == ""
                  ? 'SetDate'
                  : scheduleDate.substring(0, 10),
              color2: AppTheme.greenColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  onTap: () {
                    picker.DatePicker.showTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(startTimeStateProvider.notifier)
                          .setStart(date.toString());
                    }, currentTime: DateTime.now());
                  },
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 52,
                  text: startTime == ""
                      ? 'Start Time'
                      : startTime.substring(10, 16),
                  color2: AppTheme.greenColor,
                ),
                CustomBtn(
                  onTap: () {
                    picker.DatePicker.showTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(endTimeStateProvider.notifier)
                          .setEnd(date.toString());
                    }, currentTime: DateTime.now());
                  },
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 52,
                  text: endTime == "" ? 'End Time' : endTime.substring(10, 16),
                  color2: AppTheme.greenColor,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomBtn(
              onTap: () {
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    startTime.isNotEmpty &&
                    endTime.isNotEmpty) {
                  ref.read(toDoStateProvider.notifier).updateItem(
                      widget.id,
                      titleController.text,
                      descController.text,
                      0,
                      scheduleDate.toString(),
                      startTime.toString().substring(10, 16),
                      endTime.toString().substring(10, 16));
                  ref.read(endTimeStateProvider.notifier).setEnd('');
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.pop(context);
                } else {
                  ExceptionShower()
                      .showmessage('Failed to add task.Enter all field');
                }
              },
              height: 52,
              width: double.infinity,
              text: 'Edit',
              color2: Colors.lightBlue,
            )
          ],
        ),
      ),
    );
  }
}
