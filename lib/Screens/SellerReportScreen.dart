import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SellerReportScreen extends StatefulWidget {
  @override
  _SellerReportScreenState createState() => _SellerReportScreenState();
}

class _SellerReportScreenState extends State<SellerReportScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;

  List<Map<String, dynamic>> _reportData = [];

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime initialDate = isFromDate
        ? (_fromDate ?? DateTime.now())
        : (_toDate ?? DateTime.now());
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = pickedDate;
        } else {
          _toDate = pickedDate;
        }

        if (_fromDate != null && _toDate != null) {
          _generateTableData();
        }
      });
    }
  }

  void _generateTableData() {
    setState(() {
      _reportData = [
        {
          "Product": "Tyre",
          "Details": "Size: 215/60R16, Type: All-Season",
          "Brand": "Goodyear",
          "Car Type": "Sedan",
          "No of customers": 25,
          "Price": "\$50",
          "Total Price": 25 * 50,
        },
        {
          "Product": "Tyre",
          "Details": "Size: 235/50R17, Type: Summer",
          "Brand": "Michelin",
          "Car Type": "SUV",
          "No of customers": 20,
          "Price": "\$70",
          "Total Price": 20 * 70,
        },
        {
          "Product": "Side Mirror",
          "Details": "Car Type: Sedan, Left side",
          "Brand": "AutoZone",
          "No of customers": 30,
          "Price": "\$60",
          "Total Price": 30 * 60,
        },
        {
          "Product": "Side Mirror",
          "Details": "Car Type: SUV, Right side",
          "Brand": "OEM",
          "No of customers": 15,
          "Price": "\$75",
          "Total Price": 15 * 75,
        },
        {
          "Product": "Speaker",
          "Details": "Brand: JBL, Size: 6.5 inch, 2-way",
          "No of customers": 15,
          "Price": "\$40",
          "Total Price": 15 * 40,
        },
        {
          "Product": "Speaker",
          "Details": "Brand: Bose, Size: 8 inch, 3-way",
          "No of customers": 10,
          "Price": "\$80",
          "Total Price": 10 * 80,
        },
        {
          "Product": "Air Filter",
          "Details": "Brand: Fram, Compatible with: Honda Civic",
          "No of customers": 12,
          "Price": "\$25",
          "Total Price": 12 * 25,
        },
      ];
    });
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Sales Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: [
                  'Product',
                  'Details',
                  'Brand',
                  'Car Type',
                  'Customers',
                  'Price',
                  'Total Price'
                ],
                data: _reportData.map((data) {
                  return [
                    data['Product'] ?? 'N/A',
                    data['Details'] ?? 'N/A',
                    data['Brand'] ?? 'N/A',
                    data['Car Type'] ?? 'N/A',
                    data['No of customers'].toString() ?? '0',
                    data['Price'] ?? 'N/A',
                    "\$${data['Total Price'] ?? 0}",
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 164, 243),
      appBar: AppBar(
        title: const Text('Accepted Orders'),
        backgroundColor: const Color.fromARGB(255, 67, 164, 243),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "From Date",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: AbsorbPointer(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 30, 255, 0),
                                hintText: _fromDate == null
                                    ? "Select From Date"
                                    : DateFormat('yyyy-MM-dd')
                                        .format(_fromDate!),
                                hintStyle: TextStyle(color: Colors.blueAccent),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.blueAccent,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Up to Date",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _selectDate(context, false),
                          child: AbsorbPointer(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                filled: true,
                                fillColor: Colors.redAccent,
                                hintText: _toDate == null
                                    ? "Select To Date"
                                    : DateFormat('yyyy-MM-dd').format(_toDate!),
                                hintStyle: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.redAccent,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Display the table if data is available
              if (_reportData.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sales Report",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Scrollable Table for large data
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text("Product")),
                          DataColumn(label: Text("Details")),
                          DataColumn(label: Text("Brand")),
                          DataColumn(label: Text("Car Type")),
                          DataColumn(label: Text("Customers")),
                          DataColumn(label: Text("Price")),
                          DataColumn(label: Text("Total Price")),
                        ],
                        rows: _reportData
                            .map(
                              (data) => DataRow(cells: [
                                DataCell(Text(data['Product'] ?? 'N/A')),
                                DataCell(Text(data['Details'] ?? 'N/A')),
                                DataCell(Text(data['Brand'] ?? 'N/A')),
                                DataCell(Text(data['Car Type'] ?? 'N/A')),
                                DataCell(Text(
                                    data['No of customers'].toString() ?? '0')),
                                DataCell(Text(data['Price'] ?? 'N/A')),
                                DataCell(Text("\$${data['Total Price'] ?? 0}")),
                              ]),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _generatePDF,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 251, 0), // Button background color
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                        elevation: 10, // Shadow effect
                        shadowColor:
                            Colors.black.withOpacity(0.3), // Shadow color
                      ),
                      child: Text(
                        'Download Report',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
