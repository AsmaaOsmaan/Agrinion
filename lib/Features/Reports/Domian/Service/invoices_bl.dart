import 'dart:io';

import 'package:agriunion/App/Utilities/system_files.dart';
import 'package:agriunion/Features/Reports/Data/Repository/invoices_repository.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';

abstract class IInvoicesBL {
  Future<void> showExportedInvoicePdf(int invoiceId);
  Future<InvoicesModel?> showExportedInvoice(int invoiceId);
  Future<InvoicesModel> exportInvoice(InvoicesModel model, int orderId);
  Future<InvoicesModel> exportSalesReturnInvoice(int salesReturnId);
  Future<void> showExportedSalesReturnInvoice(int invoiceId);
  Future<List<InvoicesModel>> getInvoices();
  Future<List<InvoicesModel>> getMyInvoices();
}

class InvoicesBL implements IInvoicesBL {
  final IInvoicesRepository _repository;
  InvoicesBL(this._repository);

  @override
  Future<InvoicesModel> exportInvoice(InvoicesModel model, int orderId) async {
    InvoicesModel? invoice = await _repository.exportInvoice(model, orderId);
    return invoice;
  }

  @override
  Future<InvoicesModel?> showExportedInvoice(int invoiceId) async {
    InvoicesModel? invoice = await _repository.showExportedInvoice(invoiceId);
    return invoice;
  }

  @override
  Future<void> showExportedInvoicePdf(int invoiceId) async {
    File? file = await _repository.showExportedInvoicePdf(invoiceId);
    SystemFileManager.openFile(file);
  }

  @override
  Future<InvoicesModel> exportSalesReturnInvoice(int salesReturnId) async {
    return await _repository.exportSalesReturnInvoice(salesReturnId);
  }

  @override
  Future<void> showExportedSalesReturnInvoice(int invoiceId) async {
    File? file = await _repository.showExportedSalesReturnInvoice(invoiceId);
    SystemFileManager.openFile(file);
  }
  @override
  Future<List<InvoicesModel>> getInvoices() async {
    return await _repository.getInvoices();
  }
  @override
  Future<List<InvoicesModel>> getMyInvoices() async {
    return await _repository.getMyInvoices();
  }
}
