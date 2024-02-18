import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/Share/Componantes.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
   TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defualtTextFormFeild(
                    secureText: false,
                    labelText: 'Search',
                    textColor: Colors.black,
                    preIcon: Icons.search,
                    textEditingController: textEditingController,
                    submitted: (String) {
                      homeLayoutCubit.getSearch(token: Token!, text:textEditingController.text);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                      condition:homeLayoutCubit.searchModel!=null,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder:(context, index) => Column(
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
                                                    '${homeLayoutCubit.searchModel!.data!.data[index].image}'))),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${homeLayoutCubit.searchModel!.data!.data[index].name}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
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
                                              '${homeLayoutCubit.searchModel!.data!.data[index].price}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.amber.shade900,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,

                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                          itemCount: homeLayoutCubit.searchModel!.data!.data.length,
                        ),
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
