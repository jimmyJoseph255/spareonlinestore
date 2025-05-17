import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/Screens/Account/AccountInformationScreen.dart';
import 'package:myproject/Screens/Dashboard/DashboardScreen.dart';
import 'package:myproject/Screens/Dashboard/SellerDashboardScreen.dart';
import 'package:myproject/controller.dart';

class SellerOtpPage extends StatelessWidget {
  final String mobile;
  const SellerOtpPage({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    final OTPController controller = Get.put(OTPController(mobile: mobile));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset('lib/images/car.png', width: 200, height: 100),
            const SizedBox(height: 20),
            Text('Seller OTP Verification',
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Enter the OTP sent to $mobile',
                style: GoogleFonts.openSans(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 40),
            OtpTextField(
              numberOfFields: 6,
              fieldWidth: 50,
              filled: true,
              fillColor: Colors.white,
              onSubmit: (otp) async {
                controller.updateOtpControllers(otp);
                if (await controller.verifyOTP()) {
                  Get.offAll(() => SellerDashboardScreen());
                }
              },
            ),
            const SizedBox(height: 30),
            Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (await controller.verifyOTP()) {
                            Get.offAll(() => SellerDashboardScreen());
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: const Size(200, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text(
                          'Verify OTP',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                )),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

Widget _buildOtpForm(OTPController controller) {
  return OtpTextField(
    numberOfFields: 6,
    fieldWidth: 50,
    borderRadius: BorderRadius.circular(10),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    filled: true,
    fillColor: Colors.white,
    borderColor: const Color(0xFF21AD81),
    focusedBorderColor: const Color(0xFF21AD81),
    showFieldAsBox: true,
    onSubmit: (String otp) async {
      controller.updateOtpControllers(otp);
      bool isVerified = await controller.verifyOTP();

      if (isVerified) {
        Get.offAll(() => const SellerDashboardScreen());
      }
    },
  );
}
