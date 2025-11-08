import 'package:edc_v2/core/model/either.dart';
import 'package:edc_v2/core/model/failure.dart';
import 'package:edc_v2/features/main/domain/entity/donation_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<DonationEntity>>> getDonations(
      {int? page, int? limit});
}
