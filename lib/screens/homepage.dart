import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/config/themes/apptheme.dart';
import 'package:todos/screens/auth/login_screen.dart';
import 'package:todos/screens/todo/todo_tile.dart';
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
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              color: AppTheme.greenColor,
                              child: ListView(
                                children: [
                                  ToDoTile(
                                    start: '03:00',
                                    end: '06:00',
                                    switcher: Switch(
                                        value: true, onChanged: (value) {}),
                                  ),
                                  ToDoTile(
                                    start: '03:00',
                                    end: '06:00',
                                    switcher: Switch(
                                        value: true, onChanged: (value) {}),
                                  ),
                                  ToDoTile(
                                    start: '03:00',
                                    end: '06:00',
                                    switcher: Switch(
                                        value: false, onChanged: (value) {}),
                                  ),
                                  ToDoTile(
                                    start: '03:00',
                                    end: '06:00',
                                    switcher: Switch(
                                        value: true, onChanged: (value) {}),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              color: Colors.pink,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const XpansionTile(
                      text1: 'Tomorrow\'s Task',
                      text2: 'Nice',
                      children: [Text('Data1'), Text('Data2')],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const XpansionTile(
                      text1: 'UpComing Task',
                      text2: 'Nice OKK',
                      children: [Text('Data1'), Text('Data2')],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.greenColor,
          onPressed: () {},
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
