import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/Modules/LoginScreen.dart';
import 'package:shop_app/Share/Componantes.dart';
import 'package:shop_app/Share/SharedPreferences.dart';
import 'EditProfile.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:(context) => EditProfile(),
                                ),
                              );
                            },
                            icon:Icon(Icons.edit,color: Colors.black,size: 30,)
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Name : ${homeLayoutCubit.profileModel!.data!.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Phone :${homeLayoutCubit.profileModel!.data!.phone}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Email : ${homeLayoutCubit.profileModel!.data!.email}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 63,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue
                      ),
                      child: TextButton(
                        onPressed:() {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder:(context) => LoginScreen(),
                              ),
                                  (route) => false
                          );
                         Token='';
                        },
                        child:Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ) ,
                  ],
                ),
              ),
            ),
          )
        );
      },
    );
  }
}
