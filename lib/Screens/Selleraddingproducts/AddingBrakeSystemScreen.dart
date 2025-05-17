import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show MultipartRequest, MultipartFile;
import 'package:myproject/Screens/widgets/SuccessScreen.dart';

class AddingBrakeSystemScreen extends StatefulWidget {
  const AddingBrakeSystemScreen({super.key});

  @override
  _AddingBrakeSystemScreenState createState() =>
      _AddingBrakeSystemScreenState();
}

class _AddingBrakeSystemScreenState extends State<AddingBrakeSystemScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Brake system options
  final List<String> _makeOptions = [
    'Toyota',
    'Honda',
    'BMW',
    'Ford',
    'Nissan'
  ];
  final List<String> _modelOptions = [
    'Corolla',
    'Civic',
    '320i',
    'Focus',
    'Altima'
  ];
  final List<String> _yearOptions =
      List.generate(30, (index) => '${2025 - index}');
  final List<String> _brakeTypeOptions = ['disc', 'drum'];
  final List<String> _positionOptions = ['front', 'rear', 'parking'];
  final List<String> _padMaterialOptions = [
    'ceramic',
    'organic',
    'semi-metallic',
    'low-metallic'
  ];
  final List<String> _rotorDiameterOptions =
      List.generate(20, (index) => '${200 + (index * 10)}');
  final List<String> _rotorThicknessOptions =
      List.generate(15, (index) => '${5 + index}');
  final List<String> _pistonCountOptions = ['1', '2', '3', '4', '6', '8'];
  final List<String> _brakeFluidOptions = ['DOT3', 'DOT4', 'DOT5.1'];
  final List<String> _priceOptions =
      List.generate(20, (index) => '${(index + 1) * 10000}');
  final List<String> _stockOptions =
      List.generate(20, (index) => '${index + 1}');

  // Category part options
  final List<String> _categoryPartOptions = [
    'BrakePads',
    'BrakeFluids',
    'BrakeRotor',
    'BrakeCaliper'
  ];

  // Brand options (common brake system brands)
  final List<String> _brandOptions = [
    'Brembo',
    'Bosch',
    'Akebono',
    'TRW',
    'ATE',
    'Raybestos',
    'Wagner',
    'Centric',
  ];

  String? _selectedMake,
      _selectedModel,
      _selectedYear,
      _selectedBrakeType,
      _selectedPosition,
      _selectedPadMaterial,
      _selectedRotorDiameter,
      _selectedRotorThickness,
      _selectedPistonCount,
      _selectedBrakeFluid,
      _selectedPrice,
      _selectedStock,
      _selectedCategoryPart,
      _selectedBrand;

  bool _isAbsCompatible = false;
  File? _image;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final box = GetStorage();
    _token = box.read('token');
    if (_token == null) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
    }
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _image = File(pickedFile.path));
  }

  Future<void> _submitProduct() async {
    if (_formKey.currentState!.validate() &&
        _image != null &&
        _token != null &&
        _selectedCategoryPart != null &&
        _selectedBrand != null) {
      try {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );

        var request = MultipartRequest(
          'POST',
          Uri.parse('https://sparefasta.co.tz/api/products/store'),
        );

        request.headers.addAll({
          'Authorization': 'Bearer $_token',
          'Content-Type': 'multipart/form-data',
        });

        request.fields['product_name'] = 'brake system';
        request.fields['car_make'] = _selectedMake!;
        request.fields['car_model'] = _selectedModel!;
        request.fields['car_year'] = _selectedYear!;
        request.fields['brake_type'] = _selectedBrakeType!;
        request.fields['position'] = _selectedPosition!;
        request.fields['pad_material'] = _selectedPadMaterial!;
        request.fields['rotor_diameter_mm'] = _selectedRotorDiameter!;
        request.fields['rotor_thickness_mm'] = _selectedRotorThickness!;
        request.fields['piston_count'] = _selectedPistonCount!;
        request.fields['is_abs_compatible'] = _isAbsCompatible ? '1' : '0';
        request.fields['brake_fluid_type'] = _selectedBrakeFluid!;
        request.fields['price'] = _selectedPrice!;
        request.fields['stock'] = _selectedStock!;
        request.fields['category_id'] = '3'; // Brake system category_id
        request.fields['category_part'] = _selectedCategoryPart!;
        request.fields['brand'] = _selectedBrand!;

        request.files.add(await MultipartFile.fromPath('image', _image!.path));

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (!mounted) return;
        Navigator.pop(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          _formKey.currentState!.reset();
          setState(() {
            _selectedMake = null;
            _selectedModel = null;
            _selectedYear = null;
            _selectedBrakeType = null;
            _selectedPosition = null;
            _selectedPadMaterial = null;
            _selectedRotorDiameter = null;
            _selectedRotorThickness = null;
            _selectedPistonCount = null;
            _selectedBrakeFluid = null;
            _selectedPrice = null;
            _selectedStock = null;
            _selectedCategoryPart = null;
            _selectedBrand = null;
            _isAbsCompatible = false;
            _image = null;
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessScreen()),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed: $responseBody')));
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Complete all fields and select an image.')));
    }
  }

  Widget _buildDropdown(String label, List<String> options,
      String? selectedItem, void Function(String?) onChanged,
      {String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: onChanged,
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: Text('Select $label'),
            items: options
                .map((value) =>
                    DropdownMenuItem(value: value, child: Text(value)))
                .toList(),
            validator: validator,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, void Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.amber,
            activeTrackColor: Colors.amber[200],
            inactiveThumbColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text('Add Brake System',
            style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown('Car Make', _makeOptions, _selectedMake,
                    (v) => setState(() => _selectedMake = v),
                    validator: (v) => v == null ? 'Select make' : null),
                _buildDropdown('Car Model', _modelOptions, _selectedModel,
                    (v) => setState(() => _selectedModel = v),
                    validator: (v) => v == null ? 'Select model' : null),
                _buildDropdown('Year', _yearOptions, _selectedYear,
                    (v) => setState(() => _selectedYear = v),
                    validator: (v) => v == null ? 'Select year' : null),
                _buildDropdown(
                    'Brake Type',
                    _brakeTypeOptions,
                    _selectedBrakeType,
                    (v) => setState(() => _selectedBrakeType = v),
                    validator: (v) => v == null ? 'Select brake type' : null),
                _buildDropdown('Position', _positionOptions, _selectedPosition,
                    (v) => setState(() => _selectedPosition = v),
                    validator: (v) => v == null ? 'Select position' : null),
                _buildDropdown(
                    'Pad Material',
                    _padMaterialOptions,
                    _selectedPadMaterial,
                    (v) => setState(() => _selectedPadMaterial = v),
                    validator: (v) => v == null ? 'Select pad material' : null),
                _buildDropdown(
                    'Rotor Diameter (mm)',
                    _rotorDiameterOptions,
                    _selectedRotorDiameter,
                    (v) => setState(() => _selectedRotorDiameter = v),
                    validator: (v) =>
                        v == null ? 'Select rotor diameter' : null),
                _buildDropdown(
                    'Rotor Thickness (mm)',
                    _rotorThicknessOptions,
                    _selectedRotorThickness,
                    (v) => setState(() => _selectedRotorThickness = v),
                    validator: (v) =>
                        v == null ? 'Select rotor thickness' : null),
                _buildDropdown(
                    'Piston Count',
                    _pistonCountOptions,
                    _selectedPistonCount,
                    (v) => setState(() => _selectedPistonCount = v),
                    validator: (v) => v == null ? 'Select piston count' : null),
                _buildDropdown(
                    'Brake Fluid Type',
                    _brakeFluidOptions,
                    _selectedBrakeFluid,
                    (v) => setState(() => _selectedBrakeFluid = v),
                    validator: (v) => v == null ? 'Select brake fluid' : null),
                _buildSwitch('ABS Compatible', _isAbsCompatible,
                    (v) => setState(() => _isAbsCompatible = v)),
                _buildDropdown(
                    'Category Part',
                    _categoryPartOptions,
                    _selectedCategoryPart,
                    (v) => setState(() => _selectedCategoryPart = v),
                    validator: (v) =>
                        v == null ? 'Select category part' : null),
                _buildDropdown('Brand', _brandOptions, _selectedBrand,
                    (v) => setState(() => _selectedBrand = v),
                    validator: (v) => v == null ? 'Select brand' : null),
                _buildDropdown('Price (Tsh)', _priceOptions, _selectedPrice,
                    (v) => setState(() => _selectedPrice = v),
                    validator: (v) => v == null ? 'Select price' : null),
                _buildDropdown('Stock', _stockOptions, _selectedStock,
                    (v) => setState(() => _selectedStock = v),
                    validator: (v) => v == null ? 'Select stock' : null),
                const Text('Upload Image',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, elevation: 0),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 10),
                    _image == null
                        ? const Text('No Image Selected',
                            style: TextStyle(fontSize: 16, color: Colors.white))
                        : Image.file(_image!,
                            width: 80, height: 80, fit: BoxFit.cover),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: const Size(200, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Add Product',
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
