import 'package:get/get.dart';

class LanguageTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'homePage': 'HomePage',
          'shop_by_Category': 'Shop by Category',
          'view_all': 'View all',
          'recommended_for_you': 'Recommended for you',
          'home': 'Home',
          'categories': 'Categories',
          'cart': 'Cart',
          'search': 'Search',
          'account': 'Account',
          'my_cart': 'My Cart',
          'select_language': 'Select Language',
          'english': 'English',
          'urdu': 'Urdu',
        },
        'urd_PK': {
          'homePage': 'ہوم پیج',
          'shop_by_Category': 'شاپ بی کٹگورے',
          'view_all': 'سب دیکھیں',
          'recommended_for_you': ' تجویز کردہ',
          'home': 'گھر',
          'categories': 'کیٹگریز',
          'cart': 'کارٹ',
          'search': 'تلاش',
          'account': 'اکاؤنٹ',
          'my_cart': 'ٹوکری',
          'select_language': 'زبان منتخب کریں',
          'english': 'انگلش',
          'urdu': 'اردو',
        }
      };
}


// request.time < timestamp.date(2022, 1, 2);