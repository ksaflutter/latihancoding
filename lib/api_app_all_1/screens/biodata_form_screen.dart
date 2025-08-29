import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_app_all_1/widgets/custom_button.dart';
import 'package:flutter_application_1/api_app_all_1/widgets/custom_input.dart';

import '../models/biodata.dart';
import '../services/db_helper.dart';
import '../services/shared_prefs_service.dart';

class BiodataFormScreenAll1 extends StatefulWidget {
  final Biodata? biodata;

  const BiodataFormScreenAll1({super.key, this.biodata});

  @override
  State<BiodataFormScreenAll1> createState() => _BiodataFormScreenAll1State();
}

class _BiodataFormScreenAll1State extends State<BiodataFormScreenAll1> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _registrationDate = DateTime.now();
  String _selectedGender = 'Male';
  String _selectedClass = '10A';
  String _selectedCourse = 'Mathematics';

  bool _isLoading = false;
  bool get isEditing => widget.biodata != null;

  final List<String> _genders = ['Male', 'Female'];
  final List<String> _classes = ['10A', '10B', '11A', '11B', '12A', '12B'];
  final List<String> _courses = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Computer Science',
    'Physical Education',
    'Art',
    'Music'
  ];

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _loadBiodataData();
    }
  }

  void _loadBiodataData() {
    final biodata = widget.biodata!;
    _fullNameController.text = biodata.fullName;
    _addressController.text = biodata.address;
    _phoneController.text = biodata.phone;
    _selectedDate = biodata.dateOfBirth;
    _selectedGender = biodata.gender;
    _selectedClass = biodata.studentClass;
    _selectedCourse = biodata.course;
    _registrationDate = biodata.registrationDate;

    // Parse time from string
    final timeParts = biodata.registrationTime.split(':');
    _selectedTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectRegistrationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _registrationDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _registrationDate) {
      setState(() {
        _registrationDate = picked;
      });
    }
  }

  Future<void> _saveBiodata() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final userId = await SharedPrefsServiceAll1.getCustomerId();
        if (userId == null) {
          throw Exception('User not logged in');
        }

        final biodata = Biodata(
          id: isEditing ? widget.biodata!.id : null,
          fullName: _fullNameController.text.trim(),
          dateOfBirth: _selectedDate,
          gender: _selectedGender,
          address: _addressController.text.trim(),
          phone: _phoneController.text.trim(),
          studentClass: _selectedClass,
          course: _selectedCourse,
          registrationDate: _registrationDate,
          registrationTime:
              '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
          userId: userId,
        );

        if (isEditing) {
          await DBHelperAll1.instance.updateBiodata(biodata);
        } else {
          await DBHelperAll1.instance.insertBiodata(biodata);
        }

        setState(() {
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing
                    ? 'Biodata updated successfully!'
                    : 'Biodata saved successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );

          if (isEditing) {
            Navigator.pop(context, true);
          } else {
            _resetForm();
          }
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _resetForm() {
    _fullNameController.clear();
    _addressController.clear();
    _phoneController.clear();
    setState(() {
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
      _registrationDate = DateTime.now();
      _selectedGender = 'Male';
      _selectedClass = '10A';
      _selectedCourse = 'Mathematics';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isEditing ? AppBar(title: const Text('Edit Biodata')) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Full Name
              CustomInput(
                controller: _fullNameController,
                label: 'Full Name',
                hint: 'Enter student full name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date of Birth
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(),
                ),
                items: _genders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Address
              CustomInput(
                controller: _addressController,
                label: 'Address',
                hint: 'Enter complete address',
                icon: Icons.home,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  if (value.length < 10) {
                    return 'Please enter complete address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              CustomInput(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'Enter phone number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Class Selection
              DropdownButtonFormField<String>(
                value: _selectedClass,
                decoration: const InputDecoration(
                  labelText: 'Class',
                  prefixIcon: Icon(Icons.class_),
                  border: OutlineInputBorder(),
                ),
                items: _classes.map((String studentClass) {
                  return DropdownMenuItem<String>(
                    value: studentClass,
                    child: Text(studentClass),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedClass = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Course Selection
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
                items: _courses.map((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCourse = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Registration Date
              InkWell(
                onTap: () => _selectRegistrationDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Registration Date',
                    prefixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    '${_registrationDate.day}/${_registrationDate.month}/${_registrationDate.year}',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Registration Time
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Registration Time',
                    prefixIcon: Icon(Icons.access_time),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              CustomButton(
                text: isEditing ? 'Update Biodata' : 'Save Biodata',
                onPressed: _saveBiodata,
                isLoading: _isLoading,
              ),

              if (!isEditing) ...[
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Reset Form',
                  onPressed: _resetForm,
                  isOutlined: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
