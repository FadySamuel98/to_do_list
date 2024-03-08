import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoading({required BuildContext context ,required String message , bool isDismissible = true}){
   showDialog(context: context,
       barrierDismissible: isDismissible ,
       builder: (context){
     return AlertDialog(
       content:Row(
         children: [
           CircularProgressIndicator(),
           SizedBox(width: 15,),
           Text(message),
         ],
       ),
     );
       }
   );
  }
  static void hideLoading( BuildContext context ){
    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context , required String message ,
    String? posActNames ,
    Function? posAction,
    String? negActNames ,
    Function? negAction,
    String? title , bool isDismissible = true
  }){
    List<Widget> actions = [];
    if(posActNames != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posAction != null){
          posAction.call();
        }
      }, child: Text(posActNames)));
    }
    if(negActNames != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(negAction != null){
          negAction.call();
        }
      }, child: Text(negActNames)));
    }
    showDialog(context: context,
        barrierDismissible: isDismissible,
        builder: (context){
          return AlertDialog(
            content: Text(message),
            title: Text(title?? '' , style: Theme.of(context).textTheme.titleMedium,) ,
            actions: actions
          );
        }
    );
  }

}