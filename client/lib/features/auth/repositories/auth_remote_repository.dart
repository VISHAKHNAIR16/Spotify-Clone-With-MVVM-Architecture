import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/constants/server_constants.dart';
import 'package:spotify_clone/features/auth/model/user_model.dart';
import 'package:spotify_clone/features/auth/failure/failure.dart';
part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(AppFailure(responseBody['detail']));
      }

      return Right(UserModel.fromMap(responseBody));
    } on Exception catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login({required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverURL}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(responseBody['detail']));
      }

      return Right(UserModel.fromMap(responseBody['user']).copyWith(token: responseBody['token']));
    } on Exception catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('${ServerConstants.serverURL}/auth/'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(responseBody['detail']));
      }

      return Right(UserModel.fromMap(responseBody).copyWith(token: token));
    } on Exception catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
