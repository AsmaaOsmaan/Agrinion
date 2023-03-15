import '../../../../../../../../../../App/Network/network_helper.dart';
import '../../../../../../../../../../App/Network/network_routes.dart';

abstract class IBrokerNetworking {
  Future<dynamic> getAllBrokers();
  Future<dynamic> getAllParentableBrokers();
  Future<dynamic> getBrokers(int id);
  Future<dynamic> addBroker(Map<String, dynamic> body, int cityId);
  Future<dynamic> editBroker(
      Map<String, dynamic> body, int brokerId, int marketId);
  Future<dynamic> deleteBroker(int brokerId, int marketId);
}

class BrokersNetworking extends IBrokerNetworking {
  final NetworkHelper networking;
  BrokersNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getAllBrokers() async {
    final response = await networking.get(
      url: brokerUrl,
      headers: headers(),
    );

    return response.data;
  }

  @override
  Future<dynamic> getAllParentableBrokers() async {
    final response = await networking.get(
      url: parentableBrokers,
      headers: headers(),
    );

    return response.data;
  }

  @override
  Future<dynamic> getBrokers(int id) async {
    final response = await networking.get(
      url: marketsUrl + "/$id/" + brokerUrl,
      headers: headers(),
    );
    return response.data;
  }

  @override
  Future<dynamic> addBroker(Map<String, dynamic> body, int cityId) async {
    final response = await networking.post(
      url: '$marketsUrl/$marketsUrl/$brokerUrl',
      headers: headers(),
      body: {"broker": body},
    );
    return response.data;
  }

  @override
  Future<dynamic> editBroker(
      Map<String, dynamic> body, int brokerId, int marketId) async {
    final response = await networking.patch(
      url: '$marketsUrl/$marketsUrl/$brokerUrl/$brokerId',
      headers: headers(),
      body: {"broker": body},
    );
    return response;
  }

  @override
  Future<dynamic> deleteBroker(int brokerId, int marketId) async {
    final response = await networking.delete(
      url: '$marketsUrl/$marketsUrl/$brokerUrl/$brokerId',
      headers: headers(),
    );
    return response;
  }
}
