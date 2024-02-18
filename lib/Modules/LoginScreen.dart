import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/LoginStates.dart';
import 'package:shop_app/Modules/HomeLayoutScreen.dart';
import 'package:shop_app/Share/DioHelper.dart';
import 'package:shop_app/Share/SharedPreferences.dart';
import '../Cubits/loginCubit.dart';
import '../Share/Componantes.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is SuccessLoginButtonState){
            if(LoginCubit.get(context).loginModel!.status!){
              print(LoginCubit.get(context).loginModel!.status!);
              defaultToast(
                message: LoginCubit.get(context).loginModel!.message!,
                color: Colors.green,
              ).then((value){
                Token=LoginCubit.get(context).loginModel!.data!.token!;
                CacheHelper.setData(key: 'token', value: LoginCubit.get(context).loginModel!.data!.token!);
                CacheHelper.setData(
                    key: 'Login', value: true);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder:(context) => HomeLayoutScreen(),
                    ),
                    (route) => false,
                );
              }).catchError((onError){
                print(onError.toString()+'AT TOAST');
              });
            }
            else
              defaultToast(
                  message:LoginCubit.get(context).loginModel!.message! ,
                  color: Colors.red
              );
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit=LoginCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,

                            ),
                          ),
                          Container(
                            height: 5,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          defualtTextFormFeild(
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if(value!.isEmpty)
                                return 'requeired Feiled';
                              else
                                return null;
                            },
                            secureText: false,
                            labelText: 'Email',
                            textEditingController:emailController,
                           preIcon: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defualtTextFormFeild(
                            type: TextInputType.text,
                            validator: (value) {
                              if(value!.isEmpty)
                                return 'requeired Feiled';
                              else
                                return null;
                            },
                            labelText: 'Password',
                            secureText:loginCubit.isPressed?false:true ,
                            textEditingController:passwordController,
                            preIcon: Icons.key,
                            onpressedIcon: () {
                              loginCubit.changeTextFormFeildIcon();
                            },
                            sufIconData: loginCubit.isPressed?Icons.remove_moderator:Icons.shield,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is !LoadingLoginButtonState ,
                            builder:(context) =>  Container(
                              height: 63,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue
                              ),
                              child: TextButton(
                                onPressed:() {
                                  if(formKey.currentState!.validate()) {
                                    loginCubit.loginButton(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child:Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ) ,
                            fallback:(context) => Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                  onPressed:() {
                                    Navigator.push(context,
                                       MaterialPageRoute(
                                           builder:(context) => RegisterScreen(),
                                       ),
                                    );
                                  },
                                  child:Text(
                                    'Register now',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.blue
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
