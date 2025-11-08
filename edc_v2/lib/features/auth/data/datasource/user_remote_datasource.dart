import 'package:dio/dio.dart';
import 'package:edc_v2/features/auth/domain/entity/user_entity.dart';
class UserRemoteDatasource{
  final Dio dio;

  UserRemoteDatasource({required this.dio});

  Future<UserEntity> getUser() async{
    var request = await dio.get('auth/me');
    return UserEntity.fromJson(request.data);
  }

}