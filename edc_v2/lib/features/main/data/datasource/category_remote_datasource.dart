import 'package:dio/dio.dart';
import 'package:edc_v2/features/main/domain/entity/category_entity.dart';

class CategoryRemoteDatasource {
  final Dio dio;

  CategoryRemoteDatasource({required this.dio});

  Future<List<CategoryEntity>> getCategories() async {
    var result = await dio.get('categories/');
    return (result.data as List)
        .map((e) => CategoryEntity.fromJson(e))
        .toList();
  }
}