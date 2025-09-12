import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
  
  String? _selectedImagePath;
  String? _selectedImageName;
  PlatformFile? _selectedFile;

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
    _selectedImagePath = data['imagePath'] ?? '';
    _selectedImageName = data['imageName'] ?? '';
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
      return 'Ano deve estar entre 1900 e ';
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

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowCompression: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFile = result.files.first;
          _selectedImagePath = _selectedFile!.path ?? 'imagem_selecionada';
          _selectedImageName = _selectedFile!.name;
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Imagem selecionada: '),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao selecionar imagem: '),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _removeImage() {
    setState(() {
      _selectedFile = null;
      _selectedImagePath = null;
      _selectedImageName = null;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validação da imagem
      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, selecione uma imagem do veículo'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final formData = {
        'brand': _brandController.text.trim(),
        'model': _modelController.text.trim(),
        'year': int.parse(_yearController.text),
        'color': _colorController.text.trim(),
        'price': double.parse(_priceController.text),
        'stockQuantity': int.parse(_stockController.text),
        'description': _descriptionController.text.trim(),
        'imagePath': _selectedImagePath,
        'imageName': _selectedImageName,
        'imageUrl': _selectedImagePath ?? 'https://via.placeholder.com/400x300?text=Sem+Imagem',
        'file': _selectedFile,
      };
      
      print('Dados do formulário: '); // Debug
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
            
            // Seção de seleção de imagem
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedFile != null 
                    ? Colors.green 
                    : Colors.grey.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.grey[300],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Imagem do Veículo',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      if (_selectedFile != null)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  if (_selectedFile != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.green,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedFile!.name,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  ' MB',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: _removeImage,
                            icon: const Icon(Icons.close, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Toque para selecionar uma imagem',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Formatos: JPG, PNG, GIF, WEBP',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
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
