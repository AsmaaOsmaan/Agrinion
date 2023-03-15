import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../../App/Errors/exceptions.dart';
import '../../../../../../../App/Network/network_helper.dart';
import '../../../../../../../App/Network/network_routes.dart';

abstract class IPaymentNetworking {
  Future<dynamic> createPaymentOnInvoice(Map<String, dynamic> body, int invoiceId);
  Future<dynamic> getPaymentsOnInvoice(int invoiceId);
}

class PaymentNetworking implements IPaymentNetworking {
  final NetworkHelper networking;
  PaymentNetworking(this.networking);
  Map<String, String> headers() => {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token': getToken(),
  };

  @override
  Future<dynamic> createPaymentOnInvoice(Map<String, dynamic> body, int invoiceId) async {
    try {
      final response = await networking.post(
        url: invoicesUrl + "/$invoiceId/" + paymentUrl,
        headers: headers(),
        body: body,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getPaymentsOnInvoice(int invoiceId) async {
    try {
      final response = await networking.get(
        url: invoicesUrl + "/$invoiceId/" + paymentUrl,
        headers: headers(),
      );
      var data = response.data;
      return data['payments'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }







}
