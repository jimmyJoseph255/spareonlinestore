import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myproject/Screens/payments/PaymentSelectionScreen.dart';

class DateSelectionScreen extends StatefulWidget {
  const DateSelectionScreen({super.key});

  @override
  _DateSelectionScreenState createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  DateTime? _departAfterDate;
  DateTime? _arriveByDate;
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Function to pick a date
  Future<void> _pickDate(String type) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2101);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (type == 'depart') {
          _departAfterDate = pickedDate;
        } else if (type == 'arrive') {
          _arriveByDate = pickedDate;
        }
      });
    }
  }

  // Function to pick a time
  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  // Inside your DateSelectionScreen class, update the _showBottomSheet method
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Confirm Pending',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const Icon(
                                Icons.pending,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                          content: const Text(
                            'Please wait while your request is being processed.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    );

                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentSelectionScreen(
                            paymentMethod: 'M-PESA',
                            paymentIcon: Icons.monetization_on,
                          ),
                        ),
                      ).then((selectedPaymentMethod) {
                        if (selectedPaymentMethod != null) {
                          // Handle selected payment method here
                          print(
                              'Selected payment method: $selectedPaymentMethod');
                        }
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA9411D),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('lib/images/profile.jpg'),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sebastian Bennet',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            'Delivery guy',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          iconSize: 30,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? formattedDepartAfter;
    String? formattedArriveBy;

    if (_departAfterDate != null) {
      formattedDepartAfter =
          '${_departAfterDate!.day}/${_departAfterDate!.month}/${_departAfterDate!.year}';
    }
    if (_arriveByDate != null) {
      formattedArriveBy =
          '${_arriveByDate!.day}/${_arriveByDate!.month}/${_arriveByDate!.year}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Date and Time',
          style: GoogleFonts.lato(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Container(
        color: const Color.fromARGB(255, 67, 164, 243),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard(
                context,
                "Depart After: ${_departAfterDate != null ? formattedDepartAfter! : 'Select Date'}",
                Icons.calendar_today,
                () => _pickDate('depart'),
              ),
              SizedBox(height: 20),
              _buildCard(
                context,
                "Arrive By: ${_arriveByDate != null ? formattedArriveBy! : 'Select Date'}",
                Icons.calendar_today,
                () => _pickDate('arrive'),
              ),
              SizedBox(height: 20),
              _buildCard(
                context,
                "Time: ${_selectedTime.format(context)}",
                Icons.access_time,
                _pickTime,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text(
                  'Click to Set',
                  style: GoogleFonts.lato(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            color: Colors.teal.shade900,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.teal),
        onTap: onTap,
      ),
    );
  }
}
