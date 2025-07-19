import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String amount = '';
  String type = 'income';
  String? account;
  String? category;
  DateTime date = DateTime.now();
  final TextEditingController noteController = TextEditingController();

  void _selectAccount() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => _BottomSheetList(title: 'Chọn tài khoản', items: ['Ví', 'Ngân hàng', 'Tiền mặt']),
    );
    if (selected != null) setState(() => account = selected);
  }

  void _selectCategory() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => _BottomSheetList(title: 'Chọn danh mục', items: ['Ăn uống', 'Mua sắm', 'Lương']),
    );
    if (selected != null) setState(() => category = selected);
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
    setState(() => amount += digit);
  }

  void _clearAmount() {
    setState(() => amount = '');
  }

  Widget _buildNumberPad() {
    final keys = ['1','2','3','4','5','6','7','8','9','000','0'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: keys.map((e) => _buildKey(e)).toList(),
    );
  }

  Widget _buildKey(String key) {
    return SizedBox(
      width: 80,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () => _inputDigit(key),
        child: Text(key, style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = type == 'expense';
    final displayAmount = (isExpense ? '-' : '') + (amount.isEmpty ? '0' : amount) + 'đ';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTypeToggle('income', 'Tiền vào'),
                _buildTypeToggle('expense', 'Tiền ra'),
              ],
            ),
            const SizedBox(height: 20),
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
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'Thêm ghi chú...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSelectorButton('Tài khoản', account, _selectAccount),
                _buildSelectorButton('Danh mục', category, _selectCategory),
                _buildSelectorButton(DateFormat('dd/MM').format(date), null, _selectDate),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildNumberPad()),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Thêm vào', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTypeToggle(String value, String label) {
    final selected = type == value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () => setState(() => type = value),
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.black : Colors.grey[200],
        ),
        child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget _buildSelectorButton(String label, String? value, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      child: Text(value ?? label),
    );
  }
}

class _BottomSheetList extends StatelessWidget {
  final String title;
  final List<String> items;

  const _BottomSheetList({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...items.map(
            (e) => ListTile(
              title: Text(e),
              onTap: () => Navigator.pop(context, e),
            ),
          )
        ],
      ),
    );
  }
}
