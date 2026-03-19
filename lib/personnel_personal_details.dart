import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'vehicle_information.dart';

class PersonnelPersonalDetails extends StatefulWidget {
  @override
  State<PersonnelPersonalDetails> createState() => _PersonnelPersonalDetailsState();
}

class _PersonnelPersonalDetailsState extends State<PersonnelPersonalDetails> {
  final TextEditingController _nameController = TextEditingController();
  
  DateTime? _selectedDate;
  String? _age;
  String? _selectedSex;
  
  String? _nameError;
  String? _dateError;
  String? _sexError;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 18)), // Default to 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _age = _calculateAge(picked);
        _dateError = null;
      });
    }
  }

  String _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  void _handleNext() {
    setState(() {
      _nameError = null;
      _dateError = null;
      _sexError = null;

      if (_nameController.text.isEmpty) {
        _nameError = "Name is required";
      }

      if (_selectedDate == null) {
        _dateError = "Please select your birthday";
      }

      if (_selectedSex == null) {
        _sexError = "Please select your sex";
      }

      if (_nameError == null && _dateError == null && _sexError == null) {
        // All validations passed - move to vehicle info
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VehicleInformation()),
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
            colors: [
              Color(0xFF00ADEF),
              const Color.fromARGB(255, 23, 0, 231)
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Personal Information", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Fill in your details", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: _nameError,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: InkWell(
                                  onTap: () => _selectDate(context),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      hintText: "Birthday",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      errorText: _dateError,
                                      suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                                    ),
                                    child: Text(
                                      _selectedDate == null
                                          ? "Select Birthday"
                                          : "${_selectedDate!.toLocal()}".split(' ')[0] + (_age != null ? " (Age: $_age)" : ""),
                                      style: TextStyle(color: _selectedDate == null ? Colors.grey : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: DropdownButtonFormField<String>(
                                  initialValue: _selectedSex,
                                  decoration: InputDecoration(
                                    hintText: "Sex",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: _sexError,
                                  ),
                                  items: ['Male', 'Female'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedSex = newValue;
                                      _sexError = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1500), child: MaterialButton(
                          onPressed: _handleNext,
                          height: 50,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                        SizedBox(height: 40,),
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
}
