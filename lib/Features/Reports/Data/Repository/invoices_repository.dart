import 'dart:io';

import 'package:agriunion/App/Utilities/system_files.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Reports/Data/Mappers/invoice_mapper.dart';
import 'package:agriunion/Features/Reports/Data/Networking/invoices_networking.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';

abstract class IInvoicesRepository {
  Future<File?> showExportedInvoicePdf(int invoiceId);
  Future<InvoicesModel?> showExportedInvoice(int invoiceId);
  Future<InvoicesModel> exportInvoice(InvoicesModel model, int orderId);
  Future<InvoicesModel> exportSalesReturnInvoice(int salesReturnId);
  Future<File?> showExportedSalesReturnInvoice(int invoiceId);
  Future<List<InvoicesModel>> getInvoices();
  Future<List<InvoicesModel>> getMyInvoices();
}

class InvoicesRepository implements IInvoicesRepository {
  final IInvoicesNetworking _networing;
  InvoicesRepository(this._networing);

  InvoicesModel convertToModel(Map<String, dynamic> jsonResponse) {
    return InvoicesMapper.fromJson(jsonResponse);
  }
  List<InvoicesModel> convertToListModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => InvoicesMapper.fromJson(e)).toList();
  }

  @override
  Future<InvoicesModel> exportInvoice(InvoicesModel model, int orderId) async {
    final response =
        await _networing.exportInvoice(InvoicesMapper.toMap(model), orderId);
    final jsonResponse = Utils.convertToJson(response);
    final invoice = convertToModel(jsonResponse);
    return invoice;
  }

  @override
  Future<File?> showExportedInvoicePdf(int invoiceId) async {
    final response = await _networing.showExportedInvoicePDF(invoiceId);
    File? file =
        await SystemFileManager.convertResponseToFile(response, invoiceId);
    return file;
  }

  @override
  Future<InvoicesModel?> showExportedInvoice(int invoiceId) async {
    final response = await _networing.showExportedInvoice(invoiceId);
    final jsonResponse = Utils.convertToJson(response);
    final invoice = convertToModel(jsonResponse);
    return invoice;
  }

  @override
  Future<InvoicesModel> exportSalesReturnInvoice(int salesReturnId) async {
    final response = await _networing.exportSalesReturnInvoice(salesReturnId);
    final jsonResponse = Utils.convertToJson(response);
    final invoice = convertToModel(jsonResponse);
    return invoice;
  }

  @override
  Future<File?> showExportedSalesReturnInvoice(int invoiceId) async {
    final response = await _networing.showExportedSalesReturnInvoice(invoiceId);
    File? file =
        await SystemFileManager.convertResponseToFile(response, invoiceId);
    return file;
  }



  @override
  Future<List<InvoicesModel>> getInvoices() async {
    final response =
    await _networing.getInvoices();
    final jsonResponse = Utils.convertToListJson(response);
    final invoices = convertToListModel(jsonResponse);
    return invoices;
  }
  @override
  Future<List<InvoicesModel>> getMyInvoices() async {
    final response =
    await _networing.getMyInvoices();
    final jsonResponse = Utils.convertToListJson(response);
    final invoices = convertToListModel(jsonResponse);
    return invoices;
  }
}
