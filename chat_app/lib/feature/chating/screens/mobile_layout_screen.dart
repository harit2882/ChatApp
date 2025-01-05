import 'package:chat_app/feature/auth/controller/auth_controller.dart';
import 'package:chat_app/feature/chating/widgets/chat_list_home_page.dart';
import 'package:chat_app/feature/status/status_screen.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({super.key});

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController _tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: false,
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.camera);
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {
                },
            ),
            PopupMenuButton<String>(
                color: appBarColor,
                onSelected: (value) {
                  print(value);
                },
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                        value: "New Group", child: Text("New Group")),
                    const PopupMenuItem(
                        value: "New Broadcast", child: Text("New Broadcast")),
                    const PopupMenuItem(
                        value: "WhatsApp Web", child: Text("WhatsApp Web")),
                    const PopupMenuItem(
                        value: "Starred Message",
                        child: Text("Starred Message")),
                    const PopupMenuItem(
                        value: "Settings", child: Text("Settings")),
                  ];
                })
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: Center(
          child: TabBarView(
              controller: _tabController,
              children: const [ChatList(),Status(), Text("calls")]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.contacts);
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
