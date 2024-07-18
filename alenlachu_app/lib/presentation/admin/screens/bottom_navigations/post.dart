import 'package:alenlachu_app/presentation/admin/screens/pages/awareness/awareness_page.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/event/event_page.dart';
import 'package:flutter/material.dart';

class AdminPostPage extends StatefulWidget {
  const AdminPostPage({super.key});

  @override
  State<AdminPostPage> createState() => _AdminPostPageState();
}

class _AdminPostPageState extends State<AdminPostPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TabBar(
              dividerColor: Colors.transparent,
              splashBorderRadius: BorderRadius.circular(20),
              controller: _tabController,
              tabs: const [
                Tab(text: 'Events'),
                Tab(text: 'Awareness'),
              ],
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  EventPage(),
                  AwarenessPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
