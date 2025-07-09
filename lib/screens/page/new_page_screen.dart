import 'package:finance_tracker/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New page',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: Icon(Iconsax.arrow_left_2),
        ),
        actions: const [Icon(Icons.more_horiz, size: 18), SizedBox(width: 12)],
      ),
      body: ListView(children: [
          
        ],
      ),
    );
  }

  Widget _buildPropertyItem(
    IconData icon,
    String title,
    String value, {
    Color? selectedColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 18),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: selectedColor ?? Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
