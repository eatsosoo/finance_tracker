import 'package:finance_tracker/constants/datetime.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/widgets/custom_switch.dart';

class EventFormWidget extends StatefulWidget {
  const EventFormWidget({Key? key}) : super(key: key);

  @override
  State<EventFormWidget> createState() => _EventFormWidgetState();
}

class _EventFormWidgetState extends State<EventFormWidget> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isAllDay = false;
  bool _isRepetitive = false;

  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 10, minute: 0);
  DateTime _endDate = DateTime.now();
  TimeOfDay _endTime = const TimeOfDay(hour: 11, minute: 0);

  final List<String> tags = [
    "FITNESS",
    "ME TIME",
    "FAMILY",
    "FRIENDS",
    "WORK",
    "HEALTH",
    "TRAVEL",
    "HOBBY",
  ];

  final Map<String, Color> tagColors = {
    "FITNESS": Color(0xFFB9EEB5),
    "ME TIME": Color(0xFFF1B6CF),
    "FAMILY": Color(0xFFFFF2B2),
    "FRIENDS": Color(0xFFFAC0C0),
    "WORK": Color(0xFFF9E9A5),
    "HEALTH": Color(0xFFF5A6A6),
    "TRAVEL": Color(0xFFAEEABF),
    "HOBBY": Color(0xFFF7F0B2),
  };

  Set<String> selectedTags = {};

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final current = isStart ? _startDate : _endDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFFB9EEB5),
            onPrimary: Colors.black,
            surface: const Color(0xFF24242B),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStart)
          _startDate = picked;
        else
          _endDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context, bool isStart) async {
    final current = isStart ? _startTime : _endTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            // primary: const Color(0xFFB9EEB5),
            // onPrimary: Colors.black,
            // surface: const Color(0xFF24242B),
            // onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStart)
          _startTime = picked;
        else
          _endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textFieldStyle = TextStyle(color: Colors.white);
    final labelStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    final subLabelStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12
    );
    final boxDecoration = BoxDecoration(
      color: const Color(0xFF23232B),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFF44444D)),
    );

    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        // borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title field
            TextField(
              controller: _titleController,
              style: textFieldStyle,
              decoration: InputDecoration(
                filled: true,
                // fillColor: const Color(0xFF23232B),
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.white12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF44444D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF44444D)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Location field
            TextField(
              controller: _locationController,
              style: textFieldStyle,
              decoration: InputDecoration(
                filled: true,
                // fillColor: const Color(0xFF23232B),
                hintText: "Location or meeting URL",
                hintStyle: TextStyle(color: Colors.white12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF44444D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF44444D)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // All day event row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All day event", style: labelStyle),
                CustomSwitch(
                  value: _isAllDay,
                  onChanged: (val) => setState(() => _isAllDay = val),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Start & End time pickers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Start", style: subLabelStyle),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _DateTimeButton(
                      text:
                          "${monthNames[_startDate.month - 1]} ${_startDate.day}",
                      onTap: () => _pickDate(context, true),
                    ),
                    const SizedBox(width: 8),
                    _TimeButton(
                      text: _startTime.format(context),
                      onTap: _isAllDay ? null : () => _pickTime(context, true),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("End", style: subLabelStyle,),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _DateTimeButton(
                      text:
                          "${monthNames[_startDate.month - 1]} ${_startDate.day}",
                      onTap: () => _pickDate(context, false),
                    ),
                    const SizedBox(width: 8),
                    _TimeButton(
                      text: _endTime.format(context),
                      onTap: _isAllDay ? null : () => _pickTime(context, false),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Repetitive event row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Repetitive event", style: labelStyle),
                CustomSwitch(
                  value: _isRepetitive,
                  onChanged: (val) => setState(() => _isRepetitive = val),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tags
            Text("Tags:", style: labelStyle),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: tags.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(
                    tag,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: tagColors[tag] ?? Colors.grey,
                  backgroundColor: (tagColors[tag] ?? Colors.grey).withOpacity(
                    0.6,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedTags.add(tag);
                      } else {
                        selectedTags.remove(tag);
                      }
                    });
                  },
                  showCheckmark: false,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Notes
            Text("Notes:", style: labelStyle),
            const SizedBox(height: 8),
            Container(
              decoration: boxDecoration,
              child: TextField(
                controller: _notesController,
                style: textFieldStyle,
                maxLines: 4,
                minLines: 4,
                decoration: InputDecoration(
                  hintText: '',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// Helper widgets for Date and Time buttons
class _DateTimeButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const _DateTimeButton({required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF35353F),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const _TimeButton({required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF35353F),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
