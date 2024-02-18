import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/Modules/HomeLayoutScreen.dart';
import 'package:shop_app/Share/SharedPreferences.dart';

import '../Share/Componantes.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
   TextEditingController nameController=TextEditingController();
   TextEditingController phoneController=TextEditingController();
   TextEditingController emailController=TextEditingController();
   TextEditingController passwordController=TextEditingController();
   final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {
        if(state is SuccessRegisterButtonState){
         if(HomeLayoutCubit.get(context).registerModel!.status!) {
            defaultToast(
              message: HomeLayoutCubit.get(context).registerModel!.message!,
              color: Colors.green,
            ).then((value) {
              CacheHelper.setData(key: 'token', value:  HomeLayoutCubit.get(context).registerModel!.data!.token!);
              HomeLayoutCubit.get(context).profileModel!.data!.name=nameController.text;
              HomeLayoutCubit.get(context).profileModel!.data!.phone=phoneController.text;
              HomeLayoutCubit.get(context).profileModel!.data!.email=emailController.text;

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder:(context) => HomeLayoutScreen(),
                  ),
                      (route) => false
              );
            }).catchError((onError) {
              print(onError.toString());
            });
          }
         else
           defaultToast(
               message: HomeLayoutCubit.get(context).registerModel!.message!,
               color: Colors.red
           );
        }
      },
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Registeration',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                          ),
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
                        defualtTextFormFeild(
                          secureText: false,
                          validator: (value) {
                            if(value!.isEmpty)
                              return 'requeired Feiled';
                            else
                              return null;
                          },
                          labelText:'Name',
                          preIcon: Icons.person,
                          textEditingController:nameController,
                          textColor: Colors.black,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defualtTextFormFeild(
                          secureText: false,
                          validator: (value) {
                            if(value!.isEmpty)
                              return 'requeired Feiled';
                            else
                              return null;
                          },
                          labelText:'Phone',
                          preIcon: Icons.phone,
                          textEditingController:phoneController,
                          textColor: Colors.black,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defualtTextFormFeild(
                          secureText: false,
                          validator: (value) {
                            if(value!.isEmpty)
                              return 'requeired Feiled';
                            else
                              return null;
                          },
                          labelText:'Email',
                          preIcon: Icons.email,
                          textEditingController:emailController,
                          textColor: Colors.black,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defualtTextFormFeild(
                          onpressedIcon: () {
                            homeLayoutCubit.changeTextFormFeildIcon();
                          },
                          sufIconData: homeLayoutCubit.isPressed?Icons.remove_moderator:Icons.shield,
                          secureText: homeLayoutCubit.isPressed,
                          validator: (value) {
                            if(value!.isEmpty)
                              return 'requeired Feiled';
                            else
                              return null;
                          },
                          labelText:'Password',
                          preIcon: Icons.key,
                          textEditingController:passwordController,
                          textColor: Colors.black,
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
                              if(formKey.currentState!.validate()){
                                homeLayoutCubit.registerButton(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            child:Text(
                              'Register',
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
              ),
            ),
          ),
        );
      },
    );
  }
}
