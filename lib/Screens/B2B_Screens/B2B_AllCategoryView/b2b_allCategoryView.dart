import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Model/Category_Model/category_model.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_AllCategoryView/b2b_allCateg_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Sub_Category/b2b_sub_category.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Sub_Category/b2b_sub_cateory_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class B2BAllCategoryView extends StatelessWidget {
  // List<Category> categoryList = <Category>[];
  B2BAllCategoryView({
    Key? key,
  }) : super(key: key);
  final b2BAllCategoryController = Get.put(B2BAllCategoryController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'categories'.tr,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: Obx(
            () => Container(
              height: Get.height,
              color: Colors.white,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: b2BAllCategoryController.categoryList.length,
                  itemBuilder: (context, firstIndex) {
                    var category =
                        b2BAllCategoryController.categoryList[firstIndex];
                    print(category.id);
                    return Container(
                        margin: EdgeInsets.all(5.0),
                        color: Colors.white, //! ---------------
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //!---------Text(Cat Name)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: CommonWidget().customText(category.name,
                                    blackColor, 18.0, FontWeight.bold, 1,
                                    alignment: TextAlign.center),
                              ),
                              //!---------Text(Cat Sub Child images/Name)
                              Container(
                                //!-------------Main Showing Container height(image box)
                                height: 100,
                                // width: 300,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        category.categoryFirstChildern.length,
                                    itemBuilder: (context, secondIndex) {
                                      var categoryChild =
                                          b2BAllCategoryController
                                                  .categoryList[firstIndex]
                                                  .categoryFirstChildern[
                                              secondIndex];
                                      return Container(
                                          //!-------------Main Showing Container height / width

                                          width: 120,
                                          // color: Colors.blue,
                                          child: categoryContainer(
                                            '${categoryChild.image}',
                                            categoryChild.name,
                                            categoryChild.id.toString(),
                                            context,
                                            category.name,
                                            secondIndex,
                                            category.id,
                                          ));
                                    }),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
          )),
      onWillPop: () {
        return Future.value(true); // if true allow back else block it
      },
    );
  }

  Widget categoryContainer(String imagePath, String name, String id, context,
      categName, comingIndex, pid) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: lightgreyColor.withOpacity(0.1)),
      margin: EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          print('its product $id');
          print('its pid $pid');
          print('its -----$categName');
          Get.delete<B2BSubCategoryController>();
          pushNewScreen(
            context,
            screen: B2BSubCategoryDetailScreen(
              comingTabIndex: comingIndex,
              pid: pid.toString(),
              id: id.toString(),
              titleName: name,
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
          // Get.to(() => B2BSubCategoryDetailScreen(
          //   comingTabIndex: comingIndex,
          //       pid: pid.toString(),
          //       id: id.toString(),
          //       titleName: name,
          //     ));
        },
        child: Container(
          margin: EdgeInsets.all(1.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: whiteColor),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: imagePath == imageStartUrl
                      ? Image.asset('assets/Images/taqwa_logo.png')
                      : FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/Images/taqwa_logo.png',
                          image: imagePath,
                        ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                child: CommonWidget().customText(
                    name, blackColor, 14.0, FontWeight.w400, 2,
                    alignment: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
// import 'package:mangalo_app/Constant/constants.dart';
// import 'package:mangalo_app/Model/Category_Model/category_model.dart';
// import 'package:mangalo_app/Screens/Sub_Category_Detail/sub_cat_dummy.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// class CategoryView extends StatelessWidget {
//   List<Category> categoryList = <Category>[];
//   CategoryView({Key? key, required this.categoryList}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Categories',
//           style: Theme.of(context).appBarTheme.titleTextStyle,
//         ),
//       ),
//       body: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 6,
//               mainAxisSpacing: 8,
//               childAspectRatio: 1 //! For Size MAnagment
//               ),
//           shrinkWrap: true,
//           itemCount: categoryList.length,
//           itemBuilder: (context, index) {
//             var category = categoryList[index];
//             print(category.id);
//             return categoryContainer(
//                 category.image, category.name, category.id.toString(), context);
//           }),
//     );
//   }

//   Widget categoryContainer(String imagePath, String name, String id, context) {
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//       width: 140,
//       margin: EdgeInsets.symmetric(horizontal: 2),
//       child: GestureDetector(
//         onTap: () {
//           print(id);
//           pushNewScreen(
//             context,
//             screen: SubCategoryDetailScreen(
//               pid: id,
//               titleName: name,
//             ),
//             withNavBar: true,
//             pageTransitionAnimation: PageTransitionAnimation.cupertino,
//           );
//           // Get.to(() => SubCategoryDetailScreen(
//           //       pid: id,
//           //       titleName: name,
//           //     ));
//         },
//         child: Card(
//             elevation: 2.0,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: Column(
//               children: [
//                 Expanded(
//                     flex: 5,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Image.network(
//                         imagePath,
//                         fit: BoxFit.cover,
//                       ),
//                     )),
//                 Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5, vertical: 0),
//                         child: CommonWidget().customText(
//                             name, blackColor, 18.0, FontWeight.w500, 2),
//                       ),
//                     )),
//               ],
//             )),
//       ),
//     );
//   }
// }
