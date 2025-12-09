import 'package:task_two/features/product/data/model/m_product.dart';

abstract class IProductDataSource {
  Future<List<MProduct>> fetchProduct();
}
