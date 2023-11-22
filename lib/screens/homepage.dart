import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/common/messageshowinpopup.dart';
import 'package:todos/config/themes/apptheme.dart';
import 'package:todos/constants/appconstants.dart';
import 'package:todos/models/taskmodel.dart';
import 'package:todos/providers/todo_provider.dart';
import 'package:todos/providers/xpansion_provider.dart';
import 'package:todos/screens/auth/login_screen.dart';
import 'package:todos/screens/tasks/add_task_screen.dart';
import 'package:todos/screens/tasks/update_task_screen.dart';
import 'package:todos/screens/todo/todo_tile.dart';
import 'package:todos/utils/completed.dart';
import 'package:todos/utils/futuretasks.dart';
import 'package:todos/utils/tomorrowlist.dart';
import 'package:todos/widgets/expansion_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(toDoStateProvider.notifier).refresh();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'DashBoard',
            style: TextStyle(
                color: AppTheme.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 24),
          ),
          actions: [
            IconButton(
              color: AppTheme.greenColor,
              onPressed: () {
                onPressed(context);
              },
              icon: const Icon(Icons.logout_outlined),
            ),
            const SizedBox(
              width: 11,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                textAlign: TextAlign.justify,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontSize: 18),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 35,
                  ),
                  suffixIcon: const Icon(Icons.tune),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.view_list_outlined,
                          size: 32,
                          color: AppTheme.greenColor,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Today\'s Tasks:',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.greenColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                          isScrollable: false,
                          labelColor: Colors.blueAccent,
                          labelStyle: const TextStyle(fontSize: 24),
                          unselectedLabelColor: Colors.red,
                          labelPadding: EdgeInsets.zero,
                          controller: tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: const BoxDecoration(
                              color: Color.fromARGB(255, 53, 76, 87),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              )),
                          tabs: const [
                            Tab(
                              child: SizedBox(
                                width: double.infinity * 0.5,
                                child: Center(
                                  child: Text(
                                    'Pending',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: SizedBox(
                                width: double.infinity * 0.5,
                                child: Center(
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              color: AppTheme.greenColor,
                              child: const TodayTask(),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              color: const Color.fromARGB(238, 213, 206, 206),
                              child: const CompletedTask(),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.view_list_outlined,
                          size: 32,
                          color: AppTheme.greenColor,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Upcomming Tasks:',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //dawdwdadwadaaaaaaaaaaaaaaaaaaa
                    const TomorrowList(),
                    const SizedBox(
                      height: 5,
                    ),
                    const FutureList(),
                    const SizedBox(
                      height: 85,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.greenColor,
          onPressed: () {
            Navigator.push((context),
                MaterialPageRoute(builder: (context) => const AddTask()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> onPressed(BuildContext context) async {
    return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text('Confirm LogOut?'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text(
                'LOGOUT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class TodayTask extends ConsumerWidget {
  const TodayTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(toDoStateProvider);
    String today = ref.watch(toDoStateProvider.notifier).todayDate();
    var todayList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();

    return ListView.builder(
        itemCount: todayList.length,
        itemBuilder: ((context, index) {
          final data = todayList[index];
          bool isCompleted =
              ref.read(toDoStateProvider.notifier).getStatus(data);
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
            editWidget: GestureDetector(
              onTap: () {
                titles = data.title.toString();
                descs = data.desc.toString();
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => UpdateTask(id: data.id ?? 0)));
              },
              child: const Icon(
                Icons.edit,
                color: AppTheme.greenColor,
              ),
            ),
            title: data.title,
            desc: data.desc,
            start: data.starttime,
            end: data.endtime,
            color: AppTheme.greyColor2,
            switcher: Switch(
                value: isCompleted,
                onChanged: (value) {
                  ref.read(toDoStateProvider.notifier).markAsDelete(
                      data.id ?? 0,
                      data.title.toString(),
                      data.desc.toString(),
                      1,
                      data.date.toString(),
                      data.starttime.toString(),
                      data.endtime.toString());
                }),
          );
        }));
  }
}
