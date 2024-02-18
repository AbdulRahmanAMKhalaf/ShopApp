import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/HomeLayoutCubit.dart';
import 'package:shop_app/CubitsStates/HomeLayoutStates.dart';
import 'package:shop_app/Share/Componantes.dart';

class EditProfile extends StatelessWidget {
   EditProfile({super.key});

   TextEditingController name=TextEditingController();
   TextEditingController phone=TextEditingController();
   TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {
        if(state is SuccessUpdateProfileDataState){
          if(HomeLayoutCubit.get(context).updateProfileModel!.status!){
            defaultToast(
                message:HomeLayoutCubit.get(context).updateProfileModel!.message!,
                color:Colors.green,
            ).then((value){
              HomeLayoutCubit.get(context).profileModel!.data!.name=name.text;
              HomeLayoutCubit.get(context).profileModel!.data!.phone=phone.text;
              HomeLayoutCubit.get(context).profileModel!.data!.email=email.text;
              Navigator.pop(context);
            });
          }
          else
            defaultToast(
                message:HomeLayoutCubit.get(context).updateProfileModel!.message!,
                color:Colors.red,
            );
        }
      },
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Center(
              widthFactor: 2,
              child: Text(
                'Edit Informations',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defualtTextFormFeild(
                        secureText: false,
                        labelText: 'Name',
                        textColor: Colors.black,
                        preIcon: Icons.person,
                        preIconColor: Colors.black,
                        textEditingController: name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defualtTextFormFeild(
                        secureText: false,
                        labelText: 'Phone',
                        textColor: Colors.black,
                        preIcon: Icons.phone,
                        preIconColor: Colors.black,
                        textEditingController: phone,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defualtTextFormFeild(
                        secureText: false,
                        labelText: 'Email',
                        textColor: Colors.black,
                        preIcon: Icons.email,
                        preIconColor: Colors.black,
                        textEditingController: email,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue
                        ),
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed:() {
                            homeLayoutCubit.UpdateProfileyData(
                              token: Token!,
                              name: name.text,
                              email: email.text,
                              phone: phone.text,
                            );
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
