import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/Modules/searchScreen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {},
        builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
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
                    icon:Icon(Icons.search),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder:(context, index) => Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image:NetworkImage(
                                        '${homeLayoutCubit.categoryModel!.data!.data![index].image}'
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${homeLayoutCubit.categoryModel!.data!.data![index].name}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              height: 2,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 10),
                        itemCount: homeLayoutCubit.categoryModel!.data!.data!.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
