import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show MultipartRequest, MultipartFile;
import 'package:myproject/Screens/widgets/SuccessScreen.dart';

class CarBatteriesScreen extends StatefulWidget {
  const CarBatteriesScreen({super.key});

  @override
  _CarBatteriesScreenState createState() => _CarBatteriesScreenState();
}

class _CarBatteriesScreenState extends State<CarBatteriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final List<String> _brandOptions = ['XS Power', 'Optima', 'Bosch'];
  final List<String> _makeOptions = ['Audi', 'Toyota', 'BMW'];
  final List<String> _modelOptions = ['Model A', 'Model B', 'Model C'];
  final List<String> _batteryTypeOptions = [
    'lead-acid',
    'agm',
    'efb',
    'lithium'
  ];
  final List<String> _terminalTypeOptions = ['top', 'side', 'L'];
  final List<String> _priceOptions =
      List.generate(10, (index) => '${(index + 1) * 10000}');
  final List<String> _stockOptions =
      List.generate(20, (index) => '${index + 1}');
  final List<String> _yearOptions =
      List.generate(30, (index) => '${2025 - index}');
  final List<String> _voltageOptions = ['6', '12', '24', '48'];
  final List<String> _capacityOptions = [
    '35',
    '45',
    '55',
    '60',
    '75',
    '100',
    '120'
  ];
  final List<String> _ccaOptions = ['300', '400', '500', '600', '700', '800'];

  String? _selectedBrand,
      _selectedMake,
      _selectedModel,
      _selectedBatteryType,
      _selectedTerminalType,
      _selectedPrice,
      _selectedStock,
      _selectedYear,
      _selectedVoltage,
      _selectedCapacity,
      _selectedCca;

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

        request.fields['brand'] = _selectedBrand!;
        request.fields['car_make'] = _selectedMake!;
        request.fields['car_model'] = _selectedModel!;
        request.fields['car_year'] = _selectedYear!;
        request.fields['voltage'] = _selectedVoltage!;
        request.fields['capacity_ah'] = _selectedCapacity!;
        request.fields['cca_rating'] = _selectedCca!;
        request.fields['battery_type'] = _selectedBatteryType!;
        request.fields['terminal_type'] = _selectedTerminalType!;
        request.fields['price'] = _selectedPrice!;
        request.fields['stock'] = _selectedStock!;
        request.fields['category_id'] = '7'; // Car Batteries category_id

        request.files.add(await MultipartFile.fromPath('image', _image!.path));

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');

        Navigator.pop(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          _formKey.currentState!.reset();
          setState(() {
            _selectedBrand = null;
            _selectedMake = null;
            _selectedModel = null;
            _selectedBatteryType = null;
            _selectedTerminalType = null;
            _selectedPrice = null;
            _selectedStock = null;
            _selectedYear = null;
            _selectedVoltage = null;
            _selectedCapacity = null;
            _selectedCca = null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text('Add Car Battery',
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
                  'Brand',
                  _brandOptions,
                  _selectedBrand,
                  (v) => setState(() => _selectedBrand = v),
                  (v) => v == null ? 'Select brand' : null),
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
                  'Voltage',
                  _voltageOptions,
                  _selectedVoltage,
                  (v) => setState(() => _selectedVoltage = v),
                  (v) => v == null ? 'Select voltage' : null),
              _buildDropdown(
                  'Capacity (Ah)',
                  _capacityOptions,
                  _selectedCapacity,
                  (v) => setState(() => _selectedCapacity = v),
                  (v) => v == null ? 'Select capacity' : null),
              _buildDropdown(
                  'CCA Rating',
                  _ccaOptions,
                  _selectedCca,
                  (v) => setState(() => _selectedCca = v),
                  (v) => v == null ? 'Select CCA' : null),
              _buildDropdown(
                  'Battery Type',
                  _batteryTypeOptions,
                  _selectedBatteryType,
                  (v) => setState(() => _selectedBatteryType = v),
                  (v) => v == null ? 'Select type' : null),
              _buildDropdown(
                  'Terminal Type',
                  _terminalTypeOptions,
                  _selectedTerminalType,
                  (v) => setState(() => _selectedTerminalType = v),
                  (v) => v == null ? 'Select terminal' : null),
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
