

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth/regist/custom_registeration_button.dart';
import 'package:to_do_list/dialog_utils.dart';
import 'package:to_do_list/firebase_utils.dart';
import 'package:to_do_list/home/home_screen.dart';
import 'package:to_do_list/model/my_user.dart';
import 'package:to_do_list/my_theme.dart';
import 'package:to_do_list/provider/auth_provider.dart';

class RegisterTap extends StatefulWidget{
  static const String routeName = 'RegisterTap' ;

  @override
  State<RegisterTap> createState() => _RegisterTapState();
}

class _RegisterTapState extends State<RegisterTap> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void register() async {
      if(formKey.currentState?.validate()==true){
        // regist
        DialogUtils.showLoading(context: context, message: 'loading....', isDismissible: false);
        try {
          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          MyUser myUser = MyUser(
              id: credential.user?.uid??'',
              name: nameController.text,
              email: emailController.text
          );
          await FireBaseUtils.addUserToFireStore(myUser);
          var authProvider = Provider.of<AuthProviders>(context , listen: false);
          authProvider.updateUser(myUser);
          // todo : hide loading
          DialogUtils.hideLoading(context);
          // todo : showmessage
          DialogUtils.showMessage(context: context, message: 'Register Successfully.',
              title: 'Success',
            posActNames: 'ok',
            posAction: (){Navigator.of(context).pushNamed(HomeScreen.routeName);}
          );
          print('register successfully');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            // todo : hide loading
            DialogUtils.hideLoading(context);
            // todo : showmessage
            DialogUtils.showMessage(context: context, message: 'The password provided is too weak.' ,
                title: 'Error',
              posActNames: 'ok',

            );
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            // todo : hide loading
            DialogUtils.hideLoading(context);
            // todo : showmessage
            DialogUtils.showMessage(context: context, message: 'The account already exists for that email.',
              title: 'Error',
              posActNames: 'ok'
            );
            print('The account already exists for that email.');
          }
        } catch (e) {
          // todo : hide loading
          DialogUtils.hideLoading(context);
          // todo : showmessage
          DialogUtils.showMessage(context: context, message: '${e.toString()}',title: 'Error',
            posActNames: 'ok');
          print(e);
        }
      }
    }
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset('assets/images/main_background.png' ,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('create account'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey ,
                    child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                    CustomTextFormField(label: 'User Name' , keyboardType: TextInputType.text,
                      controller: nameController,
                      validator: (text){
                      if(text ==null || text.trim().isEmpty){
                        return 'please enter username';
                      }
                      return null ;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    CustomTextFormField(label: 'Email' , keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text){
                        if(text ==null || text.trim().isEmpty){
                          return 'please enter Email';
                        }
                        bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if(!emailValid){
                          return 'please enter valid email address';
                        }
                        return null ;
                      },


                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    CustomTextFormField(label: 'Password', keyboardType: TextInputType.number,
                      controller: passwordController,
                      obscureText: true,
                      validator: (text){
                        if(text ==null || text.trim().isEmpty){
                          return 'please enter password';
                        }
                        if(text.length < 6 ){
                          return 'password should be 6 chars or more ';
                        }
                        return null ;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    CustomTextFormField(label: 'Confirm Password' , keyboardType: TextInputType.number,
                    controller: confirmPasswordController,
                      obscureText: true,
                      validator: (text){
                        if(text ==null || text.trim().isEmpty){
                          return "please enter confirm password";
                        }
                        if(text != passwordController.text){
                          return "confirm password doesn't match password";
                        }
                        return null ;
                      },
                    )
                  ],
                )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(onPressed: (){
                      register();
                    }, child: Text('Regist')),
                  ],
                )
              ],
            ),
          ),
        )

      ],
    );
  }


}