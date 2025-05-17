import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show MultipartRequest, MultipartFile;
import 'package:myproject/Screens/widgets/SuccessScreen.dart';

class SpeakerScreen extends StatefulWidget {
  const SpeakerScreen({super.key});

  @override
  SpeakerScreenState createState() => SpeakerScreenState();
}

class SpeakerScreenState extends State<SpeakerScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();

  final List<String> _priceOptions =
      List.generate(20, (index) => '${(index + 1) * 50000}');
  final List<String> _powerOptions =
      List.generate(10, (index) => '${(index + 1) * 5}');
  final List<String> _brandOptions = [
    'JBL',
    'Bose',
    'Sony',
    'Harman Kardon',
    'Pioneer',
    'Kenwood',
    'Alpine',
    'Infinity',
    'Polk Audio',
    'Kicker'
  ];
  final List<String> _stockOptions =
      List.generate(20, (index) => (index + 1).toString());

  String? _selectedBrand, _selectedPower, _selectedPrice, _selectedStock;

  final TextEditingController _categoryNameController =
      TextEditingController(text: "Speakers");

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

        request.fields['category'] = _categoryNameController.text;
        request.fields['category_id'] = '2';
        request.fields['brand'] = _selectedBrand!;
        request.fields['output_power'] = _selectedPower!;
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
      _selectedBrand = null;
      _selectedPower = null;
      _selectedPrice = null;
      _selectedStock = null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: Text(
          'Add Speakers',
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
                    hintText: 'Speakers',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                    'Brand',
                    _brandOptions,
                    _selectedBrand,
                    (v) => setState(() => _selectedBrand = v),
                    (v) => v == null ? 'Select brand' : null),
                _buildDropdown(
                    'Output Power (W)',
                    _powerOptions,
                    _selectedPower,
                    (v) => setState(() => _selectedPower = v),
                    (v) => v == null ? 'Select power output' : null),
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
                    child: Text(
                      'Add Speakers',
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
