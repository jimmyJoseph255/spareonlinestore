import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myproject/Screens/widgets/SuccessScreen.dart';

class EngineScreen extends StatefulWidget {
  const EngineScreen({super.key});

  @override
  _EngineScreenState createState() => _EngineScreenState();
}

class _EngineScreenState extends State<EngineScreen> {
  final TextEditingController _engineNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedBrand = '';
  String _selectedSize = '';
  File? _image;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Key to handle form validation

  // Method to pick image (use image picker or camera plugin)
  void _pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Source'),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
              child: const Text(
                'Camera',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
              child: const Text(
                'Gallery',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      int maxLines = 1,
      List<TextInputFormatter>? inputFormatters,
      void Function(String)? onChanged,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          validator: validator, // Add validator here
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            hintText: 'Enter $label',
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> items, String selectedItem,
      void Function(String?) onChanged, String? Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedItem.isEmpty ? null : selectedItem,
            onChanged: onChanged,
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: Text('Select $label'),
            items: items
                .map((value) =>
                    DropdownMenuItem(value: value, child: Text(value)))
                .toList(),
            validator: validator, // Add validator here
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
        title: const Text('Add Engine'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Add form key for validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Engine Name', _engineNameController,
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'engine name';
                  }
                  return null;
                }),
                _buildTextField(
                  'Price',
                  _priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (!value.startsWith("TZS ")) {
                      _priceController.value = TextEditingValue(
                        text: "TZS ${value.replaceAll("TZS ", "")}",
                        selection:
                            TextSelection.collapsed(offset: value.length + 4),
                      );
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                _buildTextField('Description', _descriptionController,
                    maxLines: 4, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                }),
                _buildDropdown(
                    'Brand', ['Brand A', 'Brand B', 'Brand C'], _selectedBrand,
                    (newValue) {
                  setState(() => _selectedBrand = newValue ?? '');
                }, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a brand';
                  }
                  return null;
                }),
                const Text(
                  'Upload Image',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.all(0),
                        shadowColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child:
                          Icon(Icons.camera_alt, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Text(
                        _image == null ? 'Choose Image' : 'Image Selected',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SuccessScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: const Size(200, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
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
