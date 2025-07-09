import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:finance_tracker/widgets/scroll_button_bar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with TickerProviderStateMixin {
  String selected = '7/2025';
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Income, Outcome
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Income and outcome report',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Iconsax.arrow_left_2),
        ),
      ),
      body: Column(
        children: [
          // ✅ Scrollable Button Bar
          ScrollableButtonBar(
            labels: [
              '1/2025', '2/2025', '3/2025', '4/2025',
              '5/2025', '6/2025', '7/2025', '8/2025',
              '9/2025', '10/2025', '11/2025', '12/2025'
            ],
            selected: selected,
            onPressed: (label) => setState(() => selected = label),
          ),

          // ✅ TabBar bên dưới ScrollableButtonBar
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Income'),
              Tab(text: 'Outcome'),
            ],
          ),

          // ✅ Nội dung theo từng tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: Text('Income for $selected'),
                ),
                Center(
                  child: Text('Outcome for $selected'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
