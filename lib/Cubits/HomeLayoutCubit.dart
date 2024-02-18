import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/Models/CategoryModel.dart';
import 'package:shop_app/Models/HomeModel.dart';
import 'package:shop_app/Models/RegisterModel.dart';
import 'package:shop_app/Models/UpdateProfileModel.dart';
import 'package:shop_app/Models/getFavoriteModel.dart';
import 'package:shop_app/Models/logoutModel.dart';
import 'package:shop_app/Models/profileData.dart';
import 'package:shop_app/Share/DioHelper.dart';

import '../Models/Add_deleteModel.dart';
import '../Models/searchModel.dart';
import '../Share/Componantes.dart';
import '../Share/EndPoint.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit():super(InitialState());
  static HomeLayoutCubit get(context)=>BlocProvider.of(context);
  int index=0;
  void changeBottemIcon(int value){
    index=value;
    emit(ChangeBottemIconState());
  }

  bool isPressed=false;
  void changeTextFormFeildIcon(){
    isPressed= !isPressed;
    emit(ChangeTextFormFeildIconState());
  }

  RegisterModel?registerModel;
  Future registerButton({
    required String name,
    required String ?phone,
    required String email,
    required String password,
})async{
    return await DioHelper.postData(
        url:RegisterURL,
        data:{
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
        }
    ).then((value){
      print('error atregister button');
      registerModel=RegisterModel.fromJason(value.data);
      print(value.data);
      emit(SuccessRegisterButtonState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorRegisterButtonState());
    });
  }

  Map<int,bool> favorites={};
  HomeModel ?homeModel;
  Future HomeData({
    required String token,
  })async{
    return await DioHelper.getData(
        url:homeURL,
      Authorization: token,
    ).then((value){
      homeModel=HomeModel.fromJason(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!:element.favorite!,
        });
      });
      emit(SuccessGetHomeDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorGetHomeDataState());
    });
  }

  CategoryModel ?categoryModel;
  Future CategoryData()async{
    return await DioHelper.getData(
      url:categoryURL,
    ).then((value){
      categoryModel=CategoryModel.fromJason(value.data);
      emit(SuccessGetCategoryDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorGetCategoryDataState());
    });
  }

  ProfileModel ?profileModel;
  Future ProfileyData({
    required String token,
})async{
    return await DioHelper.getData(
      url:profileURL,
      Authorization: token,
    ).then((value){
      profileModel=ProfileModel.fromJason(value.data);
      emit(SuccessGetProfileDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorGetProfileDataState());
    });
  }

  UpdateProfileModel ?updateProfileModel;
  Future UpdateProfileyData({
    required String token,
    dynamic name,
    dynamic phone,
   dynamic email,
  dynamic pass
  })async{
    return await DioHelper.putData(
      url:updateProfileURL,
      Authorization: token,
      data: {
        "name":name==null?profileModel!.data!.name:name ,
        "phone":phone==null?profileModel!.data!.phone:phone,
        "email": email==null?profileModel!.data!.email:email,
      },
    ).then((value){
      updateProfileModel=UpdateProfileModel.fromJason(value.data);
      emit(SuccessUpdateProfileDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorUpdateProfileDataState());
    });
  }

  //return
  EditFavorite ?editFavorite;
  Future EditFavoriteData({
    required productID,
    required String token,
  })async{
    emit(LoadingEditFavoriteDataState());
    favorites[productID]=!favorites[productID]!;
    emit(SuccessClickFavoriteState());
    return await DioHelper.postData(
      url:favoriteURL,
      Authorization: token,
      data: {'product_id':productID,}
    ).then((value){
      editFavorite=EditFavorite.fromJason(value.data);
      if(!editFavorite!.status!)
        favorites[productID]=!favorites[productID]!;
      else
        getFavorites(token: Token!);
      emit(SuccessEditFavoriteDataState());
    }).catchError((onError){
      print(onError.toString());
      favorites[productID]=!favorites[productID]!;
      emit(ErrorEditFavoriteDataState());
    });
  }

  GetFavoriteModel ?getFavoriteModel;
  Future getFavorites({
    required String token,
  })async{
    return await DioHelper.getData(
        url:favoriteURL,
        Authorization: token,
    ).then((value){
      getFavoriteModel=GetFavoriteModel.fromJason(value.data);
      emit(SuccessGetFavoriteState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorGetFavoriteState());
    });
  }

  SearchModel ?searchModel;
  Future getSearch({
    required String token,
    required String text,
  })async{
    return await DioHelper.postData(
      url:searchURL,
      Authorization: token,
      data: {'text':text,}
    ).then((value){
      searchModel=SearchModel.fromJason(value.data);
      emit(SuccessSearchDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorSearchDataState());
    });
  }
}