import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Approval_Waiting/b2b_approval_waiting.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Authentication/B2B_Register/b2b_register_screen.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Authentication/b2b_auth_controller.dart';

class B2BLoginScreen extends StatelessWidget {
  // final Function toggleView;
  B2BLoginScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController _phonetextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  Widget build(BuildContext context) {
    //! Define Controller
    final authController = Get.put(B2BAuthController(comingContext: context));
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
                        CommonWidget().sizedBox(20.0, 0.0),
                        Center(
                            child: CommonWidget().customText(
                                'Login', blackColor, 40.0, FontWeight.w500, 1)),
                        //!-------------Phone
                        CommonWidget().sizedBox(20.0, 0.0),
                        CommonWidget().customText(
                            'Phone*', greyColor, 20.0, FontWeight.normal, 1),
                        CommonWidget().sizedBox(8.0, 0.0),
                        Container(child: phoneNumberField(context)),
                        //!-------------Password
                        CommonWidget().sizedBox(20.0, 0.0),
                        CommonWidget().customText(
                          'Password*',
                          greyColor,
                          20.0,
                          FontWeight.normal,
                          1,
                        ),
                        CommonWidget().sizedBox(8.0, 0.0),
                        CommonWidget()
                            .textField('', _passwordtextController, true,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Password is required'),
                                  MinLengthValidator(8,
                                      errorText:
                                          'Password must be at least 9 digits long'),
                                ]),
                                maxlength: 9),
                        CommonWidget().sizedBox(10.0, 0.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() =>
                                    WaitingApproval(isWaitingApproval: false));
                              },
                              child: CommonWidget().customText(
                                'Forgot Your Password?',
                                blackColor,
                                18.0,
                                FontWeight.w500,
                                1,
                              ),
                            ),
                          ],
                        ),
                        CommonWidget().sizedBox(20.0, 0.0),
                        CommonWidget().button(greenColor, whiteColor, 'LOGIN',
                            () {
                          // Get.to(()=>UserModeScreen());
                          if (!_formKey.currentState!.validate()) {
                            print('Error');
                            return;
                          } else {
                            print('ok');
                            FocusScope.of(context).requestFocus(FocusNode());
                            authController.loginButtonOnclick(
                                _phonetextController.text,
                                _passwordtextController.text,
                                context);
                          }
                        }, EdgeInsets.symmetric(vertical: 12), 22.0,
                            FontWeight.normal),
                        CommonWidget().sizedBox(10.0, 0.0),
                        CommonWidget().button(whiteColor, greenColor, 'SIGN UP',
                            () {
                          Get.off(() => B2BRegisterScreen());
                        }, EdgeInsets.symmetric(vertical: 12), 22.0,
                            FontWeight.normal),
                      ],
                    ),
                  ),
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
          _phonetextController.text = number.phoneNumber!;
        },
        initialValue: number,
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN,
        ),
        ignoreBlank: true,

        selectorTextStyle: TextStyle(color: Colors.green),

        validator: MultiValidator([
          RequiredValidator(errorText: 'Phone Number is required'),
          MinLengthValidator(11, errorText: 'Number having 10 digits long'),
        ]),
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        maxLength: 11,
        inputBorder: OutlineInputBorder(),
        // onSaved: (PhoneNumber number) {
        //   print('On Saved: $number');
        // },
      ),
    );
  }
}
