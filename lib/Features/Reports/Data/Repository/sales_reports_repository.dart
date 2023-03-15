import 'dart:io';

import 'package:agriunion/App/Utilities/system_files.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Reports/Data/Mappers/client_mapper.dart';
import 'package:agriunion/Features/Reports/Data/Networking/sales_report_networking.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/client_entity.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/sales_reports_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_mapper.dart';

abstract class ISalesReportsRepository {
  Future<File?> exportSalesReportPDF(SalesReportEntity model, String name);
  Future<List<Product>> getProducts();
  Future<List<Client>> getClients();
}

class SalesReportsRepository implements ISalesReportsRepository {
  final ISalesReportsNetworking _networing;
  SalesReportsRepository(this._networing);

  List<Product> convertToListProducts(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => ProductsMapper.fromJson(e)).toList();
  }

  List<Client> convertToListClients(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => ClientMapper.fromJson(e)).toList();
  }

  @override
  Future<File?> exportSalesReportPDF(
      SalesReportEntity model, String name) async {
    final response = await _networing.exportSalesReportPDF(model.toUrl());
    File? file = await SystemFileManager.convertResponseToFile(response, name);
    return file;
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await _networing.getProducts();
    final jsonResponse = Utils.convertToListJson(response);
    final products = convertToListProducts(jsonResponse);
    return products;
  }

  @override
  Future<List<Client>> getClients() async {
    final response = await _networing.getClients();
    final jsonResponse = Utils.convertToListJson(response);
    final clients = convertToListClients(jsonResponse);
    return clients;
  }
}
