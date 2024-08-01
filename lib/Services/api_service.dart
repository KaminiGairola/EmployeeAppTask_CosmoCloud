import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Modal/employee_model.dart';


class ApiService {
  final String _baseUrl = 'https://free-centralindia.cosmocloud.io/development/api/employeegeneraldetails';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'environmentId': '66aa115839e2fdc09bbba4c4',
    'projectId': '66aa115839e2fdc09bbba4c3',
  };

  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?limit=10&offset=0'), headers: _headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Employee> employees = (data['data'] as List)
            .map((item) => Employee.fromJson(item))
            .toList();
        return employees;
      } else {
        throw Exception('Failed to fetch employees. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employees: $e');
      throw Exception('Error fetching employees: $e');
    }
  }

  Future<Employee> fetchEmployeeById(String id) async {
    try {
      final url = '$_baseUrl/$id';
      final response = await http.get(Uri.parse(url), headers: _headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Employee.fromJson(data);
      } else {
        throw Exception('Failed to fetch employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employee by ID: $e');
      throw Exception('Error fetching employee by ID: $e');
    }
  }

  Future<void> createEmployee(Employee employee) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: json.encode(employee.toJson()),
      );
      if (response.statusCode == 201) {
        print('Employee successfully created.');
      } else {
        throw Exception('Failed to create employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating employee: $e');
      throw Exception('Error creating employee: $e');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      final url = '$_baseUrl/${employee.id}';
      final response = await http.put(
        Uri.parse(url),
        headers: _headers,
        body: json.encode(employee.toJson()),
      );
      if (response.statusCode == 200) {
        print('Employee successfully updated.');
      } else {
        throw Exception('Failed to update employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating employee: $e');
      throw Exception('Error updating employee: $e');
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      final url = '$_baseUrl/$id';
      final response = await http.delete(Uri.parse(url), headers: _headers, body: json.encode({}));
      if (response.statusCode == 200) {
        print('Employee successfully deleted.');
      } else {
        throw Exception('Failed to delete employee. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting employee: $e');
      throw Exception('Error deleting employee: $e');
    }
  }
}
