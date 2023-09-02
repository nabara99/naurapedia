import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:naurapedia/common/global_variables.dart';
import 'package:naurapedia/data/datasources/auth_local_datasources.dart';
import 'package:naurapedia/data/models/order_request_model.dart';
import 'package:naurapedia/data/models/responses/order_response_model.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel model) async {
    final tokenJwt = await AuthLocalDatasource().getToken();
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $tokenJwt'
      },
      body: model.toRawJson(),
    );

    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromJson(response.body));
    } else {
      return const Left('server error');
    }
  }
}
