import 'package:flutter/material.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/models/categories_model.dart';
import 'package:prithvi/services/services.dart';

class CategoryNotifier extends ChangeNotifier {
  bool _isLoading = false;
  final CategoriesService _categoriesService;
  List<CategoryModel> categoryList = [];
  CategoryNotifier({required CategoriesService categoriesService})
      : _categoriesService = categoriesService;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getCategoryList() async {
    try {
      debugPrint("getCategoryNotifier------------------>IN ");

      isLoading = true;
      notifyListeners();
      categoryList = await _categoriesService.getCategoryList();
      debugPrint("categoryList------------------>$categoryList");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      AppException.onError(e);
    }
  }
}
