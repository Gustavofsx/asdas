import 'package:flutter/material.dart';
import '../atoms/custom_text_field.dart';
import '../atoms/custom_button.dart';

class StockAdjustmentDialog extends StatefulWidget {
  final int currentStock;
  final Function(int) onAdjust;

  const StockAdjustmentDialog({
    super.key,
    required this.currentStock,
    required this.onAdjust,
  });

  @override
  State<StockAdjustmentDialog> createState() => _StockAdjustmentDialogState();
}

class _StockAdjustmentDialogState extends State<StockAdjustmentDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.currentStock.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validateStock(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantidade é obrigatória';
    }
    final stock = int.tryParse(value);
    if (stock == null) {
      return 'Quantidade deve ser um número válido';
    }
    if (stock < 0) {
      return 'Quantidade não pode ser negativa';
    }
    return null;
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final newStock = int.parse(_controller.text);
      widget.onAdjust(newStock);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF2d3748),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.inventory,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 12),
          const Text(
            'Ajustar Estoque',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estoque atual: ${widget.currentStock} unidades',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Nova Quantidade',
              hintText: 'Digite a nova quantidade',
              controller: _controller,
              validator: _validateStock,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.numbers),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
        CustomButton(
          text: 'Ajustar',
          onPressed: _handleSubmit,
          width: 100,
          height: 40,
        ),
      ],
    );
  }
}
