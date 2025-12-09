import 'package:task_two/features/product/data/model/m_product.dart';
import 'package:task_two/features/product/domain/product_datasource.dart';
import 'package:task_two/features/product/domain/product_repository.dart';

class ProductRepositoryImpl extends IProductRepository {
  final IProductDataSource _iProductDataSource;
  ProductRepositoryImpl(this._iProductDataSource);

  // @override
  // Future<MProduct> addProduct(MProduct payload) async {
  //   return _iProductDataSource.addProduct(payload);
  // }

  // @override
  // Future<bool> deteteProduct(int id) async {
  //   return _iProductDataSource.deteteProduct(id);
  // }

  @override
  Future<List<MProduct>> fetchProduct() async {
    return _iProductDataSource.fetchProduct();
  }

  // @override
  // Future<MProduct> updateProduct(MProduct payload) async {
  //   return _iProductDataSource.updateProduct(payload);
  // }
}
