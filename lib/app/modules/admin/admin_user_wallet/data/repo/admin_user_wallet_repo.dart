import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/models/failure_model.dart';
import '../model/user_wallet_model.dart';

class AdminUserWalletRepo {
  final dio = Dio();

  Future<Either<FailureModel, Map<String, dynamic>>> getUserWallet() async {
    const String url = "https://49dev.com/api/v1/dashboard/users-wallet?page=1&limit=7";

    try {
      // Retrieve the access token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        return Left(FailureModel(message: "Access token not found"));
      }

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return Right(data); // Successful response
      } else if (response.statusCode == 401) {
        // Handle unauthorized access (e.g., token expired or invalid)
        return Left(FailureModel(message: "Unauthorized: Invalid or expired token"));
      } else {
        return Left(FailureModel(message: "Failed to load data: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(FailureModel(message: "Error occurred: $e"));
    }
  }

  Future<Either<FailureModel, Map<String, dynamic>>> updateUserAndWallet({
    required String userId,
    required UserWalletDataModel userWalletData,
  }) async {
    final String url = "https://49dev.com/api/v1/dashboard/updateUserAndWallet/$userId";

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        return Left(FailureModel(message: "Access token not found"));
      }

      final response = await dio.put(
        url,
        data: userWalletData.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(FailureModel(message: "Failed to update data: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(FailureModel(message: "Error occurred: $e"));
    }
  }
}

