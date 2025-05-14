import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myproject/api_services/update_Apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInformationScreen extends StatefulWidget {
  @override
  _AccountInformationScreenState createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
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

    if (_token != null) {
      print('Token loaded: $_token');
    } else {
      print('No token found');
    }
    setState(() {});
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> updateProfile() async {
    if (_token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Token missing! Verify OTP again')));
      return;
    }

    try {
      final response = await apiService.post(
        '/customer/update-profile',
        {
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'address': addressController.text,
          'profile_picture': _image?.path,
        },
        file: _image,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'multipart/form-data',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Profile updated!')));

        FocusScope.of(context).unfocus();

        setState(() {
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          addressController.clear();
          _image = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Update failed: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Information',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    child: _image == null
                        ? Icon(Icons.person,
                            size: 80, color: const Color.fromARGB(255, 0, 0, 0))
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 95, 95, 95),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 90),
            ElevatedButton(
              onPressed: updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color.fromARGB(255, 67, 164, 243),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(
                'Update Profile',
                style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
