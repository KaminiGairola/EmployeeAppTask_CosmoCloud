import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Modal/employee_model.dart';
import '../Provider/employee_provider.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final String employeeId;

  EmployeeDetailScreen({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
        backgroundColor: Colors.purple[300],
      ),
      backgroundColor: Colors.grey[100], // Light background color
      body: FutureBuilder<Employee>(
        future: Provider.of<EmployeeProvider>(context, listen: false).fetchEmployeeById(employeeId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error fetching employee details: ${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (snapshot.hasData) {
            final employee = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Name', employee.name),
                      _buildDetailRow('Address', '${employee.addressLine1}, ${employee.city}, ${employee.country}, ${employee.zipCode}'),
                      _buildDetailRow('Email', employee.email),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                'No employee found',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
