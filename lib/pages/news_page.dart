import 'package:bayer/api/news_api.dart';
import 'package:bayer/contants.dart';
import 'package:bayer/models.dart/article_model.dart';
import 'package:bayer/models.dart/news_category_model.dart';
import 'package:bayer/pages/article_webview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<CategoryModel> categoryData = List.empty();
  List<ArticleModel> article = List<ArticleModel>.empty(growable: true);
  bool _loading = true;

  @override
  void initState() {
    asyncInit();
    addArticles(newsCategory: 'farmer');
    super.initState();
  }

  void addArticles({required String newsCategory}) async {
    NewsApiService news = NewsApiService();
    Constants constants = Constants();
    var response = await news.fetchNewsModel(
        url: constants.getNewsLink(newsCategory: newsCategory));
    int length = 15;
    if (response["totalResults"] < 15) {
      length = response["totalResults"];
    } else {
      length = 15;
    }
    ArticleModel articleData;
    for (int i = 0; i < length; i++) {
      articleData = ArticleModel();
      articleData.urlToImage = response['articles'][i]['urlToImage'];
      articleData.title = response['articles'][i]['title'];
      articleData.description = response['articles'][i]['description'];
      articleData.url = response['articles'][i]['url'];
      article.add(articleData);
    }
    setState(() {
      _loading = false;
      article;
    });
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
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            height: 70,
            child: ListView.builder(
                itemCount: categoryData.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _loading = true;
                      });
                      article = List<ArticleModel>.empty(growable: true);
                      addArticles(
                          newsCategory: categoryData[index]
                              .categoryName
                              .toString()
                              .toLowerCase());
                    },
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(left: 14),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  color: kDarkBlue,
                                  value: progress.progress,
                                ),
                              ),
                              imageUrl:
                                  categoryData[index].categoryUrl.toString(),
                              height: 70,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black26)),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                categoryData[index].categoryName.toString(),
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                  // CategoryTile(
                  //     imageUrl: categoryData[index].categoryUrl,
                  //     categoryName: categoryData[index].categoryName);
                }),
          ),
          _loading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kDarkBlue,
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 35),
                      child: ListView.builder(
                          itemCount: article.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleView(
                                            postUrl: article[index]
                                                .url
                                                .toString())));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          color: kDarkBlue,
                                          value: progress.progress,
                                        ),
                                      ),
                                      imageUrl: article[index].urlToImage ==
                                              null
                                          ? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fvector%2Fno-thumbnail-image-vector-graphic-gm1147544806-309589936&psig=AOvVaw1Z4vs3jIssA79DMEtxyD-T&ust=1637866552555000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJCq1cLWsfQCFQAAAAAdAAAAABAI"
                                          : article[index]
                                              .urlToImage
                                              .toString(),
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                            "assets/images/error.jpg");
                                      },
                                      fit: BoxFit.fill,
                                      height: 180,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(article[index].title.toString(),
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      style: GoogleFonts.inter(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4),
                                  Text(article[index].description.toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.inter(
                                        color: Colors.black54,
                                        fontSize: 14,
                                      )),
                                  const SizedBox(height: 15)
                                ],
                              ),
                            );
                            // featuredImageUrl: article[index].urlToImage,
                            // newsTitle: article[index].title,
                            // newsDescription: article[index].description,
                            // url: article[index].url,
                          }),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

// class CategoryTile extends StatelessWidget {
//   const CategoryTile({
//     Key? key,
//     @required this.imageUrl,
//     @required this.categoryName,
//   }) : super(key: key);
//   final String? categoryName;
//   final String? imageUrl;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         width: 120,
//         margin: const EdgeInsets.only(left: 14),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Stack(
//             children: [
//               CachedNetworkImage(
//                 progressIndicatorBuilder: (context, url, progress) => Center(
//                   child: CircularProgressIndicator(
//                     color: kDarkBlue,
//                     value: progress.progress,
//                   ),
//                 ),
//                 imageUrl: imageUrl.toString(),
//                 height: 70,
//                 width: 120,
//                 fit: BoxFit.cover,
//               ),
//               Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.black26)),
//               Container(
//                 alignment: Alignment.center,
//                 child: Text(
//                   categoryName.toString(),
//                   style: GoogleFonts.inter(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BlogTile extends StatelessWidget {
//   const BlogTile(
//       {Key? key,
//       @required this.featuredImageUrl,
//       @required this.newsTitle,
//       @required this.newsDescription,
//       @required this.url})
//       : super(key: key);

//   final String? featuredImageUrl;
//   final String? newsTitle;
//   final String? newsDescription;
//   final String? url;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: CachedNetworkImage(
//             progressIndicatorBuilder: (context, url, progress) => Center(
//               child: CircularProgressIndicator(
//                 color: kDarkBlue,
//                 value: progress.progress,
//               ),
//             ),
//             imageUrl: featuredImageUrl == null
//                 ? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fvector%2Fno-thumbnail-image-vector-graphic-gm1147544806-309589936&psig=AOvVaw1Z4vs3jIssA79DMEtxyD-T&ust=1637866552555000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJCq1cLWsfQCFQAAAAAdAAAAABAI"
//                 : featuredImageUrl.toString(),
//             errorWidget: (context, url, error) {
//               return Image.asset("assets/images/error.jpg");
//             },
//             fit: BoxFit.fill,
//             height: 180,
//             width: MediaQuery.of(context).size.width,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(newsTitle.toString(),
//             textAlign: TextAlign.left,
//             maxLines: 2,
//             style: GoogleFonts.inter(
//                 color: Colors.black87,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500)),
//         const SizedBox(height: 4),
//         Text(newsDescription.toString(),
//             maxLines: 3,
//             style: GoogleFonts.inter(
//               color: Colors.black54,
//               fontSize: 14,
//             )),
//         const SizedBox(height: 15)
//       ],
//     );
//   }
// }
