import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mangalo_app/Api/Api_Integration/api_integration.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Auth_Controller/auth_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Authentication/Login_Screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  // final Function toggleView;
  RegisterScreen({
    Key? key,
  }) : super(key: key);

  // final authController = Get.find<AuthController>();
  final String termsText =
      'By clicking "Sign up" you are agreeing to Mungwalo\'s';
  final TextEditingController fullNametextController = TextEditingController();
  final TextEditingController phonetextController = TextEditingController();
  final TextEditingController emailtextController = TextEditingController();
  final TextEditingController passwordtextController = TextEditingController();
  final TextEditingController confirmpasswordtextController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK');
  final toggleValue = ValueNotifier<bool>(false);
  //! Define Controller
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: Obx(() => Stack(
              children: [
                SafeArea(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        children: [
                          sizedBox(20.0, 0.0),
                          Center(
                              child: CommonWidget().customText('Sign Up',
                                  blackColor, 40.0, FontWeight.w500, 1)),
                          sizedBox(10.0, 0.0),
                          //!----Guest Mode Toggle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonWidget().customText('Guest Mode',
                                  blackColor, 20.0, FontWeight.bold, 1),
                              sizedBox(0.0, 10.0),
                              // AdvancedSwitch(
                              //   width: 60.0,
                              //   height: 20.0,
                              //   controller: toggleValue,
                              //   activeColor: Colors.green,
                              //   inactiveColor: Colors.grey,
                              //   activeChild: Text('ON'),
                              //   inactiveChild: Text('OFF'),
                              //   borderRadius:
                              //       BorderRadius.all(const Radius.circular(15)),
                              //   enabled: true,
                              //   disabledOpacity: 0.5,
                              // ),
                            ],
                          ),
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Full Name*', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget().textField(
                            '',
                            fullNametextController,
                            false,
                            validator: RequiredValidator(
                                errorText: 'This field is required'),
                          ),
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Phone Number*', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          Container(child: phoneNumberField(context)),
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Email Id*', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget().textField(
                            '',
                            emailtextController,
                            false,
                            validator: EmailValidator(
                                errorText: 'Enter a valid email address'),
                          ),
                          sizedBox(20.0, 0.0),
                          //!-------Password Fileds
                          ValueListenableBuilder<bool>(
                              valueListenable: toggleValue,
                              builder: (context, value, _) {
                                return Visibility(
                                    visible: !value,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonWidget().customText(
                                            'Password*',
                                            greyColor,
                                            20.0,
                                            FontWeight.normal,
                                            1),
                                        sizedBox(8.0, 0.0),
                                        CommonWidget().textField(
                                          '',
                                          passwordtextController,
                                          true,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    'password is required'),
                                            MinLengthValidator(8,
                                                errorText:
                                                    'password must be at least 8 digits long'),
                                          ]),
                                          maxlength: 9,
                                        ),
                                        sizedBox(10.0, 0.0),
                                        CommonWidget().customText(
                                            'Confirm Password*',
                                            greyColor,
                                            20.0,
                                            FontWeight.normal,
                                            1),
                                        sizedBox(8.0, 0.0),
                                        CommonWidget().textField(
                                          '',
                                          confirmpasswordtextController,
                                          true,
                                          validator: (value) {
                                            if (value !=
                                                passwordtextController.text)
                                              return 'Password Not Match';
                                            return null;
                                          },
                                          maxlength: 9,
                                        ),
                                      ],
                                    ));
                              }),
                          sizedBox(20.0, 0.0),
                          termsConditionText(),
                          sizedBox(10.0, 0.0),
                          //! ---------**Sign Up Button
                          CommonWidget().button(
                              greenColor, whiteColor, 'SIGN UP', () async {
                            if (!_formKey.currentState!.validate()) {
                              print('Error');
                              return;
                            } else {
                              print('ok');
                              authController.registerButtonOnclick(
                                fullNametextController.text,
                                emailtextController.text,
                                passwordtextController.text,
                                phonetextController.text,
                              );
                            }
                          }, EdgeInsets.symmetric(vertical: 12), 22.0,
                              FontWeight.normal),
                          sizedBox(10.0, 0.0),
                          //! ---------**Login Button
                          CommonWidget().button(whiteColor, greenColor, 'LOGIN',
                              () {
                            Get.off(
                              () => LoginScreen(),
                            );
                          }, EdgeInsets.symmetric(vertical: 12), 22.0,
                              FontWeight.normal),
                        ],
                      )),
                ),
                //! -----------***Progress Loader***
                (authController.isLoading.value)
                    ? Container(
                        height: Get.height,
                        width: double.infinity,
                        color: Colors.black45,
                        child: Center(
                          child: CircularProgressIndicator(color: greenColor),
                        ),
                      )
                    : Container()
              ],
            )));
  }

  Widget sizedBox(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget termsConditionText() {
    return RichText(
        text: TextSpan(
            text: termsText,
            style: TextStyle(color: blackColor, fontSize: 15),
            children: [
          TextSpan(
              text: ' Terms & Condition',
              style: TextStyle(color: greenColor, fontSize: 15))
        ]));
  }

  Widget phoneNumberField(context) {
    return //! *****************
        Theme(
      data: Theme.of(context).copyWith(canvasColor: whiteColor),
      child: InternationalPhoneNumberInput(
        autoValidateMode: AutovalidateMode.disabled,
        //! ****Border Color
        inputDecoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: greenColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: greenColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: greenColor),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                )),
            contentPadding: EdgeInsets.symmetric(horizontal: 10)),
        //! **** End Border Color

        onInputChanged: (PhoneNumber number) {
          print(number.phoneNumber);
          phonetextController.text = number.phoneNumber!;
        },
        initialValue: number,
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN,
        ),
        ignoreBlank: true,

        selectorTextStyle: TextStyle(color: Colors.green),

        validator: MultiValidator([
          RequiredValidator(errorText: 'Phone Number is required'),
          MinLengthValidator(10,
              errorText: 'Phone Number having 10 digits long'),
        ]),
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputBorder: OutlineInputBorder(),
        // onSaved: (PhoneNumber number) {
        //   print('On Saved: $number');
        // },
      ),
    );
  }
}
