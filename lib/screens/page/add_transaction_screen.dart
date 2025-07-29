import 'package:finance_tracker/widgets/animated_toggle.dart';
import 'package:finance_tracker/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:finance_tracker/widgets/filter_option.dart';
import 'package:go_router/go_router.dart';

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
    ToggleItem(label: 'Income', value: 'income', icon: Iconsax.money_recive),
    ToggleItem(label: 'Expense', value: 'expense', icon: Iconsax.money_send),
  ];

  @override
  void initState() {
    super.initState();
    tagOptions = {'income': incomeTags, 'expense': expenseTags};
  }

  void _selectAccount() {
    AppBottomSheet.show(
      context: context,
      title: 'Account select',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ...accountOptions.map((option) {
              final index = accountOptions.indexOf(option);
              return Column(
                children: [
                  buildFilterOption(
                    context,
                    title: option['title'],
                    value: option['value'],
                    currentFilter: account,
                    onTap: () {
                      setState(() => account = option['title']);
                      Navigator.pop(context);
                    },
                  ),
                  if (index !=
                      accountOptions.length -
                          1) // Không thêm Divider sau option cuối
                    Divider(height: 1, color: Colors.grey[100]),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _selectCategory() async {
    final options = tagOptions[type] ?? [];

    AppBottomSheet.show(
      context: context,
      title: 'Tag select',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ...options.map((option) {
              final index = options.indexOf(option);
              return Column(
                children: [
                  buildFilterOption(
                    context,
                    title: option['title'],
                    value: option['value'],
                    currentFilter: category,
                    onTap: () {
                      setState(() => category = option['title']);
                      Navigator.pop(context);
                    },
                  ),
                  if (index !=
                      options.length - 1) // Không thêm Divider sau option cuối
                    Divider(height: 1, color: Colors.grey[100]),
                ],
              );
            }).toList(),
          ],
        ),
      ),
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

  Widget _buildNumberPad() {
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
        childAspectRatio: 2.5, // Giá trị này càng lớn thì nút càng thấp
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        _buildSelectorButton('Account', account, _selectAccount),
        _buildSelectorButton('Tag', category, _selectCategory),
        _buildSelectorButton(DateFormat('dd/MM').format(date), '', _selectDate),
        ...keys.map((e) => _buildKey(e)).toList(),
      ],
    );
  }

  Widget _buildKey(String key) {
    return CustomButton(
      text: key,
      onPressed: () => _inputDigit(key),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black54,
      radius: 8,
      fontSize: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = type == 'expense';
    final displayAmount =
        (isExpense ? '-' : '') + (amount.isEmpty ? '0' : amount) + '₫';

    return Scaffold(
      appBar: AppBar(
        title: AnimatedToggle(
          selected: 'income',
          onChanged: (value) {
            setState(() => type = value);
          },
          items: tabs,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.canPop() ? context.pop() : context.go('/home');
          },
          icon: Icon(Icons.clear, color: Colors.grey.shade200,),
        ),
      ),
      backgroundColor: Colors.white,
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
                      color: isExpense ? Colors.red : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: noteController,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Thêm ghi chú...',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Column(
                children: [
                  _buildNumberPad(),

                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: CustomButton(
                      text: 'Add transaction',
                      onPressed: _onSubmit,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectorButton(String label, String value, VoidCallback onTap) {
    final bool isSelected = value != '';

    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
      ),
      child: Text(
        isSelected ? value : label,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
