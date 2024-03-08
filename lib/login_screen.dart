import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth/regist/custom_registeration_button.dart';
import 'package:to_do_list/firebase_utils.dart';
import 'package:to_do_list/model/my_user.dart';
import 'package:to_do_list/my_theme.dart';
import 'package:to_do_list/provider/auth_provider.dart';

import 'auth/regist/registeration_tap.dart';
import 'dialog_utils.dart';
import 'home/home_screen.dart';

class LoginTap extends StatefulWidget{
  static const String routeName = 'LoginTap' ;

  @override
  State<LoginTap> createState() => _LoginTapState();
}

class _LoginTapState extends State<LoginTap> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                        CustomTextFormField(label: 'Email' , keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          obscureText: false,
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

                      ],
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    ElevatedButton(onPressed: (){
                      login();
                    }, child: Text('Login',style: TextStyle(color: Colors.white),),style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue))
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(RegisterTap.routeName);

                      }, child: Text('Create new account', style: Theme.of(context).textTheme.titleMedium,)),
                    )
                  ],
                )
              ],
            ),
          ),
        )

      ],
    );
  }

  void login() async {
    if(formKey.currentState?.validate()==true){
      // login
      // todo : showloading
      DialogUtils.showLoading(context: context, message: 'loading....', isDismissible: false);
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        var user = FireBaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(user == null){
          return ;
        }
        var authProvider = Provider.of<AuthProviders>(context , listen: false);
        authProvider.updateUser(user as MyUser);
        // todo : hide loading
        DialogUtils.hideLoading(context);
        // todo : showmessage
        DialogUtils.showMessage(context: context, message: 'Login Successfully.',
            title: 'Success',
            posActNames: 'ok',
            posAction: (){Navigator.of(context).pushNamed(HomeScreen.routeName);}
        );
        print('login successfully');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // todo : hide loading
          DialogUtils.hideLoading(context);
          // todo : showmessage
          DialogUtils.showMessage(context: context, message: 'Wrong password provided for that user.',
              title: 'Error',
              posActNames: 'ok'
          );
          print('Wrong password provided for that user.');
        }
      }
      catch(e){
        // todo : hide loading
        DialogUtils.hideLoading(context);
        // todo : showmessage
        DialogUtils.showMessage(context: context, message: '${e.toString()}',
            title: 'Error',
            posActNames: 'ok'
        );
        print(e.toString());
      }
    }
  }
}