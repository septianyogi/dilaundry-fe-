import 'package:dartz/dartz.dart';
import 'package:dilaundry/config/app_request.dart';
import 'package:dilaundry/config/app_response.dart';
import 'package:dilaundry/config/app_session.dart';
import 'package:http/http.dart' as http;
import 'package:dilaundry/config/app_constants.dart';
import 'package:dilaundry/config/failure.dart';

class PromoDataSource {
  static Future<Either<Failure,Map>> readLimit(
  ) async {
    Uri url = Uri.parse('${AppConstant.baseURL}/promo/limit'); // "/promo/limit sesuaikan dengan api.php"
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