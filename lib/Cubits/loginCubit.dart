import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Share/DioHelper.dart';

import '../CubitsStates/LoginStates.dart';
import '../Models/LoginModel.dart';
import '../Share/EndPoint.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(InitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  bool isPressed=false;
  void changeTextFormFeildIcon(){
  isPressed= !isPressed;
  emit(ChangeTextFormFeildIconState());
}

  LoginModel ?loginModel;

  Future loginButton({
    required String email,
    required String password,
}){
    emit(LoadingLoginButtonState());
   return DioHelper.postData(
        url:LoginURL,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value){
      loginModel=LoginModel.fromJason(value.data);
      emit(SuccessLoginButtonState());
   }).catchError((onError){
     print(onError.toString());
     emit(ErrorLoginButtonState());
   });
  }


}