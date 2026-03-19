import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VehicleInformation extends StatefulWidget {
  @override
  State<VehicleInformation> createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformation> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _orcrController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();

  DateTime? _expirationDate;
  String? _expirationError;

  File? _licenseFront;
  File? _licenseBack;
  File? _orcrFront;
  File? _orcrBack;

  String? _modelError;
  String? _colorError;
  String? _plateError;
  String? _orcrError;
  String? _licenseError;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, String target) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return;
    setState(() {
      final file = File(picked.path);
      switch (target) {
        case 'licenseFront':
          _licenseFront = file;
          break;
        case 'licenseBack':
          _licenseBack = file;
          break;
        case 'orcrFront':
          _orcrFront = file;
          break;
        case 'orcrBack':
          _orcrBack = file;
          break;
      }
    });
  }

  void _selectExpiration(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 10)),
    );
    if (picked != null) {
      setState(() {
        _expirationDate = picked;
        _expirationError = null;
      });
    }
  }

  void _handleSubmit() {
    setState(() {
      _modelError = null;
      _colorError = null;
      _plateError = null;
      _orcrError = null;
      _licenseError = null;
      _expirationError = null;

      if (_modelController.text.isEmpty) {
        _modelError = 'Vehicle model is required';
      }
      if (_colorController.text.isEmpty) {
        _colorError = 'Color is required';
      }
      if (_plateController.text.isEmpty) {
        _plateError = 'Plate number is required';
      }
      if (_orcrController.text.isEmpty) {
        _orcrError = 'OR/CR number is required';
      }
      if (_licenseController.text.isEmpty) {
        _licenseError = 'Driver\'s license number is required';
      }
      if (_expirationDate == null) {
        _expirationError = 'Expiration date is required';
      }
      if (_licenseFront == null || _licenseBack == null) {
        _licenseError = 'Both sides of the license must be uploaded';
      }
      if (_orcrFront == null || _orcrBack == null) {
        _orcrError = 'Both sides of the OR/CR must be uploaded';
      }

      if (_modelError == null &&
          _colorError == null &&
          _plateError == null &&
          _orcrError == null &&
          _licenseError == null &&
          _expirationError == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehicle information saved successfully!')),
        );
      }
    });
  }

  @override
  void dispose() {
    _modelController.dispose();
    _colorController.dispose();
    _plateController.dispose();
    _orcrController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Widget _buildImagePicker(String label, File? file, String target) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery, target),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey.shade100,
                ),
                child: file == null
                    ? Icon(Icons.photo, color: Colors.grey)
                    : Image.file(file, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16),
            Text('Tap to upload'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Color(0xFF00ADEF), const Color.fromARGB(255, 23, 0, 231)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text("Vehicle Information",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold))),
                  SizedBox(height: 10),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text("Provide vehicle details",
                          style: TextStyle(color: Colors.white, fontSize: 18))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 40),
                      FadeInUp(
                        duration: Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              _buildTextField(_modelController, "Vehicle Model", _modelError),
                              _buildTextField(_colorController, "Color", _colorError),
                              _buildTextField(_plateController, "Plate Number", _plateError),
                              _buildTextField(_orcrController, "OR/CR Number", _orcrError),
                              _buildTextField(_licenseController, "Driver's License Number", _licenseError),
                              InkWell(
                                onTap: () => _selectExpiration(context),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    hintText: "Expiration",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: _expirationError,
                                    suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                                  ),
                                  child: Text(
                                    _expirationDate == null
                                        ? "Select Expiration Date"
                                        : "${_expirationDate!.toLocal()}".split(' ')[0],
                                    style: TextStyle(
                                        color: _expirationDate == null
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              _buildImagePicker("License Front", _licenseFront, 'licenseFront'),
                              SizedBox(height: 10),
                              _buildImagePicker("License Back", _licenseBack, 'licenseBack'),
                              SizedBox(height: 10),
                              _buildImagePicker("OR/CR Front", _orcrFront, 'orcrFront'),
                              SizedBox(height: 10),
                              _buildImagePicker("OR/CR Back", _orcrBack, 'orcrBack'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: MaterialButton(
                            onPressed: _handleSubmit,
                            height: 50,
                            color: Colors.orange[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, String? error) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          errorText: error,
        ),
      ),
    );
  }
}
