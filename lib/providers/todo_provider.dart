import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todos/models/database/db_helper.dart';
import 'package:todos/models/taskmodel.dart';
part 'todo_provider.g.dart';

@riverpod
class ToDoState extends _$ToDoState {
  @override
  List<TaskModel> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();
    state = data.map((e) => TaskModel.fromJson(e)).toList();
  }

  void addItem(TaskModel taskModel) async {
    await DBHelper.createItems(taskModel);
    refresh();
  }

  void updateItem(int id, String title, String desc, int isCompleted,
      String date, String starttime, String endtime) async {
    await DBHelper.updateItem(
        id, title, desc, isCompleted, date, starttime, endtime);
    refresh();
  }

  void deleteToDo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }

  void markAsDelete(int id, String title, String desc, int isCompleted,
      String date, String starttime, String endtime) async {
    await DBHelper.updateItem(id, title, desc, 1, date, starttime, endtime);
    refresh();
  }

  String todayDate() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

  String tomorrowDate() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.toString().substring(0, 10);
  }

  List<String> last30days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  List<String> upcommingtasks() {
    DateTime today = DateTime.now();
    DateTime twodays = today.add(const Duration(days: 2));

    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = twodays.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(TaskModel data) {
    bool? isCompleted;
    if (data.isCompleted == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }
    return isCompleted;
  }
}
