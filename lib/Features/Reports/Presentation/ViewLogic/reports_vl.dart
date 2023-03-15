import 'package:agriunion/Features/Reports/Domian/Entities/client_entity.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/sales_reports_entity.dart';
import 'package:agriunion/Features/Reports/Domian/Service/reports_bl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:flutter/foundation.dart';

class ReportsVL extends ChangeNotifier {
  final IReportsBL _bl;
  List<Client>? clients = [];
  Client? client;
  List<Product> products = [];
  Product? product;
  SalesReportEntity? report;

  ReportsVL(this._bl);
  void getClients() async {
    clients = await _bl.getClients();
    notifyListeners();
  }

  setClient(Client? value) {
    client = value;
    notifyListeners();
  }

  void getProducts() async {
    products = await _bl.getProducts();
    notifyListeners();
  }

  setProduct(Product? value) {
    product = value;
    notifyListeners();
  }

  exportSalesReport() => _bl.showExportedInvoicePdf(report!);
}
