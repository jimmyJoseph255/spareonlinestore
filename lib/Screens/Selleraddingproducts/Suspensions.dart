import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show MultipartRequest, MultipartFile;
import 'package:myproject/Screens/widgets/SuccessScreen.dart';

class SuspensionsScreen extends StatefulWidget {
  const SuspensionsScreen({super.key});

  @override
  _SuspensionsScreenState createState() => _SuspensionsScreenState();
}

class _SuspensionsScreenState extends State<SuspensionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final List<String> _makeOptions = ['Audi', 'Toyota', 'BMW'];
  final List<String> _modelOptions = ['Model A', 'Model B', 'Model C'];
  final List<String> _yearOptions =
      List.generate(30, (index) => '${1995 + index}');
  final List<String> _positionOptions = [
    'front_left',
    'front_right',
    'rear_left',
    'rear_right',
    'universal'
  ];
  final List<String> _partTypeOptions = [
    'shock_absorber',
    'strut',
    'coil_spring',
    'control_arm',
    'leaf_spring',
    'stabilizer_bar',
    'ball_joint',
    'bushing',
    'kit'
  ];
  final List<String> _materialOptions = ['steel', 'aluminum', 'nickel'];
  final List<String> _suspensionTechOptions = [
    'standard',
    'AI powered',
    'hydraulic'
  ];
  final List<String> _priceOptions =
      List.generate(10, (index) => '${(index + 1) * 50000}');
  final List<String> _stockOptions =
      List.generate(20, (index) => '${index + 1}');

  String? _selectedMake,
      _selectedModel,
      _selectedYear,
      _selectedPosition,
      _selectedPartType,
      _selectedMaterial,
      _selectedSuspensionTech,
      _selectedPrice,
      _selectedStock;
  bool _isGasFilled = false;
  bool _compatibleWithAwd = false;

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

        request.fields['product_name'] = 'Shocking absorber';
        request.fields['category_id'] = '8';
        request.fields['car_make'] = _selectedMake!;
        request.fields['car_model'] = _selectedModel!;
        request.fields['car_year'] = _selectedYear!;
        request.fields['position'] = _selectedPosition!;
        request.fields['part_type'] = _selectedPartType!;
        request.fields['is_gas_filled'] = _isGasFilled ? '1' : '0';
        request.fields['material'] = _selectedMaterial!;
        request.fields['compatible_with_awd'] = _compatibleWithAwd ? '1' : '0';
        request.fields['suspension_tech'] = _selectedSuspensionTech!;
        request.fields['price'] = _selectedPrice!;
        request.fields['stock'] = _selectedStock!;

        request.files.add(await MultipartFile.fromPath('image', _image!.path));

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');

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
            _selectedSuspensionTech = null;
            _selectedPrice = null;
            _selectedStock = null;
            _isGasFilled = false;
            _compatibleWithAwd = false;
            _image = null;
          });

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SuccessScreen()));
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

  Widget _buildSwitch(String label, bool value, void Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text('Add Suspension',
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildDropdown(
                  'Car Make',
                  _makeOptions,
                  _selectedMake,
                  (v) => setState(() => _selectedMake = v),
                  (v) => v == null ? 'Select make' : null),
              _buildDropdown(
                  'Car Model',
                  _modelOptions,
                  _selectedModel,
                  (v) => setState(() => _selectedModel = v),
                  (v) => v == null ? 'Select model' : null),
              _buildDropdown(
                  'Year',
                  _yearOptions,
                  _selectedYear,
                  (v) => setState(() => _selectedYear = v),
                  (v) => v == null ? 'Select year' : null),
              _buildDropdown(
                  'Position',
                  _positionOptions,
                  _selectedPosition,
                  (v) => setState(() => _selectedPosition = v),
                  (v) => v == null ? 'Select position' : null),
              _buildDropdown(
                  'Part Type',
                  _partTypeOptions,
                  _selectedPartType,
                  (v) => setState(() => _selectedPartType = v),
                  (v) => v == null ? 'Select part type' : null),
              _buildDropdown(
                  'Material',
                  _materialOptions,
                  _selectedMaterial,
                  (v) => setState(() => _selectedMaterial = v),
                  (v) => v == null ? 'Select material' : null),
              _buildDropdown(
                  'Suspension Tech',
                  _suspensionTechOptions,
                  _selectedSuspensionTech,
                  (v) => setState(() => _selectedSuspensionTech = v),
                  (v) => v == null ? 'Select tech' : null),
              _buildDropdown(
                  'Price (Tsh)',
                  _priceOptions,
                  _selectedPrice,
                  (v) => setState(() => _selectedPrice = v),
                  (v) => v == null ? 'Select price' : null),
              _buildDropdown(
                  'Stock',
                  _stockOptions,
                  _selectedStock,
                  (v) => setState(() => _selectedStock = v),
                  (v) => v == null ? 'Select stock' : null),
              _buildSwitch('Is Gas Filled', _isGasFilled,
                  (v) => setState(() => _isGasFilled = v)),
              _buildSwitch('Compatible with AWD', _compatibleWithAwd,
                  (v) => setState(() => _compatibleWithAwd = v)),
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
            ]),
          ),
        ),
      ),
    );
  }
}
