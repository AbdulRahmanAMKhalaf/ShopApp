import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/Models/CategoryModel.dart';
import 'package:shop_app/Modules/CategoryScreen.dart';
import 'package:shop_app/Modules/FavoriteScreen.dart';
import 'package:shop_app/Modules/HomeScreen.dart';
import 'package:shop_app/Modules/LoginScreen.dart';
import 'package:shop_app/Modules/SettingsSreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Models/BourdingModel.dart';
import 'SharedPreferences.dart';

//defaultTextFormFeild

Widget defualtTextFormFeild({
   TextEditingController ?textEditingController,
  bool secureText = true,
  void submitted(String text)?,
   String ?labelText,
   String ?hintText,
  TextInputType ?type,
   String ?preText,
   IconData ?preIcon,
  IconData? sufIconData,
  Color preIconColor = Colors.black,
  Color sufIconColor = Colors.black,
  Color textColor = Colors.black,
  void onpressedIcon()?,
   String? validator(String? value)?,
}) {
  return TextFormField(
    validator: validator,
    keyboardType: type,
    obscureText: secureText,
    controller: textEditingController,
    onFieldSubmitted: submitted,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      prefixText: preText,
      hintText: hintText,
      labelText: labelText,
      prefixIcon: Icon(preIcon),
      prefixIconColor: preIconColor,
      suffixIcon: IconButton(onPressed: onpressedIcon, icon: Icon(sufIconData)),
      suffixIconColor: sufIconColor,
      labelStyle: TextStyle(color: textColor, fontWeight: FontWeight.w600),
    ),
  );
}

List<BourdingModel> bourding = [
  BourdingModel(
    image:
        'https://th.bing.com/th/id/OIP.SdGe0TJgScCR848vw011CwHaEO?w=306&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    title: 'We Are everywhere',
    bodyText: 'any thing from anywhere',
  ),
  BourdingModel(
    image:
        'https://th.bing.com/th/id/OIP.ZRYJPjAfIcL0TMA9O2WTFQHaEc?w=255&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    title: 'Secure',
    bodyText: 'Safety and secure operation ',
  ),
  BourdingModel(
    image:
        'https://th.bing.com/th/id/OIP.6ykVmMn9WeyQKMWhNr_ktAHaFj?w=235&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    title: 'for all layers',
    bodyText: 'best coast',
  ),
];

PageController pageController = PageController();

Widget buildingBoundingScreen(
    BourdingModel bourdingModel, context, bool islast) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image(
              image: NetworkImage('${bourdingModel.image}'),
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        /*SizedBox(
          height: 20,
        ),*/
        Spacer(),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          '${bourdingModel.title}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${bourdingModel.bodyText}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: bourding.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 13,
                  dotWidth: 13,
                  expansionFactor: 1.4,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {
                    if (islast) {
                      CacheHelper.setData(key: 'bourding', value: true)
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false);
                        print('all done successfully at bourding screen');
                      }).catchError((onError) {
                        print(
                            'Error at  CacheHelper.setData at OnBourdingScreen');
                        print(onError.toString());
                      });
                    } else
                      pageController.nextPage(
                          duration: Duration(microseconds: 700),
                          curve: Curves.easeInOut);
                  },
                  icon: Icon(
                    Icons.forward,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Future<bool?> defaultToast({
  required String message,
  required Color color,
}) async {
  return await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

String ?Token;

List<BottomNavigationBarItem> bottemIcons = [
  BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
  BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), label: 'Category'),
  BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
];

List<Widget> screens = [
  HomeScreen(),
  CategoryScreen(),
  FavoriteScreen(),
  SettingsScreen(),
];

Widget bulidCategoryList(CategoryModel categoryModel) {
  return Container(
    height: 110,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        height: 100,
        width: 110,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 125,
              width: 125,
              child: Image(
                fit: BoxFit.fill,
                image:
                    NetworkImage('${categoryModel!.data!.data?[index].image}'),
              ),
            ),
            Container(
              color: Colors.grey.shade200,
              width: 100,
              child: Text(
                '${categoryModel.data!.data![index].name}',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(width: 7),
      itemCount: categoryModel.data!.data!.length,
    ),
  );
}

Widget bulidProductsList(HomeLayoutCubit homeLayoutCubit, index) {
  return Container(
  width: 170,
    height: 170,
    color: Colors.grey.shade200,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                  height: 170,
                  width: 180,
                  child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          '${homeLayoutCubit.homeModel!.data!.products![index].image}'))),
              if(homeLayoutCubit.homeModel!.data!.products![index].discount!=null)
              Container(
                width: 70,
                height: 23,
                color: Colors.red,
                child: Text(
                  'discount',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            '${homeLayoutCubit.homeModel!.data!.products![index].name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                '${homeLayoutCubit.homeModel!.data!.products![index].price}',
                style: TextStyle(
                    color: Colors.amber, fontSize: 13, fontWeight: FontWeight.w800),
              ),
              SizedBox(
      width: 7,
      ),
              if(homeLayoutCubit.homeModel!.data!.products![index].discount!=null)

                Text(
                '${homeLayoutCubit.homeModel!.data!.products![index].oldPrice}',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.lineThrough,decorationStyle: TextDecorationStyle.double),
              ),
      Spacer(),
      IconButton(onPressed: (){
        homeLayoutCubit.EditFavoriteData(
          token: Token!,
          productID: homeLayoutCubit.homeModel!.data!.products![index].id
        );
        homeLayoutCubit.getFavorites(token: Token!);
      }, icon:CircleAvatar(backgroundColor:homeLayoutCubit.favorites[homeLayoutCubit.homeModel!.data!.products![index].id]!?Colors.red: Colors.amber.shade200,radius: 20,child:Icon(Icons.favorite,color: Colors.grey.shade300,)),),
            ],
          ),
        ],
      ),
    ),
  );
}
