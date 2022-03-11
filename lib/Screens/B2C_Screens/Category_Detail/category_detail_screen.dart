
import 'package:flutter/material.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
    CommonWidget().
      roundBottomCornerappBar(50, 0.0, 'Categories', 1, context,true),
      body: ListView(
        children: [
          textWithCategoryList('Promotions'),
          textWithCategoryList('New Arivals'),
          textWithCategoryList('Cosmetics'),
          textWithCategoryList('Beverages'),
        ],
      ),
    );
  }


  Widget textWithCategoryList(titleText){
    return Container(
      //  color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Text
           CommonWidget().customText(
                titleText, blackColor, 18.0, FontWeight.bold, 1),
          SizedBox(height: 8,),
          //! List
          Container(
            width: double.infinity,
            height: 150,
            // color: Colors.teal,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
               scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: categoryContainer('assets/Images/onBoarding1.png','Flash sale'),
                );
              }),
          )
        ],
      ),
    );
  }

  Widget categoryContainer(imagePath,text) {
    return Column(
      children: [
        Container(
          height: 120,
          child: Card(
            elevation: 5.0,
            margin: EdgeInsets.all(0.0),
            child: Image.asset(imagePath),
          ),
        ),
        Container(
            color: greenColor.withOpacity(0.4),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: CommonWidget().customText(
                text, blackColor, 12.0, FontWeight.normal, 1))
      ],
    );
  }
}
