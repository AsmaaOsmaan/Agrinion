import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_helper.dart';

abstract class IInvoicesNetworking {
  Future<dynamic> showExportedInvoice(int invoiceId);
  Future<dynamic> showExportedInvoicePDF(int invoiceId);
  Future<dynamic> exportInvoice(Map<String, dynamic> body, int orderId);
  Future<dynamic> exportSalesReturnInvoice(int salesReturnId);
  Future<dynamic> showExportedSalesReturnInvoice(int invoiceId);
  Future<dynamic> getInvoices();
  Future<dynamic> getMyInvoices();
}

class InvoicesNetworking implements IInvoicesNetworking {
  final NetworkHelper networking;
  InvoicesNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token':   getToken(),

      };
  @override
  Future<dynamic> exportInvoice(Map<String, dynamic> body, int orderId) async {
    try {
      final response = await networking.post(
        url: '$ordersUrl/$orderId/$invoicesUrl',
        headers: headers(),
        body: body,
      );

      var data = response.data['invoice'];
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> showExportedInvoice(int invoiceId) async {
    try {
      final response = await networking.get(
        url: '$invoicesUrl/$invoiceId',
        headers: headers(),
      );
      var data = response.data['invoice'];
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> showExportedInvoicePDF(int invoiceId) async {
    try {
      headers()['Accept'] = 'application/pdf';
      final response = await networking.getDownload(
        url: '$invoicesUrl/$invoiceId.pdf',
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> exportSalesReturnInvoice(int salesReturnId) async {
    try {
      final response = await networking.post(
        url: '$invoicesUrl/$createSalesReturnsUrl/$salesReturnId',
        headers: headers(),
      );
      var data = response.data;
      return data['invoice'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> showExportedSalesReturnInvoice(int invoiceId) async {
    try {
      final response = await networking.getDownload(
        url: '$invoicesUrl/$showSalesReturnsUrl/$invoiceId.pdf',
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getInvoices() async {
    try {
      final response = await networking.get(
        url: '$invoicesUrl/$recievedInvoicesUrl',
        headers: headers(),
      );
      var data = response.data;
      return data['invoices'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getMyInvoices() async {
    try {
      final response = await networking.get(
        url: invoicesUrl,
        headers: headers(),
      );
      var data = response.data;
      return data['invoices'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }
}
