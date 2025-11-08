import 'package:dio/dio.dart';
import 'package:edc_v2/core/model/either.dart';
import 'package:edc_v2/core/model/failure.dart';
import 'package:edc_v2/features/main/data/datasource/category_remote_datasource.dart';
import 'package:edc_v2/features/main/domain/entity/category_entity.dart';
import 'package:edc_v2/features/main/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource categoryRemoteDatasource;

  CategoryRepositoryImpl({required this.categoryRemoteDatasource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      return Right(await categoryRemoteDatasource.getCategories());
    } on DioException catch (e) {
      return Left(CategoryFailure(errorMessage: e.response?.data['message'])); // Assuming Failure is a class representing an error state
    }
  }
}