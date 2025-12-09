import 'package:dio/dio.dart';
import 'package:task_two/core/services/dio_service.dart';
import 'package:task_two/features/product/data/model/m_product.dart';
import 'package:task_two/features/product/domain/product_datasource.dart';

class ProductDataSourceImpl extends IProductDataSource {
  String path = "/products";

  @override
  Future<List<MProduct>> fetchProduct() async {
    Response response = await makeRequest(path: path, method: HTTPMethod.get);
    if (response.data != null) {
      return (response.data as List<dynamic>).map((data) {
        return MProduct.fromJson(data as Map<String, dynamic>);
      }).toList();
    }
    return [];
  }

}
