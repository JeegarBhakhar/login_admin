import 'package:flutter/material.dart';

class WidgetUtil {
  Widget button(String btName, double btnHeight, double btnWidth) {
    return Container(
      height: btnHeight,
      width: btnWidth,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Center(
        child: Text(
          btName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget verspace(double space) {
    return SizedBox(
      height: space,
    );
  }

  Widget horspace(double space) {
    return SizedBox(
      width: space,
    );
  }

  void nextScreen(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void nextScreenRemoveUntil(context, page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  void nextScreenReplace(context, page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  Widget formTextFiled(
      var controller, var isObscureText, var inputType, var hintName) {
    return Form(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          obscureText: isObscureText,
          keyboardType: inputType,
          validator: (value) {
            if (hintName == 'Name') {
              if (value == null || value.isEmpty) {
                return 'Please Enter $hintName';
              }
            } else if (hintName == "E-Mail" && !validateEmail(value!)) {
              return 'Please Enter Valid E-Mail Address';
            } else if (hintName == 'Passwrod') {
              if (value == null || value.isEmpty) {
                return 'Please Enter $hintName';
              } else if (value.length < 8) {
                return 'Please Enter Password more than eight digit';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: hintName,
          ),
        ),
      ),
    );
  }

  validateEmail(String email) {
    final emailReg = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    print('email Adress ::::::: ' + emailReg.hasMatch(email).toString());
    return emailReg.hasMatch(email);
  }
}
