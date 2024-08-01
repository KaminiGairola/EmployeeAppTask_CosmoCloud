import 'package:flutter/material.dart';

import '../Modal/employee_model.dart';
import '../Services/api_service.dart';


class EmployeeProvider with ChangeNotifier {
  List<Employee> _employees = [];
  final ApiService _apiService = ApiService();

  List<Employee> get employees => _employees;

  Future<void> fetchEmployees() async {
    try {
      _employees = await _apiService.fetchEmployees();
      notifyListeners();
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  Future<Employee> fetchEmployeeById(String id) async {
    try {
      final employee = await _apiService.fetchEmployeeById(id);
      return employee;
    } catch (e) {
      print('Error fetching employee by ID: $e');
      throw Exception('Error fetching employee by ID: $e');
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      await _apiService.createEmployee(employee);
      await fetchEmployees();
    } catch (e) {
      print('Error adding employee: $e');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      await _apiService.updateEmployee(employee);
      await fetchEmployees();
    } catch (e) {
      print('Error updating employee: $e');
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      await _apiService.deleteEmployee(id);
      _employees.removeWhere((employee) => employee.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting employee: $e');
    }
  }
}
