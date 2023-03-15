import 'dart:io';

import 'package:agriunion/Features/Reports/Data/Repository/sales_reports_repository.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/client_entity.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/sales_reports_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';

import '../../../../App/Utilities/system_files.dart';

abstract class IReportsBL {
  Future<List<Product>> getProducts();
  Future<List<Client>> getClients();
  Future<void> showExportedInvoicePdf(SalesReportEntity entity);
}

class ReportsBL implements IReportsBL {
  final ISalesReportsRepository _repository;
  ReportsBL(this._repository);
  @override
  Future<List<Product>> getProducts() async {
    return await _repository.getProducts();
  }

  @override
  Future<List<Client>> getClients() async {
    return await _repository.getClients();
  }

  @override
  Future<void> showExportedInvoicePdf(SalesReportEntity entity) async {
    File? file = await _repository.exportSalesReportPDF(
        entity,  'sales report');
    SystemFileManager.openFile(file);
  }
}
