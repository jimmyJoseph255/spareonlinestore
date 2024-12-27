import 'package:flutter/material.dart';

class ProfileImage extends ChangeNotifier {
  String _imagePath = 'lib/images/profile.jpg'; // Default image path

  String get imagePath => _imagePath;

  void updateImage(String newImagePath) {
    _imagePath = newImagePath;
    notifyListeners(); // Notify listeners (screens) that the image has been updated
  }
}
