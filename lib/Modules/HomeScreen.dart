import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/Modules/searchScreen.dart';

import '../Share/Componantes.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

   CarouselController carouselController=CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'HomeScreen',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context) => SearchScreen(),
                      ),
                    );
                  },
                  icon:Icon(Icons.search,size: 27),
                ),
              ],
            ),
            body: SafeArea(
              child: ConditionalBuilder(
                condition: homeLayoutCubit.homeModel!=null && homeLayoutCubit.categoryModel!=null,
                builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          items:homeLayoutCubit.homeModel!.data!.banners!.map((e)=>Image(fit: BoxFit.fill,image: NetworkImage('${e.image}'))).toList(),
                          options:CarouselOptions(
                            viewportFraction: 1,
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                            autoPlay: true,
                            initialPage: 0,
                            autoPlayCurve: Curves.fastOutSlowIn,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        bulidCategoryList(homeLayoutCubit.categoryModel!),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Products',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.grey,
                          child: GridView.count(
                            physics:NeverScrollableScrollPhysics() ,
                            shrinkWrap: true,
                            crossAxisCount:2,
                            childAspectRatio: 1/1.52,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            children:List.generate(homeLayoutCubit.homeModel!.data!.products!.length,
                                    (index) =>bulidProductsList(homeLayoutCubit,index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            ),
          );
      },
    );
  }
}
