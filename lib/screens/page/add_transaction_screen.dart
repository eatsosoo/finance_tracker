import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/widgets/animated_toggle.dart';
import 'package:finance_tracker/widgets/app_bottom_sheet.dart';
import 'package:finance_tracker/widgets/show_bottom_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:finance_tracker/widgets/filter_option.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String amount = '';
  String type = 'income';
  String account = '';
  String category = '';
  DateTime date = DateTime.now();
  final TextEditingController noteController = TextEditingController();

  final List<Map<String, dynamic>> accountOptions = [
    {'title': 'Vietinbank', 'value': '0'},
    {'title': 'Checking', 'value': '1'},
  ];

  final List<Map<String, dynamic>> incomeTags = [
    {'title': 'Drink', 'value': '0'},
    {'title': 'Education', 'value': '1'},
    {'title': 'Food', 'value': '3'},
    {'title': 'Transport', 'value': '4'},
    {'title': 'Shopping', 'value': '5'},
    {'title': 'Gift', 'value': '6'},
    {'title': 'Healthcare', 'value': '7'},
  ];

  final List<Map<String, dynamic>> expenseTags = [
    {'title': 'Salary', 'value': '0'},
    {'title': 'Bonus', 'value': '1'},
  ];

  late Map<String, List<Map<String, dynamic>>> tagOptions;

  final List<ToggleItem> tabs = [
    ToggleItem(
      label: 'Income',
      value: 'income',
      icon: LucideIcons.circleArrowOutDownLeft,
    ),
    ToggleItem(
      label: 'Expense',
      value: 'expense',
      icon: LucideIcons.circleArrowOutUpRight,
    ),
  ];

  @override
  void initState() {
    super.initState();
    tagOptions = {'income': incomeTags, 'expense': expenseTags};
  }

  void _selectAccount() {
    showBottomOptions(
      context: context,
      title: 'Account select',
      filterOptions: accountOptions,
      currentFilter: account,
      onSelected: (value) {
        setState(() => account = value);
      },
    );
  }

  void _selectCategory() async {
    final options = tagOptions[type] ?? [];

    showBottomOptions(
      context: context,
      title: 'Tag select',
      filterOptions: options,
      currentFilter: category,
      onSelected: (value) {
        setState(() => category = value);
      },
    );
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black, // Màu icon & đường viền selected date
              onPrimary: Colors.white, // Màu text trên nút (OK / Cancel)
              surface: Colors.white, // Màu nền calendar
              onSurface: Colors.black, // Màu text ngày thường
            ),
            dialogBackgroundColor: Colors.white, // Màu nền tổng thể
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Nút "CANCEL", "OK"
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => date = picked);
  }

  void _onSubmit() {
    final formData = {
      'account': account,
      'category': category,
      'amount': amount,
      'type': type,
      'date': DateFormat('dd/MM/yyyy').format(date),
      'note': noteController.text,
    };
    print(formData);
  }

  void _inputDigit(String digit) {
    if (digit == 'AC') {
      _clearAmount();
    } else {
      setState(() => amount += digit);
    }
  }

  void _clearAmount() {
    setState(() => amount = '');
  }

  Widget _buildNumberPad(BuildContext context) {
    final keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '000',
      '0',
      'AC',
    ]; // Add empty string to fill grid

    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2, // Giá trị này càng lớn thì nút càng thấp
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [...keys.map((e) => _buildKey(e, context)).toList()],
    );
  }

  Widget _buildKey(String key, BuildContext context) {
    return CustomButton(
      text: key,
      onPressed: () => _inputDigit(key),
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      radius: 20,
      fontSize: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = type == 'expense';
    final displayAmount =
        (isExpense ? '-' : '') + (amount.isEmpty ? '0' : amount) + '₫';

    return Container(
      decoration: BoxDecoration(
        // gradient: backgroundGradient()
        color: Theme.of(context).colorScheme.background
      ),
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedToggle(
            selected: 'income',
            onChanged: (value) {
              setState(() => type = value);
            },
            items: tabs,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.canPop() ? context.pop() : context.go('/home');
            },
            padding: EdgeInsets.all(8),
            icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 🔸 Phần 2: Chiếm phần còn lại
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      displayAmount,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: isExpense ? Colors.red : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: noteController,
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).colorScheme.background,
                          hintText: 'Thêm ghi chú...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          hoverColor: Theme.of(context).colorScheme.background
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildSelectorButton(
                            'Account',
                            account,
                            _selectAccount,
                            context
                          ),
                        ),
                        SizedBox(width: 8), // Khoảng cách giữa các nút
                        Expanded(
                          child: _buildSelectorButton(
                            'Category',
                            category,
                            _selectCategory,
                            context
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _buildSelectorButton(
                            'Date',
                            DateFormat('dd/MM').format(date),
                            _selectDate,
                            context
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _buildNumberPad(context),

                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: CustomButton(
                        text: 'Add transaction',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        onPressed: _onSubmit,
                        radius: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorButton(String label, String value, VoidCallback onTap, BuildContext context) {
    final bool isSelected = value != '';

    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: isSelected ? Colors.orange : Theme.of(context).colorScheme.surface,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey.shade100),
        ),
        child: Text(
          isSelected ? value : label,
          style: TextStyle(
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.orange : Theme.of(context).colorScheme.onSurface
          ),
        ),
      ),
    );
  }
}
