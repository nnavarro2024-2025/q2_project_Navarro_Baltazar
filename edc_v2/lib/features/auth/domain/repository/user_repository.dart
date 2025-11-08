import 'package:edc_v2/core/model/either.dart';
import 'package:edc_v2/core/model/failure.dart';
import 'package:edc_v2/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();
}