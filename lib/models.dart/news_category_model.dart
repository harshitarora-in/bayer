class CategoryModel {
  String? categoryUrl;
  String? categoryName;
}

List<CategoryModel> getCategoryModelList() {
  List<CategoryModel> categoryModel = List<CategoryModel>.empty(growable: true);
  //1 data set of category model
  CategoryModel categoryModelData;
  categoryModelData = CategoryModel();
  categoryModelData.categoryName = "Farmers";
  categoryModelData.categoryUrl =
      'https://images.unsplash.com/photo-1527847263472-aa5338d178b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=874&q=80';
  categoryModel.add(categoryModelData);
  //2 data set of category model
  categoryModelData = CategoryModel();
  categoryModelData.categoryName = "Laws";
  categoryModelData.categoryUrl =
      'https://images.unsplash.com/photo-1423592707957-3b212afa6733?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1632&q=80';
  categoryModel.add(categoryModelData);
  //3 data set of category model
  categoryModelData = CategoryModel();
  categoryModelData.categoryName = "Business";
  categoryModelData.categoryUrl =
      "https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=876&q=80";
  categoryModel.add(categoryModelData);
  //4 data set of category model
  categoryModelData = CategoryModel();
  categoryModelData.categoryName = "Finance";
  categoryModelData.categoryUrl =
      'https://images.unsplash.com/photo-1579621970795-87facc2f976d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';
  categoryModel.add(categoryModelData);
  return categoryModel;
}
