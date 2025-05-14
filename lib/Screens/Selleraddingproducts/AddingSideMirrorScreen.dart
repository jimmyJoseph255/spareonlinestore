import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myproject/api_services/update_Apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myproject/Screens/widgets/SuccessScreen.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartRequest, MultipartFile;

class SideMirrorScreen extends StatefulWidget {
  const SideMirrorScreen({super.key});

  @override
  _SideMirrorScreenState createState() => _SideMirrorScreenState();
}

class _SideMirrorScreenState extends State<SideMirrorScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final List<String> _priceOptions =
      List.generate(10, (index) => '${(index + 1) * 10000}');
  final List<String> _sideOptions = ['Left', 'Right'];
  final List<String> _materialOptions = ['Plastic', 'Metal', 'Glass'];
  final List<String> _glassTypeOptions = ['Convex', 'Flat', 'BlindSpot'];
  final List<String> _ledIndicatorOptions = ['HasLED', 'NoLED'];
  final List<String> _colorOptions = ['Black', 'White', 'Silver', 'Gray'];
  final List<String> _yearOptions =
      List.generate(25, (index) => (2000 + index).toString());
  final List<String> _carModelOptions = ['Allion', 'Premio', 'Hilux', 'Vitz'];
  final List<String> _makeOptions = ['Toyota', 'Nissan', 'Ford', 'Mazda'];
  final List<String> _stockOptions =
      List.generate(20, (index) => (index + 1).toString());

  String? _selectedPrice,
      _selectedSide,
      _selectedMaterial,
      _selectedGlassType,
      _selectedLedIndicator,
      _selectedColor,
      _selectedYear,
      _selectedCarModel,
      _selectedMake,
      _selectedStock;

  final TextEditingController _categoryNameController = TextEditingController();

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
    if (_formKey.currentState!.validate() && _image != null && _token != null) {
      try {
        // Show loading dialog
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        var request = MultipartRequest(
          'POST',
          Uri.parse('https://sparefasta.co.tz/api/products/store'),
        );

        request.headers.addAll({
          'Authorization': 'Bearer $_token',
          'Content-Type': 'multipart/form-data',
        });

        request.fields['category'] = _categoryNameController.text;
        request.fields['category_id'] = '4'; // fixed category ID
        request.fields['price'] = _selectedPrice!;
        request.fields['side'] = _selectedSide!;
        request.fields['material'] = _selectedMaterial!;
        request.fields['glass_type'] = _selectedGlassType!;
        request.fields['led_indicator'] = _selectedLedIndicator!;
        request.fields['color'] = _selectedColor!;
        request.fields['year'] = _selectedYear!;
        request.fields['car_model'] = _selectedCarModel!;
        request.fields['make'] = _selectedMake!;
        request.fields['stock'] = _selectedStock!;

        request.files.add(
          await MultipartFile.fromPath('image', _image!.path),
        );

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: $responseBody');

        Navigator.pop(context); // dismiss loading dialog

        if (response.statusCode == 200 || response.statusCode == 201) {
          _formKey.currentState!.reset();
          _categoryNameController.clear();
          setState(() {
            _selectedPrice = null;
            _selectedSide = null;
            _selectedMaterial = null;
            _selectedGlassType = null;
            _selectedLedIndicator = null;
            _selectedColor = null;
            _selectedYear = null;
            _selectedCarModel = null;
            _selectedMake = null;
            _selectedStock = null;
            _image = null;
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $responseBody')),
          );
        }
      } catch (e) {
        Navigator.pop(context); // dismiss loading dialog on error
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Complete all fields and select an image.')),
      );
    }
  }

  Widget _buildDropdown(
      String label,
      List<String> options,
      String? selectedItem,
      void Function(String?) onChanged,
      String? Function(String?)? validator) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        appBar: AppBar(
          title: Text(
            'Add Side Mirror',
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
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
                      const SizedBox(height: 16),
                      const Text('Category Name',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _categoryNameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Category Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Category name required' : null,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown(
                          'Price (Tsh)',
                          _priceOptions,
                          _selectedPrice,
                          (v) => setState(() => _selectedPrice = v),
                          (v) => v == null ? 'Select price' : null),
                      _buildDropdown(
                          'Side',
                          _sideOptions,
                          _selectedSide,
                          (v) => setState(() => _selectedSide = v),
                          (v) => v == null ? 'Select side' : null),
                      _buildDropdown(
                          'Material',
                          _materialOptions,
                          _selectedMaterial,
                          (v) => setState(() => _selectedMaterial = v),
                          (v) => v == null ? 'Select material' : null),
                      _buildDropdown(
                          'Glass Type',
                          _glassTypeOptions,
                          _selectedGlassType,
                          (v) => setState(() => _selectedGlassType = v),
                          (v) => v == null ? 'Select glass type' : null),
                      _buildDropdown(
                          'LED Indicator',
                          _ledIndicatorOptions,
                          _selectedLedIndicator,
                          (v) => setState(() => _selectedLedIndicator = v),
                          (v) => v == null ? 'Select LED indicator' : null),
                      _buildDropdown(
                          'Color',
                          _colorOptions,
                          _selectedColor,
                          (v) => setState(() => _selectedColor = v),
                          (v) => v == null ? 'Select color' : null),
                      _buildDropdown(
                          'Year',
                          _yearOptions,
                          _selectedYear,
                          (v) => setState(() => _selectedYear = v),
                          (v) => v == null ? 'Select year' : null),
                      _buildDropdown(
                          'Car Model',
                          _carModelOptions,
                          _selectedCarModel,
                          (v) => setState(() => _selectedCarModel = v),
                          (v) => v == null ? 'Select car model' : null),
                      _buildDropdown(
                          'Make',
                          _makeOptions,
                          _selectedMake,
                          (v) => setState(() => _selectedMake = v),
                          (v) => v == null ? 'Select make' : null),
                      _buildDropdown(
                          'Stock',
                          _stockOptions,
                          _selectedStock,
                          (v) => setState(() => _selectedStock = v),
                          (v) => v == null ? 'Select stock' : null),
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
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 30),
                          ),
                          const SizedBox(width: 10),
                          _image == null
                              ? const Text('No Image Selected',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white))
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
                          child: Text(
                            'Add Product',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                    ])),
          ),
        ));
  }
}
