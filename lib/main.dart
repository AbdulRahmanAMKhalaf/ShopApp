
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/Cubits/loginCubit.dart';
import 'package:shop_app/Modules/HomeLayoutScreen.dart';
import 'package:shop_app/Modules/HomeScreen.dart';
import 'package:shop_app/Share/DioHelper.dart';
import 'package:shop_app/Share/SharedPreferences.dart';

import 'Modules/LoginScreen.dart';
import 'Modules/OnBourdingScreen.dart';
import 'Modules/RegisterScreen.dart';
import 'Modules/SettingsSreen.dart';
import 'Share/Componantes.dart';
import 'Share/CubitObserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.initialDioHelper();
  await CacheHelper.initialCacheHelper();
  bool? skipBoarding=CacheHelper.getBooleanData(key: 'Boarding')==null?false:CacheHelper.getBooleanData(key: 'Boarding');
  bool? skipLogin=CacheHelper.getBooleanData(key: 'Login')==null?false:CacheHelper.getBooleanData(key: 'Login');
  Widget Screen;
  if(skipBoarding==true){
    if(skipLogin==true) {
      Screen=HomeLayoutScreen();
    } else
      Screen=LoginScreen();
  }
  else
    Screen=OnBourdingScreen();
  runApp( MyApp(skipBoarding: /*skipBoarding!*/false,skipLogin:/* skipLogin!*/false,screen: Screen,));
}

class MyApp extends StatelessWidget {
  bool skipBoarding;
  bool skipLogin;
  Widget screen;
   MyApp({required this.skipLogin,required this.skipBoarding,required this.screen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:(context) => HomeLayoutCubit()
            ..HomeData(token:Token!)
            ..CategoryData()
            ..ProfileyData(token: Token!)
              ..getFavorites(token: Token!),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
          ),
        ),
        home: OnBourdingScreen(),
      ),
    );
  }
}

