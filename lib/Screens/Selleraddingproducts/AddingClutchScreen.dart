import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show MultipartRequest, MultipartFile;
import 'package:myproject/Screens/widgets/SuccessScreen.dart';

class ClutchScreen extends StatefulWidget {
  const ClutchScreen({super.key});

  @override
  ClutchScreenState createState() => ClutchScreenState();
}

class ClutchScreenState extends State<ClutchScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();

  // Options for dropdowns
  final List<String> _priceOptions =
      List.generate(20, (index) => '${(index + 1) * 50000}');
  final List<String> _makeOptions = [
    'Toyota',
    'Nissan',
    'Honda',
    'Mitsubishi',
    'Ford',
    'BMW',
    'Mercedes',
    'Audi',
    'Volkswagen',
    'Subaru'
  ];
  final List<String> _modelOptions = [
    'Corolla',
    'Camry',
    'Hilux',
    'Premio',
    'Allion',
    'Civic',
    'Accord',
    'Pajero',
    'Lancer',
    'Impreza'
  ];
  final List<String> _yearOptions =
      List.generate(25, (index) => (2000 + index).toString());
  final List<String> _engineTypeOptions = ['hydraulic', 'cable', 'electronic'];
  final List<String> _transmissionOptions = ['manual', 'automatic'];
  final List<String> _partTypeOptions = [
    'clutch_disc',
    'pressure_plate',
    'flywheel',
    'clutch_kit',
    'release_bearing'
  ];
  final List<String> _diameterOptions =
      List.generate(10, (index) => '${(index + 1) * 20}'); // 20mm to 200mm
  final List<String> _splineOptions =
      List.generate(30, (index) => (index + 10).toString()); // 10 to 39
  final List<String> _materialOptions = [
    'organic',
    'ceramic',
    'kevlar',
    'sintered'
  ];
  final List<String> _stockOptions =
      List.generate(20, (index) => (index + 1).toString());

  // Selected values
  String? _selectedMake,
      _selectedModel,
      _selectedYear,
      _selectedEngineType,
      _selectedTransmission,
      _selectedPartType,
      _selectedDiameter,
      _selectedSplineCount,
      _selectedMaterial,
      _selectedPrice,
      _selectedStock;
  bool _isHydraulic = false;

  final TextEditingController _categoryNameController =
      TextEditingController(text: "Clutches");

  File? _image;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = box.read('token');
    if (_token == null) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
    }
    if (_token != null) {
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected.')),
        );
      }
    }
  }

  Future<void> _submitProduct() async {
    if (_formKey.currentState!.validate() && _image != null) {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
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

        request.fields['product_name'] = 'clutches';
        request.fields['category'] = _categoryNameController.text;
        request.fields['category_id'] = '6';
        request.fields['car_make'] = _selectedMake!;
        request.fields['car_model'] = _selectedModel!;
        request.fields['car_year'] = _selectedYear!;
        request.fields['engine_type'] = _selectedEngineType!;
        request.fields['transmission_type'] = _selectedTransmission!;
        request.fields['part_type'] = _selectedPartType!;
        request.fields['disc_diameter_mm'] = _selectedDiameter!;
        request.fields['spline_count'] = _selectedSplineCount!;
        request.fields['material'] = _selectedMaterial!;
        request.fields['is_hydraulic'] = _isHydraulic ? '1' : '0';
        request.fields['price'] = _selectedPrice!;
        request.fields['stock'] = _selectedStock!;

        request.files.add(await MultipartFile.fromPath('image', _image!.path));

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (!mounted) return;
        Navigator.pop(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          _resetForm();
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessScreen()),
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $responseBody')),
          );
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Complete all fields and select an image.')),
        );
      }
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _selectedMake = null;
      _selectedModel = null;
      _selectedYear = null;
      _selectedEngineType = null;
      _selectedTransmission = null;
      _selectedPartType = null;
      _selectedDiameter = null;
      _selectedSplineCount = null;
      _selectedMaterial = null;
      _selectedPrice = null;
      _selectedStock = null;
      _isHydraulic = false;
      _image = null;
    });
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
        title: Text(
          'Add Clutch',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Clutches',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                    'Car Make',
                    _makeOptions,
                    _selectedMake,
                    (v) => setState(() => _selectedMake = v),
                    (v) => v == null ? 'Select car make' : null),
                _buildDropdown(
                    'Car Model',
                    _modelOptions,
                    _selectedModel,
                    (v) => setState(() => _selectedModel = v),
                    (v) => v == null ? 'Select car model' : null),
                _buildDropdown(
                    'Car Year',
                    _yearOptions,
                    _selectedYear,
                    (v) => setState(() => _selectedYear = v),
                    (v) => v == null ? 'Select car year' : null),
                _buildDropdown(
                    'Engine Type',
                    _engineTypeOptions,
                    _selectedEngineType,
                    (v) => setState(() => _selectedEngineType = v),
                    (v) => v == null ? 'Select engine type' : null),
                _buildDropdown(
                    'Transmission Type',
                    _transmissionOptions,
                    _selectedTransmission,
                    (v) => setState(() => _selectedTransmission = v),
                    (v) => v == null ? 'Select transmission type' : null),
                _buildDropdown(
                    'Part Type',
                    _partTypeOptions,
                    _selectedPartType,
                    (v) => setState(() => _selectedPartType = v),
                    (v) => v == null ? 'Select part type' : null),
                _buildDropdown(
                    'Disc Diameter (mm)',
                    _diameterOptions,
                    _selectedDiameter,
                    (v) => setState(() => _selectedDiameter = v),
                    (v) => v == null ? 'Select diameter' : null),
                _buildDropdown(
                    'Spline Count',
                    _splineOptions,
                    _selectedSplineCount,
                    (v) => setState(() => _selectedSplineCount = v),
                    (v) => v == null ? 'Select spline count' : null),
                _buildDropdown(
                    'Material',
                    _materialOptions,
                    _selectedMaterial,
                    (v) => setState(() => _selectedMaterial = v),
                    (v) => v == null ? 'Select material' : null),
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
                _buildSwitch('Is Hydraulic', _isHydraulic,
                    (v) => setState(() => _isHydraulic = v)),
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
                    child: Text(
                      'Add Clutch',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
