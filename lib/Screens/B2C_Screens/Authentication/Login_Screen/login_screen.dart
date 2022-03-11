import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Auth_Controller/auth_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Register_Screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  // final Function toggleView;
  LoginScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController emailtextController = TextEditingController();
  final TextEditingController passwordtextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //! Define Controller
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              children: [
                CommonWidget().sizedBox(20.0, 0.0),
                Center(
                    child: CommonWidget().customText(
                        'Login', blackColor, 40.0, FontWeight.w500, 1)),
                CommonWidget().sizedBox(20.0, 0.0),
                CommonWidget().customText(
                    'Email Id*', greyColor, 20.0, FontWeight.normal, 1),
                CommonWidget().sizedBox(8.0, 0.0),
                CommonWidget().textField(
                  '',
                  emailtextController,
                  false,
                  validator:
                      EmailValidator(errorText: 'Enter a valid email address'),
                ),
                CommonWidget().sizedBox(20.0, 0.0),
                CommonWidget().customText(
                    'Password*', greyColor, 20.0, FontWeight.normal, 1),
                CommonWidget().sizedBox(8.0, 0.0),
                CommonWidget().textField('', passwordtextController, true,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'password is required'),
                      MinLengthValidator(8,
                          errorText: 'password must be at least 8 digits long'),
                    ]),
                    maxlength: 9),
                CommonWidget().sizedBox(20.0, 0.0),
                CommonWidget().button(greenColor, whiteColor, 'LOGIN', () {
                  // Get.to(()=>UserModeScreen());
                  if (!_formKey.currentState!.validate()) {
                    print('Error');
                    return;
                  } else {
                    print('ok');
                    authController.loginButtonOnclick(
                        emailtextController.text, passwordtextController.text);
                  }
                }, EdgeInsets.symmetric(vertical: 12), 22.0, FontWeight.normal),
                CommonWidget().sizedBox(10.0, 0.0),
                CommonWidget().button(whiteColor, greenColor, 'SIGN UP', () {
                  Get.off(() => RegisterScreen());
                }, EdgeInsets.symmetric(vertical: 12), 22.0, FontWeight.normal),
              ],
            ),
          ),
        ));
  }
}
