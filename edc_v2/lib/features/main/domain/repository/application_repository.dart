import 'package:edc_v2/core/model/either.dart';
import 'package:edc_v2/core/model/failure.dart';
import 'package:edc_v2/features/main/domain/entity/application_entity.dart';

abstract class ApplicationRepository {
  Future<Either<Failure, List<ApplicationEntity>>> getApplications(
      {int? page,
      int? limit,
      String? categoryId,
      bool? isUrgent,
      String? search});

  Future<Either<Failure,ApplicationEntity>> getApplicationById(String applicationId);
}
