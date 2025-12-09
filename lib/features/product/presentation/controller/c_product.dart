import 'package:flutter/cupertino.dart';
import 'package:task_two/core/constants/default_values.dart';
import 'package:task_two/core/controllers/c_base.dart';
import 'package:task_two/core/functions/f_printer.dart';
import 'package:task_two/core/widgets/load_and_error/models/view_state_model.dart';
import 'package:task_two/features/product/data/model/m_product.dart';
import 'package:task_two/features/product/data/model/m_query.dart';
import 'package:task_two/features/product/domain/product_repository.dart';

class CProduct extends CBase {
  final IProductRepository _iProductRepository;
  CProduct(this._iProductRepository);

  List<MProduct> productList = [];

  final int limit = PDefaultValues.limit;
  int firstPage = 1;
  int lastPage = 1;
  bool hasMoreNext = true;
  bool get hasMorePrev => firstPage > 1;
  bool isLoadingMore = false;
  // int get firstPage => currentPage - 5;

  void clearPaigenationChace() {
    hasMoreNext = true;
    isLoadingMore = false;
    lastPage = 1;
  }

  // Future<void> addProduct(MProduct payload) async {
  //   try {
  //     isLoadingMore = true;
  //     update();
  //     MProduct mProduct = await _iProductRepository.addProduct(payload);
  //     await Future.delayed(Duration(seconds: 2));
  //     printer(pendingList.length);
  //   } catch (e) {
  //     errorPrint(e);
  //   } finally {
  //     isLoadingMore = false;
  //     update();
  //   }
  // }

  // Future<void> updateProduct(MProduct payload) async {
  //   try {
  //     isLoadingMore = true;
  //     update();
  //     MProduct mProduct = await _iProductRepository.updateProduct(payload);
  //   } catch (e) {
  //     errorPrint(e);
  //   } finally {
  //     isLoadingMore = false;
  //     update();
  //   }
  // }

  // Future<void> deleteProduct(int id) async {
  //   printer("deleteWhere id = $id");
  //   try {
  //     isLoadingMore = true;
  //     update();
  //     await _iProductRepository.deteteProduct(id);
  //     // clear from runtime storage
  //     pendingList.removeWhere((mProduct) => mProduct.id == id);
  //     timeOutList.removeWhere((mProduct) => mProduct.id == id);
  //     completedList.removeWhere((mProduct) => mProduct.id == id);
  //     noteList.removeWhere((mProduct) => mProduct.id == id);
  //   } catch (e) {
  //     errorPrint(e);
  //   } finally {
  //     isLoadingMore = false;
  //     update();
  //   }
  // }

  Future<List<MProduct>?> fetchProduct({MQuery? payload}) async {
    print("called fetched spacfic item payload");
    try {
      if (isLoadingMore) {
        return null; //Already loading
      }
      isLoadingMore = true;
      viewState = ViewState.loading;
      update();
      // await Future.delayed(Duration(seconds: 500));
      List<MProduct> res = await _iProductRepository.fetchProduct();
      productList.addAll(res);
      update();
      printer("call 6");
      return res;
    } catch (e) {
      errorPrint(e);
    } finally {
      printer("call 7");
      isLoadingMore = false;
      viewState = ViewState.loaded;
      update();
    }
    return null;
  }
}
