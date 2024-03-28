import 'package:dartz/dartz.dart';
import 'package:dilaundry/config/app_request.dart';
import 'package:dilaundry/config/app_response.dart';
import 'package:http/http.dart' as http;
import 'package:dilaundry/config/app_constants.dart';
import 'package:dilaundry/config/app_session.dart';
import 'package:dilaundry/config/failure.dart';

class ShopDataSource {
  static Future<Either<Failure,Map>> readRecommendationLimit(
  ) async {
    Uri url = Uri.parse('${AppConstant.baseURL}/shop/limit'); // "/promo/limit sesuaikan dengan api.php"
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

  static Future<Either<Failure,Map>> searchByCity(String name) async {
    Uri url = Uri.parse('${AppConstant.baseURL}/shop/search/city/$name'); // "/promo/limit sesuaikan dengan api.php"
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
}