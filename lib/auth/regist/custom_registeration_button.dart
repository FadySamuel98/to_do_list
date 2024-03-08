import 'package:flutter/material.dart';

import '../../my_theme.dart';

class CustomTextFormField extends StatelessWidget{
  String label ;

  TextInputType keyboardType ;

  TextEditingController controller ;
  String? Function(String?) validator ;
  bool obscureText ;


  CustomTextFormField({required this.label ,
    this.keyboardType = TextInputType.text ,
    required this.controller ,
    required this.validator,
    this.obscureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyTheme.primaryColor , width: 3),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: MyTheme.primaryColor , width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: MyTheme.redColor , width: 3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: MyTheme.redColor , width: 3),
        )
      ),
      keyboardType: keyboardType ,
      controller: controller ,
      validator: validator,
      obscureText: obscureText,
    );
  }
}