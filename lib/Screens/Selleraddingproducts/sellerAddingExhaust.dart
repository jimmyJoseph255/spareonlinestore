import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show MultipartRequest, MultipartFile;
import 'package:myproject/Screens/widgets/SuccessScreen.dart';

class AddExhaustScreen extends StatefulWidget {
  const AddExhaustScreen({super.key});

  @override
  _AddExhaustScreenState createState() => _AddExhaustScreenState();
}

class _AddExhaustScreenState extends State<AddExhaustScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final List<String> _makeOptions = ['Toyota', 'Honda', 'BMW'];
  final List<String> _modelOptions = ['Corolla', 'Civic', '320i'];
  final List<String> _yearOptions =
      List.generate(30, (index) => '${2025 - index}');
  final List<String> _positionOptions = [
    'front',
    'rear',
    'center',
    'universal'
  ];
  final List<String> _partTypeOptions = [
    'kit',
    'muffler',
    'pipe',
    'sensor',
    'flex_pipe',
    'resonator',
    'catalytic_convertor',
    'manifold'
  ];
  final List<String> _materialOptions = ['stainless', 'aluminum', 'mild_steel'];
  final List<String> _fitmentTypeOptions = ['direct_fit', 'universal_fit'];
  final List<String> _priceOptions =
      List.generate(10, (index) => '${(index + 1) * 1000}');
  final List<String> _stockOptions =
      List.generate(20, (index) => '${index + 1}');
  final List<String> _lengthOptions =
      List.generate(20, (index) => '${10 + index}');

  // New diameter options
  final List<String> _diameterOptions = [
    '50',
    '60',
    '70',
    '80',
    '90',
    '100',
    '110',
    '120',
    '130',
    '140',
    '150'
  ];

  String? _selectedMake,
      _selectedModel,
      _selectedYear,
      _selectedPosition,
      _selectedPartType,
      _selectedMaterial,
      _selectedFitmentType,
      _selectedPrice,
      _selectedStock,
      _selectedLength,
      _selectedInletDiameter,
      _selectedOutletDiameter;

  bool _isEmissionApproved = false;
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

        request.fields['product_name'] = 'exhaust';
        request.fields['car_make'] = _selectedMake!;
        request.fields['car_model'] = _selectedModel!;
        request.fields['car_year'] = _selectedYear!;
        request.fields['position'] = _selectedPosition!;
        request.fields['part_type'] = _selectedPartType!;
        request.fields['material'] = _selectedMaterial!;
        request.fields['is_emission_approved'] =
            _isEmissionApproved ? '1' : '0';
        request.fields['fitment_type'] = _selectedFitmentType!;
        request.fields['inlet_diameter_mm'] = _selectedInletDiameter ?? '';
        request.fields['outlet_diameter_mm'] = _selectedOutletDiameter ?? '';
        request.fields['length_mm'] = _selectedLength!;
        request.fields['price'] = _selectedPrice!;
        request.fields['stock'] = _selectedStock!;
        request.fields['category_id'] = '9'; // Exhaust category_id

        request.files.add(await MultipartFile.fromPath('image', _image!.path));

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();

        Navigator.pop(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          _formKey.currentState!.reset();
          setState(() {
            _selectedMake = null;
            _selectedModel = null;
            _selectedYear = null;
            _selectedPosition = null;
            _selectedPartType = null;
            _selectedMaterial = null;
            _selectedFitmentType = null;
            _selectedPrice = null;
            _selectedStock = null;
            _selectedLength = null;
            _selectedInletDiameter = null;
            _selectedOutletDiameter = null;
            _isEmissionApproved = false;
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
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
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
        title: Text('Add Exhaust',
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
                _buildDropdown('Position', _positionOptions, _selectedPosition,
                    (v) => setState(() => _selectedPosition = v),
                    validator: (v) => v == null ? 'Select position' : null),
                _buildDropdown('Part Type', _partTypeOptions, _selectedPartType,
                    (v) => setState(() => _selectedPartType = v),
                    validator: (v) => v == null ? 'Select part type' : null),
                _buildDropdown('Material', _materialOptions, _selectedMaterial,
                    (v) => setState(() => _selectedMaterial = v),
                    validator: (v) => v == null ? 'Select material' : null),
                _buildDropdown(
                    'Fitment Type',
                    _fitmentTypeOptions,
                    _selectedFitmentType,
                    (v) => setState(() => _selectedFitmentType = v),
                    validator: (v) => v == null ? 'Select fitment type' : null),

                // Inlet Diameter Dropdown
                _buildDropdown(
                    'Inlet Diameter',
                    _diameterOptions,
                    _selectedInletDiameter,
                    (v) => setState(() => _selectedInletDiameter = v)),

                // Outlet Diameter Dropdown
                _buildDropdown(
                    'Outlet Diameter',
                    _diameterOptions,
                    _selectedOutletDiameter,
                    (v) => setState(() => _selectedOutletDiameter = v)),

                _buildSwitch('Emission Approved', _isEmissionApproved,
                    (v) => setState(() => _isEmissionApproved = v)),

                _buildDropdown('Length (mm)', _lengthOptions, _selectedLength,
                    (v) => setState(() => _selectedLength = v),
                    validator: (v) => v == null ? 'Select length' : null),
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
