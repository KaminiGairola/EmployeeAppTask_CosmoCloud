import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Modal/employee_model.dart';
import '../Provider/employee_provider.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  final String employeeId;

  UpdateEmployeeScreen({required this.employeeId});

  @override
  _UpdateEmployeeScreenState createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final _nameController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _loadEmployee() async {
    try {
      final employee = await Provider.of<EmployeeProvider>(
          context, listen: false).fetchEmployeeById(widget.employeeId);
      _nameController.text = employee.name;
      _addressLine1Controller.text = employee.addressLine1;
      _cityController.text = employee.city;
      _countryController.text = employee.country;
      _zipCodeController.text = employee.zipCode;
      _emailController.text = employee.email;
    } catch (e) {
      print('Error loading employee data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEmployee();
  }

  Future<void> _updateEmployee() async {
    final updatedEmployee = Employee(
      id: widget.employeeId,
      name: _nameController.text,
      addressLine1: _addressLine1Controller.text,
      city: _cityController.text,
      country: _countryController.text,
      zipCode: _zipCodeController.text,
      email: _emailController.text,
    );

    try {
      await Provider.of<EmployeeProvider>(context, listen: false)
          .updateEmployee(updatedEmployee);
      Navigator.of(context).pop();
    } catch (e) {
      print('Error updating employee: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Employee'),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_nameController, 'Name'),
              _buildTextField(_addressLine1Controller, 'Address Line 1'),
              _buildTextField(_cityController, 'City'),
              _buildTextField(_countryController, 'Country'),
              _buildTextField(_zipCodeController, 'Zip Code'),
              _buildTextField(_emailController, 'Email'),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _updateEmployee,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[300], // Button color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
