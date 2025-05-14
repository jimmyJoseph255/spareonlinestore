import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myproject/api_services/auth/auth_sslDisabled.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OTPController extends GetxController {
  var isLoading = false.obs;
  final String mobile;

  OTPController({required this.mobile});

  List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  final ApiService _apiService = ApiService();
  final String otpApiUrl = '/customer/verifyOtp';

  var customer_Token = ''.obs;
  var customer_name = ''.obs;
  var customer_phone = ''.obs;
  var customer_email = ''.obs;

  final box = GetStorage();

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void updateOtpControllers(String otp) {
    for (int i = 0; i < otp.length; i++) {
      otpControllers[i].text = otp[i];
    }
  }

  Future<bool> verifyOTP() async {
    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      isLoading.value = true;
      try {
        final response = await _apiService
            .post(otpApiUrl, {'phone': mobile, 'otp': otp}, headers: {});

        isLoading.value = false;

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['token'] != null) {
            // Store token in GetStorage
            box.write('token', data['token']);

            // Store token in SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('auth_token', data['token']);

            Get.snackbar('Success', 'Logged in successfully',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white);
            return true;
          }
        } else {
          _handleOTPError(response);
          return false;
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", "An error occurred: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
    return false;
  }

  void _handleOTPError(response) {
    var data = jsonDecode(response.body);
    String message = data['message']?.toLowerCase() ?? '';

    if (message.contains('expired')) {
      Get.snackbar("Error", "OTP has expired",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Invalid OTP",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
