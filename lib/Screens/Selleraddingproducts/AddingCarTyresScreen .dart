import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myproject/api_services/update_Apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myproject/Screens/widgets/SuccessScreen.dart';
import 'package:http/http.dart' show MultipartRequest, MultipartFile;

class CarTyresScreen extends StatefulWidget {
  const CarTyresScreen({super.key});

  @override
  _CarTyresScreenState createState() => _CarTyresScreenState();
}

class _CarTyresScreenState extends State<CarTyresScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final List<String> _brandOptions = ['Brand A', 'Brand B', 'Brand C'];
  final List<String> _priceOptions =
      List.generate(10, (index) => '${(index + 1) * 10000}');
  final List<String> _stockOptions =
      List.generate(20, (index) => (index + 1).toString());
  final List<String> _widthOptions =
      List.generate(40, (index) => '${150 + (index * 5)}');
  final List<String> _aspectRatioOptions =
      List.generate(20, (index) => '${30 + (index * 5)}');
  final List<String> _diameterOptions =
      List.generate(15, (index) => '${12 + index}');
  final List<String> _tyreNameOptions = [
    'SuperGrip',
    'RoadMaster',
    'EcoDrive',
    'Speedster',
    'MaxTraction'
  ];

  String? _selectedBrand,
      _selectedPrice,
      _selectedStock,
      _selectedWidth,
      _selectedAspectRatio,
      _selectedDiameter,
      _selectedTyreName;

  final TextEditingController _descriptionController = TextEditingController();

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

        request.fields['name'] = _selectedTyreName!;
        request.fields['price'] = _selectedPrice!;
        request.fields['description'] = _descriptionController.text;
        request.fields['brand'] = _selectedBrand!;
        request.fields['stock'] = _selectedStock!;
        request.fields['width'] = _selectedWidth!;
        request.fields['aspect_ratio'] = _selectedAspectRatio!;
        request.fields['diameter'] = _selectedDiameter!;
        request.fields['category_id'] = '1';

        request.files.add(await MultipartFile.fromPath('image', _image!.path));

        var response = await request.send();
        final responseBody = await response.stream.bytesToString();

        Navigator.pop(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          _formKey.currentState!.reset();
          _descriptionController.clear();
          setState(() {
            _selectedBrand = null;
            _selectedPrice = null;
            _selectedStock = null;
            _selectedWidth = null;
            _selectedAspectRatio = null;
            _selectedDiameter = null;
            _selectedTyreName = null;
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
        Navigator.pop(context);
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
          'Add Car Tyre',
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 16),
              _buildDropdown(
                  'Tyre Name',
                  _tyreNameOptions,
                  _selectedTyreName,
                  (v) => setState(() => _selectedTyreName = v),
                  (v) => v == null ? 'Select tyre name' : null),
              _buildDropdown(
                  'Brand',
                  _brandOptions,
                  _selectedBrand,
                  (v) => setState(() => _selectedBrand = v),
                  (v) => v == null ? 'Select brand' : null),
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
              _buildDropdown(
                  'Width',
                  _widthOptions,
                  _selectedWidth,
                  (v) => setState(() => _selectedWidth = v),
                  (v) => v == null ? 'Select width' : null),
              _buildDropdown(
                  'Aspect Ratio',
                  _aspectRatioOptions,
                  _selectedAspectRatio,
                  (v) => setState(() => _selectedAspectRatio = v),
                  (v) => v == null ? 'Select aspect ratio' : null),
              _buildDropdown(
                  'Diameter',
                  _diameterOptions,
                  _selectedDiameter,
                  (v) => setState(() => _selectedDiameter = v),
                  (v) => v == null ? 'Select diameter' : null),
              const SizedBox(height: 16),
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
                    'Add Product',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
