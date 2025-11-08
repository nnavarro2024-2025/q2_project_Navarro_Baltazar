import 'package:edc_v2/core/model/either.dart';
import 'package:edc_v2/core/model/failure.dart';
import 'package:edc_v2/features/history/data/datasource/history_remote_datasource.dart';
import 'package:edc_v2/features/history/domain/repository/history_repository.dart';
import 'package:edc_v2/features/main/domain/entity/donation_entity.dart';
import 'package:dio/dio.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDatasource historyRemoteDatasource;

  HistoryRepositoryImpl({required this.historyRemoteDatasource});

  @override
  Future<Either<Failure, List<DonationEntity>>> getDonations(
      {int? page, int? limit}) async {
    try {
      return Right(
          await historyRemoteDatasource.getDonations(page: page, limit: limit));
    } on DioException catch (e) {
      return Left(DonationFailure(errorMessage: e.response?.data['message']));
    }
  }
}
