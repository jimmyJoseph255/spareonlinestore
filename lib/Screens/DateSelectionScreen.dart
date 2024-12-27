import 'package:flutter/material.dart';
import 'package:myproject/Screens/NextScreen.dart';

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

  // Function to show the bottom sheet
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
                const Spacer(), // Push contents to the bottom
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextScreen(
                          paymentMethod: 'M-PESA', // Example payment method
                          paymentIcon: Icons.monetization_on, // Example icon
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA9411D), // Button color
                    minimumSize:
                        const Size(double.infinity, 60), // Increase size
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
                        child: Icon(
                          Icons.person,
                          color: Color(0xFFA9411D),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sebastian Bennet\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Delivery guy',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
        title: const Text('Select Date and Time'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Depart After',
                          style: TextStyle(fontSize: 16)),
                      ElevatedButton(
                        onPressed: () => _pickDate('depart'),
                        child: Text(
                          _departAfterDate != null
                              ? formattedDepartAfter!
                              : 'Select Date',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Arrive By', style: TextStyle(fontSize: 16)),
                      ElevatedButton(
                        onPressed: () => _pickDate('arrive'),
                        child: Text(
                          _arriveByDate != null
                              ? formattedArriveBy!
                              : 'Select Date',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Select Time:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: Text(_selectedTime.format(context)),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
