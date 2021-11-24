import 'package:bayer/models.dart/news_category_model.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

//TODO: image loading and setstate problem.
class _NewsPageState extends State<NewsPage> {
  List<CategoryModel> categoryData = List.filled(4, CategoryModel());
  @override
  void initState() {
    // TODO: implement initState
    //categoryData = getCategoryModelList();
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    categoryData = getCategoryModelList();
    setState(() {
      categoryData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, int index) {
                  return CategoryTile(
                      imageUrl: categoryData[index].categoryUrl,
                      categoryName: categoryData[index].categoryName);
                }),
          )
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key, @required this.imageUrl, @required this.categoryName})
      : super(key: key);
  final String? categoryName;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imageUrl.toString(),
          height: 50,
          width: 60,
          fit: BoxFit.cover,
        ),
        Text(categoryName.toString())
      ],
    );
  }
}
