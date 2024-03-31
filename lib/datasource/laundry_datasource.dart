import 'package:dartz/dartz.dart';
import 'package:dilaundry/models/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:dilaundry/config/app_constants.dart';
import 'package:dilaundry/config/app_request.dart';
import 'package:dilaundry/config/app_response.dart';
import 'package:dilaundry/config/app_session.dart';
import 'package:dilaundry/config/failure.dart';


class LaundryDatasource {
  static Future<Either<Failure,Map>> readByUser(int userId) async {
    Uri url = Uri.parse('${AppConstant.baseURL}/laundry/user/$userId'); // "/promo/limit sesuaikan dengan api.php"
    final token = await AppSession.getBearerToken();
    try {
      final response = await http.get(
      url,
      headers: AppRequest.header(token),
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if(e is Failure) {
        return Left(e);
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  static Future<Either<Failure,Map>> claim(String id, String claimCode) async {
    Uri url = Uri.parse('${AppConstant.baseURL}/laundry/claim'); // "/promo/limit sesuaikan dengan api.php"
    UserModel? user = await AppSession.getUser();
    final token = await AppSession.getBearerToken();
    try {
      final response = await http.post(
      url,
      headers: AppRequest.header(token),
      body: {
        'id' : id,
        'claim_code' : claimCode,
        'user_id' : user!.id.toString(),
      }
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if(e is Failure) {
        return Left(e);
      }
      return Left(FetchFailure(e.toString()));
    }
  }
}