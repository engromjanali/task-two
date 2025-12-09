import 'package:task_two/features/product/data/model/m_product.dart';

abstract class IProductRepository {
  Future<List<MProduct>> fetchProduct();
}
