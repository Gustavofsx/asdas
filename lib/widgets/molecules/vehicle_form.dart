import 'package:flutter/material.dart';
import '../atoms/custom_button.dart';
import '../atoms/custom_text_field.dart';

class VehicleForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;
  final Map<String, dynamic>? initialData;

  const VehicleForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
    this.initialData,
  });

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _populateFields();
    }
  }

  void _populateFields() {
    final data = widget.initialData!;
    _brandController.text = data['brand'] ?? '';
    _modelController.text = data['model'] ?? '';
    _yearController.text = data['year']?.toString() ?? '';
    _colorController.text = data['color'] ?? '';
    _priceController.text = data['price']?.toString() ?? '';
    _stockController.text = data['stockQuantity']?.toString() ?? '';
    _descriptionController.text = data['description'] ?? '';
    _imageUrlController.text = data['imageUrl'] ?? '';
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  String? _validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ano é obrigatório';
    }
    final year = int.tryParse(value);
    if (year == null) {
      return 'Ano deve ser um número válido';
    }
    if (year < 1900 || year > DateTime.now().year + 1) {
      return 'Ano deve estar entre 1900 e 2025';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preço é obrigatório';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Preço deve ser um número válido';
    }
    if (price <= 0) {
      return 'Preço deve ser maior que zero';
    }
    return null;
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

  String? _validateImageUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL da imagem é obrigatória';
    }
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasAbsolutePath) {
      return 'URL inválida';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = {
        'brand': _brandController.text.trim(),
        'model': _modelController.text.trim(),
        'year': int.parse(_yearController.text),
        'color': _colorController.text.trim(),
        'price': double.parse(_priceController.text),
        'stockQuantity': int.parse(_stockController.text),
        'description': _descriptionController.text.trim(),
        'imageUrl': _imageUrlController.text.trim(),
      };
      
      widget.onSubmit(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Formulário de veículo',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: 'Marca',
              hintText: 'Ex: Toyota',
              controller: _brandController,
              validator: _validateRequired,
              prefixIcon: const Icon(Icons.branding_watermark),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Modelo',
              hintText: 'Ex: Corolla',
              controller: _modelController,
              validator: _validateRequired,
              prefixIcon: const Icon(Icons.directions_car),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Ano',
                    hintText: '2023',
                    controller: _yearController,
                    validator: _validateYear,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Cor',
                    hintText: 'Ex: Branco',
                    controller: _colorController,
                    validator: _validateRequired,
                    prefixIcon: const Icon(Icons.palette),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Preço',
                    hintText: '50000.00',
                    controller: _priceController,
                    validator: _validatePrice,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.attach_money),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Estoque',
                    hintText: '10',
                    controller: _stockController,
                    validator: _validateStock,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.inventory),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Descrição',
              hintText: 'Descrição do veículo...',
              controller: _descriptionController,
              validator: _validateRequired,
              maxLines: 3,
              prefixIcon: const Icon(Icons.description),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'URL da Imagem',
              hintText: 'https://picsum.photos/400/300?random=1',
              controller: _imageUrlController,
              validator: _validateImageUrl,
              prefixIcon: const Icon(Icons.image),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: widget.initialData != null ? 'Atualizar Veículo' : 'Adicionar Veículo',
              onPressed: _submitForm,
              isLoading: widget.isLoading,
              icon: widget.initialData != null ? Icons.update : Icons.add,
            ),
          ],
        ),
      ),
    );
  }
}
