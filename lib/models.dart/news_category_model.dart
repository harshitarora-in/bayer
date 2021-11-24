class CategoryModel {
  String? categoryUrl;
  String? categoryName;
}

List<CategoryModel> getCategoryModelList() {
  List<CategoryModel> categoryModel =
      List.filled(4, CategoryModel(), growable: true);
  //1 data set of category model
  CategoryModel categoryModelData = CategoryModel();
  categoryModelData.categoryName = "Category1";
  categoryModelData.categoryUrl = 'assets/images/50n.png';
  categoryModel.add(categoryModelData);
  //2 data set of category model

  categoryModelData.categoryName = "Category2";
  categoryModelData.categoryUrl = 'assets/images/50n.png';
  categoryModel.add(categoryModelData);
  //3 data set of category model

  categoryModelData.categoryName = "Category3";
  categoryModelData.categoryUrl = "assets/images/50d.png";
  categoryModel.add(categoryModelData);
  //4 data set of category model

  categoryModelData.categoryName = "Category4";
  categoryModelData.categoryUrl = 'assets/images/50d.png';
  categoryModel.add(categoryModelData);
  return categoryModel;
}
