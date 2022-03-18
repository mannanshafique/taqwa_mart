import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Model/Product_OrderCreation_Model/product_orderCreation_model.dart';
import 'package:mangalo_app/Screens/B2B_Screens/B2B_Cart/b2b_cart_controller.dart';
import 'package:mangalo_app/Screens/B2C_Screens/Cart/Cart_Controller/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

//!-----------------------------------------------------B2C---------------------------------------------------------------------

//! ********SignUp
class UserSignUp {
  Future userSignUp(name, email, password, phone) async {
    print('userSignUp Api');

    Uri completeUrl = Uri.parse('$b2cBaseUrl/user-signup');

    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone
    };

    final response = await http.post(completeUrl, body: data);
    if (response.statusCode == 200) {}
    return response;
  }
}

//! UserLoginIn
class UserLogin {
  Future userLogin(email, password, deviceToken) async {
    print('userLogin Api');

    Uri completeUrl = Uri.parse('$b2cBaseUrl/login');

    Map data = {
      "email": email,
      "password": password,
      "device_token": deviceToken
    };

    final response = await http.post(completeUrl, body: data);
    print(response.body);
    if (response.statusCode == 200) {}
    return response;
  }
}

//!---Notification History Fetch
class NotificationHistoryFetch {
  Future getNotificationHistoryApi() async {
    print('OrderHistoryFetch Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('userID').toString();
    Uri completeUrl = Uri.parse('$b2cBaseUrl/notificationhistory?id=$userId');

    final response = await http.get(
      completeUrl,
    );

    return response;
  }
}

//! Banner
class HomePageBanner {
  Future getHomePgaeBanner() async {
    print('getBannaer Api');

    Uri completeUrl = Uri.parse('$b2cBaseUrl/banners');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {}
    return response;
  }
}

//! Get user Profile
class UserProfile {
  Future getUserProfileData() async {
    print('getUserProfileData Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString('userID').toString();

    Uri completeUrl = Uri.parse('$b2cBaseUrl/get-customer?id=$userId');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {}
    return response;
  }
}

//! Update user Profile
class UpdateUserProfile {
  Future updateUserProfileData({phone}) async {
    print('updateUserProfileData Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Uri completeUrl = Uri.parse('$b2cBaseUrl/edit-customer');

    Map postData = {
      "id": sharedPreferences.getString('userID').toString(),
      "phone": phone,
    };
    final response = await http.post(completeUrl, body: postData);
    if (response.statusCode == 200) {}
    return response;
  }
}

//! MAinCategoryApi (1)
class CategoryApi {
  Future getCategoryfromApi() async {
    print('getMainCategory Api');

    Uri completeUrl = Uri.parse('$b2cBaseUrl/Categories');

    final response = await http.get(
      completeUrl,
    );
    // print(response.body);

    return response;
  }
}

//! Category_SubCategoryApi (2)
class SubCategoryApi {
  Future getsubCategoryfromApi(pid) async {
    print('getSubCategory(2) Api');

    Uri completeUrl = Uri.parse('$b2cBaseUrl/CategoriesByPid?id=$pid');

    final response = await http.get(
      completeUrl,
    );
    // print(response.body);

    return response;
  }
}

//! Get PRoduct from Category (3)
class ProuctUsingCategoryApi {
  //! Categ id is Like Eye/Nose
  Future getProuctUsingCategoryApi(catId) async {
    print('getProductWIthoutSoring(3) Api');
    print('its Cat Id $catId');
    Uri completeUrl =
        Uri.parse('$b2cBaseUrl/getProductByCategory?cat_id=$catId');

    final response = await http.get(
      completeUrl,
    );
    // print(response.body);

    return response;
  }
}

//! Get PRoduct from Category (4)
class ProuctSortingUsingCategoryApi {
  //! Categ id is Like Eye/Nose
  Future getSortedProuctUsingCategoryApi(catId) async {
    print('getSortedProduct(4) Api');

    Uri completeUrl =
        Uri.parse('$b2cBaseUrl/getProductBySubCategory?cat_id=$catId');

    final response = await http.get(
      completeUrl,
    );
    // print(response.body);

    return response;
  }
}

//! B2b Banner
class Search {
  Future getSearchItem(String searchItemName) async {
    print('getSearch Api');

    Uri completeUrl =
        Uri.parse('$b2cBaseUrl/SearchProducts?search=$searchItemName');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
    return response;
  }
}

//! Delivery Charges
class DeliveryCharges {
  Future getdeliveryCharges() async {
    print('getdeliveryCharges Api');
    Uri completeUrl = Uri.parse('$b2cBaseUrl/getDeliveryCharges');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {}
    return response;
  }
}

//!  Delivery Times
class DeliveryTimes {
  Future getdeliveryTimes() async {
    print('getdeliveryTimes Api');
    Uri completeUrl = Uri.parse('$b2cBaseUrl/getDeliveryTimes');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {}
    return response;
  }
}

//! Order Creation
class OrderCreation {
  Future orderCreation(
      {subtotal,
      required List<CartModel> cartList,
      deliveryCharges,
      required additionalAddress,
      deliveryTime}) async {
    print('OrderCreation Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<ProductOrderCreationModel> orderstoreList =
        <ProductOrderCreationModel>[];
    cartList.forEach((element) {
      orderstoreList.add(ProductOrderCreationModel(
          id: element.id.toString(),
          quantity: element.quantity.toString(),
          amount: element.price.toString()));
    });
    Uri completeUrl = Uri.parse('$b2cBaseUrl/Order');

    Map<String, String> headers = {"Accept": "application/json"};
    print(sharedPreferences.getString('userID').toString());
    Map data = {
      "user_id": sharedPreferences.getString('userID').toString(),
      "latitude": sharedPreferences.getString('userLat').toString(),
      "longitude": sharedPreferences.getString('userLong').toString(),
      "address": additionalAddress +
          ' ' +
          sharedPreferences.getString('updatedAddress').toString(),
      "phone": sharedPreferences.getString('userPhone').toString(),
      "subtotal": subtotal.toString(),
      "delivery_time": deliveryTime.toString(),
      "delivery_charges": deliveryCharges.toString(),
      "product":
          jsonEncode(orderstoreList.map((orders) => orders.toJson()).toList()),
    };

    final response = await http.post(completeUrl, body: data, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {}
    return response;
  }
}

//!---Order History Fetch
class OrderHistoryFetch {
  Future getOrderHistoryFetchApi() async {
    print('OrderHistoryFetch Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('userID').toString();
    print('userdid b2C $userId');
    Uri completeUrl = Uri.parse('$b2cBaseUrl/orderhistory?id=$userId');

    final response = await http.get(
      completeUrl,
    );
    print('RR ${response.body}');

    return response;
  }
}
//! B2c Cancel Order
class CancelOrder {
  Future postb2cCancelOrder(String orderId) async {
    print('postB2B Cancel Order Api');

    Uri completeUrl = Uri.parse('$b2cBaseUrl/cancel-order?order_id=$orderId');

    final response = await http.post(
      completeUrl,
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
    return response;
  }
}


//!---------------------------------------------------End B2C---------------------------------------------------------------------

//!--------------------------------------------------- B2B------------------------------------------------------------------------

//! B2b Banner
class B2BHomePageBanner {
  Future getB2BHomePgaeBanner() async {
    print('getB2BBannaer Api');

    Uri completeUrl = Uri.parse('$b2bBaseUrl/banners');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {}
    return response;
  }
}

//! MAinCategoryApi (1)
class B2bCategoryApi {
  Future getB2BCategoryfromApi() async {
    print('getMainB2BCategory Api');

    Uri completeUrl = Uri.parse('$b2bBaseUrl/Categories?lang=${Get.locale}');

    final response = await http.get(
      completeUrl,
    );
    // print(response.body);

    return response;
  }
}

//! Get PRoduct from Category (2)
class B2bProuctUsingCategoryApi {
  //! Categ id is Like Eye/Nose
  Future getB2BProuctUsingCategoryApi(catId) async {
    print('getB2BProductSoring(3) Api');

    Uri completeUrl = Uri.parse(
        '$b2bBaseUrl/productsByChildCatId?cat_id=$catId&lang=${Get.locale}');

    final response = await http.get(
      completeUrl,
    );
    // print(response.body);

    return response;
  }
}

//! Get Recommended PRoduct
class B2bRecommendedProductApi {
  //! Categ id is Like Eye/Nose
  Future getB2BProuctUsingApi() async {
    print('B2bRecommendedProductApi Api');

    Uri completeUrl =
        Uri.parse('$b2bBaseUrl/RecommendProducts?lang=${Get.locale}');

    final response = await http.get(
      completeUrl,
    );
    // print(response.body);

    return response;
  }
}

//! Order Creation
class B2BOrderCreation {
  Future b2bOrderCreation(
      {subtotal,
      required List<B2BCartModel> b2bCartList,
      deliveryCharges}) async {
    print('b2bOrderCreation Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<ProductOrderCreationModel> orderstoreList =
        <ProductOrderCreationModel>[];
    b2bCartList.forEach((element) {
      orderstoreList.add(ProductOrderCreationModel(
          id: element.id.toString(),
          quantity: element.quantity.toString(),
          amount: element.price.toString()));
    });
    Uri completeUrl = Uri.parse('$b2bBaseUrl/Order');

    Map<String, String> headers = {"Accept": "application/json"};

    Map data = {
      "user_id": sharedPreferences.getString('b2buserId').toString(),
      "latitude": sharedPreferences.getString('b2buserlatitude').toString(),
      "longitude": sharedPreferences.getString('b2buserlongitude').toString(),
      "address": sharedPreferences.getString('b2buserAddress').toString(),
      "phone": sharedPreferences.getString('b2buserPhone').toString(),
      "subtotal": subtotal.toString(),
      "delivery_charges": deliveryCharges.toString(),
      "product":
          jsonEncode(orderstoreList.map((orders) => orders.toJson()).toList()),
    };

    final response = await http.post(completeUrl, body: data, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {}
    return response;
  }
}

//! B2b Delivery Charges
class B2BDeliveryCharges {
  Future getB2BdeliveryCharges() async {
    print('getB2BdeliveryCharges Api');
    Uri completeUrl = Uri.parse('$b2bBaseUrl/getDeliveryCharges');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {}
    return response;
  }
}

// //! B2b Delivery Times
// class B2BDeliveryTimes {
//   Future getB2BdeliveryTimes() async {
//     print('getB2BdeliveryTimes Api');
//     Uri completeUrl = Uri.parse('$b2bBaseUrl/getDeliveryTimes');

//     final response = await http.get(
//       completeUrl,
//     );
//     if (response.statusCode == 200) {}
//     return response;
//   }
// }

//!---Order History Fetch
class B2BOrderHistoryFetch {
  Future getB2BOrderHistoryFetchApi() async {
    print('B2BOrderHistoryFetch Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('b2buserId').toString();
    Uri completeUrl = Uri.parse('$b2bBaseUrl/orderhistory?id=$userId');

    final response = await http.get(
      completeUrl,
    );
    //  print('RR ${response.body}');

    return response;
  }
}

//!---Notification History Fetch
class B2BNotificationHistoryFetch {
  Future getB2BNotificationHistoryApi() async {
    print('B2BOrderHistoryFetch Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('b2buserId').toString();
    Uri completeUrl = Uri.parse('$b2bBaseUrl/notificationhistory?id=$userId');

    final response = await http.get(
      completeUrl,
    );

    return response;
  }
}

//!---Notification Count
class B2BNotificationCount {
  //!----When api hit inc++ in backend
  Future getNotificationCountApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('b2buserId').toString();
    Uri completeUrl =
        Uri.parse('$b2bBaseUrl/count-unread-notification?id=$userId');

    final response = await http.get(
      completeUrl,
    );

    return response;
  }
}

//! UserLoginIn
class B2BUserLogin {
  Future b2buserLogin(phone, password, deviceToken) async {
    print('B2BuserLogin Api');

    Uri completeUrl = Uri.parse('$b2bBaseUrl/Login');

    Map data = {
      "password": password,
      "phone": '$phone',
      "device_token": deviceToken
    };

    final response = await http.post(completeUrl, body: data);
    print(response.body);
    if (response.statusCode == 200) {}
    return response;
  }
}

//! ********SignUp
class B2BUserSignUp {
  Future b2buserSignUp(
      {name,
      password,
      phone,
      shopName,
      required double lati,
      required double long,
      required String address,
      referral}) async {
    print(name);
    print(password);
    print(phone);
    print(lati);
    print(long);
    print(referral);
    print('userSignUp Api');

    Uri completeUrl = Uri.parse('$b2bBaseUrl/SignUp');

    Map<String, String> headers = {"Accept": "application/json"};
    Map data = {
      "name": name.toString(),
      "shop_name": shopName.toString(),
      "password": password.toString(),
      "phone": phone.toString(),
      "lat": lati.toString(),
      "lon": long.toString(),
      "address": address,
      "referral": referral.toString()
    };

    final response = await http.post(completeUrl, body: data, headers: headers);

    print(response.body);
    if (response.statusCode == 200) {}
    return response;
  }
}

//! B2b Search
class B2BSearch {
  Future getB2BSearchItem(String searchItemName) async {
    print('getB2BSearch Api');

    Uri completeUrl =
        Uri.parse('$b2bBaseUrl/SearchProducts?search=$searchItemName');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
    return response;
  }
}


//!-----------()
class B2bRbdList{
  Future postB2bRbdList({required String type,required String maundRate}) async {
    print('postB2B RbdListing');

    Uri completeUrl = Uri.parse('$b2bBaseUrl/list/rbd');
Map data = {
     "type" : type,
     "maund_rate": maundRate,
    };
    final response = await http.post(
      completeUrl,body: data
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
    return response;
  }
}

// https://mungalo-b2b.freshchoice.pk/public/api/cancel-order
//! B2b Cancel Order
class B2BCancelOrder {
  Future postB2BCancelOrder(String orderId) async {
    print('postB2B Cancel Order Api');

    Uri completeUrl = Uri.parse('$b2bBaseUrl/cancel-order?order_id=$orderId');

    final response = await http.post(
      completeUrl,
    );
    if (response.statusCode == 200) {
      print(response.body);
    }
    return response;
  }
}

//! Get user Profile
class B2BUserProfile {
  Future getB2bUserProfileData() async {
    print('getB2bUserProfileData Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString('b2buserId').toString();

    Uri completeUrl = Uri.parse('$b2bBaseUrl/get-retailer?id=$userId');

    final response = await http.get(
      completeUrl,
    );
    if (response.statusCode == 200) {}
    return response;
  }
}

//! Update user Profile
class B2BUpdateUserProfile {
  Future b2bUpdateUserProfileData({phone}) async {
    print('b2bUpdateUserProfileData Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Uri completeUrl = Uri.parse('$b2bBaseUrl/edit-retailer');

    Map postData = {
      "id": sharedPreferences.getString('b2buserId').toString(),
      "phone": phone,
    };
    final response = await http.post(completeUrl, body: postData);
    if (response.statusCode == 200) {}
    return response;
  }
}

//!----------------------------------Guest

// http://165.227.69.207/zkadmin/public/api/GuestOrder
// user_id replace to guest_name

//! Order Creation
class GuestOrderCreation {
  Future guestOrderCreation(
      {subtotal,
      required String guestName,
      required String guestPhone,
      required List<CartModel> cartList,
      required additionalAddress,
      deliveryCharges,
      deliveryTime}) async {
    print('Guest OrderCreation Api');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<ProductOrderCreationModel> orderstoreList =
        <ProductOrderCreationModel>[];
    cartList.forEach((element) {
      orderstoreList.add(ProductOrderCreationModel(
          id: element.id.toString(),
          quantity: element.quantity.toString(),
          amount: element.price.toString()));
    });
    Uri completeUrl =
        Uri.parse('http://165.227.69.207/zkadmin/public/api/GuestOrder');

    Map<String, String> headers = {"Accept": "application/json"};

    Map data = {
      "guest_name": guestName,
      "latitude": sharedPreferences.getString('userLat').toString(),
      "longitude": sharedPreferences.getString('userLong').toString(),
      "address": additionalAddress +
          ' ' +
          sharedPreferences.getString('updatedAddress').toString(),
      "phone": guestPhone,
      "subtotal": subtotal.toString(),
      "delivery_time": deliveryTime.toString(),
      "delivery_charges": deliveryCharges.toString(),
      "product":
          jsonEncode(orderstoreList.map((orders) => orders.toJson()).toList()),
    };

    final response = await http.post(completeUrl, body: data, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {}
    return response;
  }
}
