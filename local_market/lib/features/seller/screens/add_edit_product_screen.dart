import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/services/image_picker_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/product_model.dart';
import '../../../widgets/buttons/outline_button.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../repositories/mock_seller_repository.dart';

class AddEditProductScreen extends StatefulWidget {
  final ProductModel? productToEdit;
  final ImagePickerService? imagePickerService;

  const AddEditProductScreen({
    super.key,
    this.productToEdit,
    this.imagePickerService,
  });

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late ImagePickerService _imagePickerService;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _unitController = TextEditingController(
    text: 'kg',
  );
  final TextEditingController _stockController = TextEditingController(
    text: '50',
  );
  final TextEditingController _descController = TextEditingController();

  String _selectedCategory = 'Fresh Vegetables';
  bool _isAvailable = true;
  String? _imagePath;

  final List<String> _categories = const [
    'Fresh Vegetables',
    'Grocery & Staples',
    'Fruits',
    'Dairy & Eggs',
    'Bakery & Snacks',
    'Fish & Meat',
    'Personal Care',
  ];

  @override
  void initState() {
    super.initState();
    _imagePickerService = widget.imagePickerService ?? AppImagePickerService();

    if (widget.productToEdit != null) {
      final p = widget.productToEdit!;
      _nameController.text = p.name;
      _priceController.text = p.price.toString();
      _unitController.text = p.unit;
      _stockController.text = p.stockQuantity.toString();
      _descController.text = p.description;
      _selectedCategory = p.category;
      _isAvailable = p.available;
      _imagePath = p.imageUrl.isNotEmpty ? p.imageUrl : null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    _stockController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _takeCameraPhoto() async {
    final path = await _imagePickerService.takeCameraPhoto();
    if (path != null && mounted) {
      setState(() {
        _imagePath = path;
      });
    }
  }

  Future<void> _pickGalleryImage() async {
    final path = await _imagePickerService.pickGalleryImage();
    if (path != null && mounted) {
      setState(() {
        _imagePath = path;
      });
    }
  }

  void _onSaveProductPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = MockSellerRepository.instance;
    final shopId = repo.currentShop?.id ?? 'LM-SHOP-847291';
    final isEditing = widget.productToEdit != null;

    final product = ProductModel(
      id: isEditing
          ? widget.productToEdit!.id
          : 'prod_${DateTime.now().millisecondsSinceEpoch}',
      shopId: shopId,
      name: _nameController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0.0,
      unit: _unitController.text.trim(),
      stockQuantity: int.tryParse(_stockController.text.trim()) ?? 1,
      category: _selectedCategory,
      description: _descController.text.trim(),
      imageUrl: _imagePath ?? '',
      available: _isAvailable,
      createdAt: isEditing ? widget.productToEdit!.createdAt : DateTime.now(),
    );

    if (isEditing) {
      await repo.updateProduct(product);
    } else {
      await repo.addProduct(product);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${isEditing ? "Updated" : "Added"} "${product.name}"!'),
        backgroundColor: AppColors.primary,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.productToEdit != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: isEditing ? 'Edit Product' : 'Add New Product',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Selector Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child:
                          _imagePath != null && File(_imagePath!).existsSync()
                          ? ClipRRect(
                              borderRadius: AppSpacing.borderRadiusMd,
                              child: Image.file(
                                File(_imagePath!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 48,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Original Product Photo',
                                    style: AppTypography.caption,
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: '📷 Take Photo',
                            onPressed: _takeCameraPhoto,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: AppOutlineButton(
                            text: '🖼️ Gallery',
                            onPressed: _pickGalleryImage,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              CustomTextField(
                label: 'Product Name *',
                hint: 'e.g. Fresh Desi Tomatoes',
                controller: _nameController,
                validator: (val) => val == null || val.isEmpty
                    ? 'Product name is required'
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),

              const Text('Category *', style: AppTypography.label),
              const SizedBox(height: AppSpacing.xs),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: AppSpacing.md),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Price (₹) *',
                      hint: '35',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      validator: (val) => val == null || val.isEmpty
                          ? 'Price is required'
                          : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: CustomTextField(
                      label: 'Unit *',
                      hint: 'kg, piece, pkt',
                      controller: _unitController,
                      validator: (val) => val == null || val.isEmpty
                          ? 'Unit is required'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              CustomTextField(
                label: 'Stock Quantity',
                hint: '50',
                controller: _stockController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppSpacing.md),

              Material(
                color: Colors.transparent,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Product Availability Status',
                    style: AppTypography.label,
                  ),
                  subtitle: Text(
                    _isAvailable
                        ? 'Status: Available in Shop'
                        : 'Status: Out of Stock',
                  ),
                  value: _isAvailable,
                  onChanged: (val) => setState(() => _isAvailable = val),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              CustomTextField(
                label: 'Description',
                hint: 'Freshly farmed local product...',
                controller: _descController,
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.xl),

              PrimaryButton(
                text: isEditing ? 'Update Product' : 'Save Product',
                icon: Icons.check_circle_outline,
                onPressed: _onSaveProductPressed,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
