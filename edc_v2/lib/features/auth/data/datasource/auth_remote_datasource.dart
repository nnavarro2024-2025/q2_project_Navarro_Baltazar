import 'package:dio/dio.dart';
import 'package:edc_v2/features/auth/domain/entity/user_entity.dart';

class AuthRemoteDatasource{
  final Dio dio;

  AuthRemoteDatasource({required this.dio});

  Future<UserEntity> signInWithGoogle(String token) async{
    var request = await dio.post('auth/verify',data: {
      'token' : token
    });

    return UserEntity.fromJson(request.data);
  }
}