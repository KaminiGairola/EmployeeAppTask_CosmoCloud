import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Modal/employee_model.dart';
import '../Provider/employee_provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _nameController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        backgroundColor: Colors.purple[300],
      ),
      backgroundColor: Colors.grey[50], // Light background color for the entire screen
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[300], // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                  onPressed: () async {
                    final newEmployee = Employee(
                      id: '', // Assuming ID is auto-generated
                      name: _nameController.text,
                      addressLine1: _addressLine1Controller.text,
                      city: _cityController.text,
                      country: _countryController.text,
                      zipCode: _zipCodeController.text,
                      email: _emailController.text,
                    );

                    try {
                      await Provider.of<EmployeeProvider>(context, listen: false).addEmployee(newEmployee);
                      Navigator.of(context).pop(); // Return to the previous screen
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error adding employee: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text('Create', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
