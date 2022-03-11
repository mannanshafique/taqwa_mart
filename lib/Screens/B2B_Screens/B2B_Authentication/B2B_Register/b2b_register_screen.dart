import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Authentication/B2B_Login/b2b_login_screen.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Authentication/b2b_auth_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Map_Screen/b2b_map_controller.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Map_Screen/b2b_map_screen.dart';

class B2BRegisterScreen extends StatelessWidget {
  // final Function toggleView;
  B2BRegisterScreen({
    Key? key,
  }) : super(key: key);

  // final authController = Get.find<AuthController>();
  final String termsText =
      'By clicking "Sign up" you are agreeing to Mungwalo\'s';
  final TextEditingController _fullNametextController = TextEditingController();
  final TextEditingController _phonetextController = TextEditingController();
  final TextEditingController _storeNametextController =
      TextEditingController();
  final TextEditingController _addresstextController = TextEditingController();
  final TextEditingController _additionalAddressTextController =
      TextEditingController();
  final TextEditingController _referraltextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  final TextEditingController _confirmpasswordtextController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK');

  final locationPickerController = Get.put(B2BLocationPickerController());

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
                          sizedBox(20.0, 0.0),
                          Center(
                              child: CommonWidget().customText('Sign Up',
                                  blackColor, 40.0, FontWeight.w500, 1)),
                          //!-----Full Name
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Full Name*', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget()
                              .textField('', _fullNametextController, false,
                                  validator: (value) {
                            if (_fullNametextController.text.isEmpty) {
                              return 'This field is required';
                            }
                          }),
                          //!-----Phone No
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Phone Number*', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          Container(child: phoneNumberField(context)),
                          //!-----Shope Name
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Store Name*', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget().textField(
                            '',
                            _storeNametextController,
                            false,
                            validator: RequiredValidator(
                                errorText: 'This field is required'),
                          ),
                          //!-----Address
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Address*', greyColor, 20.0,
                              FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          GestureDetector(
                            onTap: () {
                              print('object');
                              Get.to(() => B2BMapScreen());
                            },
                            child: CommonWidget().textField(
                              '${locationPickerController.positionCurrent.value}',
                              _addresstextController,
                              false,
                              validator: RequiredValidator(
                                  errorText: 'This field is required'),
                              isEnable: false,
                            ),
                          ),
                          //!-----------Additional Address
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Additional Address',
                              greyColor, 20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget().textField(
                            '',
                            _additionalAddressTextController,
                            false,
                            validator: (value) {},
                            isEnable: true,
                          ),
                          //!-----Refrerral Code
                          sizedBox(20.0, 0.0),
                          CommonWidget().customText('Referral Code', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget().textField(
                              '', _referraltextController, false,
                              validator: (value) {}),

                          //!-----Password
                          sizedBox(10.0, 0.0),
                          CommonWidget().customText('Password*', greyColor,
                              20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget()
                              .textField('', _passwordtextController, true,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Password is required'),
                                    MinLengthValidator(9,
                                        errorText:
                                            'Password must be at least 9 digits long'),
                                  ]),
                                  maxlength: 9),
                          //!-----Confirm Password
                          sizedBox(5.0, 0.0),
                          CommonWidget().customText('Confirm Password*',
                              greyColor, 20.0, FontWeight.normal, 1),
                          sizedBox(8.0, 0.0),
                          CommonWidget().textField(
                              '', _confirmpasswordtextController, true,
                              validator: (value) {
                            if (value != _passwordtextController.text)
                              return 'Password Not Match';
                            return null;
                          }, maxlength: 9),
                          sizedBox(20.0, 0.0),
                          termsConditionText(),
                          sizedBox(10.0, 0.0),
                          //! ---------**Sign Up Button
                          CommonWidget().button(
                              greenColor, whiteColor, 'SIGN UP', () async {
                            print(_fullNametextController.text);
                            print(locationPickerController
                                .updatedPosition!.latitude);
                            print(locationPickerController
                                .updatedPosition!.longitude);
                            _addresstextController.text =
                                locationPickerController.positionCurrent.value;

                            if (!_formKey.currentState!.validate()) {
                              print('Error');
                              return;
                            } else {
                              print('ok');
                              authController.registerButtonOnclick(
                                additionalAddress:
                                    _additionalAddressTextController.text,
                                name: _fullNametextController.text,
                                password: _passwordtextController.text,
                                shopName: _storeNametextController.text,
                                phone: _phonetextController.text,
                                referral: _referraltextController.text,
                                lat: locationPickerController
                                    .updatedPosition!.latitude,
                                lon: locationPickerController
                                    .updatedPosition!.longitude,
                              );
                            }
                          }, EdgeInsets.symmetric(vertical: 12), 22.0,
                              FontWeight.normal),
                          sizedBox(10.0, 0.0),
                          //! ---------**Login Button
                          CommonWidget().button(whiteColor, greenColor, 'LOGIN',
                              () {
                            Get.off(
                              () => B2BLoginScreen(),
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
      ),
    );
  }
}
