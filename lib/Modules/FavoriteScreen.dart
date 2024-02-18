import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';

import '../Share/Componantes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: ConditionalBuilder(
              condition: state is! LoadingEditFavoriteDataState,
              builder: (context) => ListView.separated(
                itemBuilder:(context, index) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            child:Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                    height: 170,
                                    width: 180,
                                    child: Image(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            '${homeLayoutCubit.getFavoriteModel!.data!.data[index].product!.image}'))),
                                if(homeLayoutCubit.getFavoriteModel!.data!.data[index].product!.discount!=null || homeLayoutCubit.getFavoriteModel!.data!.data[index].product!.discount!=0)
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${homeLayoutCubit.getFavoriteModel!.data!.data[index].product!.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      height: 2
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${homeLayoutCubit.getFavoriteModel!.data!.data[index].product!.price}',
                                      style: TextStyle(
                                        color: Colors.amber.shade900,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,

                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '${homeLayoutCubit.getFavoriteModel!.data!.data[index]!.product!.oldPrice}',
                                      style: TextStyle(
                                          color: Colors.amber.shade900,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          decoration: TextDecoration.lineThrough
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: homeLayoutCubit.getFavoriteModel!.data!.data.length,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
