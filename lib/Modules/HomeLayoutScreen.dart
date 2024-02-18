import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/CubitsStates/LoginStates.dart';

import '../Share/Componantes.dart';

class HomeLayoutScreen extends StatelessWidget {
   HomeLayoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items:bottemIcons,
            currentIndex: homeLayoutCubit.index,
            onTap:(value) {
              homeLayoutCubit.changeBottemIcon(value);
            },
          ),
          body:screens[homeLayoutCubit.index],
        );
      },
    );
  }
}
