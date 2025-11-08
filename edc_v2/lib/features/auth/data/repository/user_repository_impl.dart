import 'package:dio/dio.dart';
import 'package:edc_v2/core/model/either.dart';
import 'package:edc_v2/core/model/failure.dart';
import 'package:edc_v2/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:edc_v2/features/auth/domain/entity/user_entity.dart';
import 'package:edc_v2/features/auth/domain/repository/user_repository.dart';


class UserRepositoryImpl implements UserRepository{
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});
  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try{
      return Right(await userRemoteDatasource.getUser());
    }
    on DioException catch (e){
      return Left(AuthFailure(errorMessage: e.response?.data['message'] ?? 'Error'));
    }
  }

}

