// home_screen.dart
import 'package:finance_tracker/generated/l10n.dart';
import 'package:finance_tracker/widgets/app_bottom_sheet.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:finance_tracker/widgets/event_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, String>>> events = {};

  // @override
  // void initState() {
  //   super.initState();
  //   events[_focusedDay] = [
  //     {'title': 'Dentist appointment', 'time': '10:00 - 11:00 AM'},
  //     {'title': 'Gym', 'time': '04:30 - 06:00 PM'},
  //     {'title': 'Dinner', 'time': '07:00 - 08:00 PM'},
  //     {'title': 'Learning langauges', 'time': '09:00 - 11:00 PM'},
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context)!.home_title('Jin')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            rowHeight: 44,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
              todayDecoration: BoxDecoration(
                color: colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(fontWeight: FontWeight.bold),
              weekendTextStyle: TextStyle(fontWeight: FontWeight.bold),
              outsideTextStyle: TextStyle(color: colorScheme.onSurface),
              todayTextStyle: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              // tablePadding: EdgeInsets.only(top: 110)
              markerDecoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) {
                // Lấy chữ cái đầu
                return DateFormat.E(locale).format(date).substring(0, 1);
              },
              weekdayStyle: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return events[day] ?? [];
            },
          ),
          Divider(
            indent: 16,
            endIndent: 16,
            color: colorScheme.primary,
            radius: BorderRadius.circular(16),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _showBottomSheet(_selectedDay ?? _focusedDay, colorScheme),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.circlePlus, size: 16),
                    SizedBox(width: 8),
                    Text('Event'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildViewEventsTab(_focusedDay, colorScheme)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showBottomSheet(DateTime selectedDay, ColorScheme colorScheme) {
    AppBottomSheet.show(
      backgroundColor: colorScheme.background,
      title: 'New event',
      context: context,
      child:
          // _buildAddEventTab(selectedDay),
          EventFormWidget(),
    );
  }

  Widget _buildAddEventTab(DateTime day) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController timeController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Event name"),
          ),
          TextField(
            controller: timeController,
            decoration: const InputDecoration(labelText: "Time"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isEmpty) return;

              setState(() {
                events[day] = (events[day] ?? [])
                  ..add({
                    "title": titleController.text,
                    "time": timeController.text,
                  });
              });

              // Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _buildViewEventsTab(DateTime day, ColorScheme colorScheme) {
    final dayEvents = events[day] ?? [];
    if (dayEvents.isEmpty) {
      return const Center(child: Text("No events"));
    }

    return ListView.builder(
      itemCount: dayEvents.length,
      itemBuilder: (context, index) {
        final event = dayEvents[index];
        return Card(
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'] ?? '',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 0),
                Text(event['time'] ?? '', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
