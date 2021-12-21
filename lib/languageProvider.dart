import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanProvider with ChangeNotifier {
  bool isEn = false;

  Map<String, Object> arabic = {
    'order ur food..': 'اطلب اكلك واستمتع !',
    'choose ur..': 'اختر مطعمك المفضل !',
    'ok': "حسنا",
    'welcome': 'مرحبا بك',
    'Drawer1': 'الصفحة الرئيسية',
    'Drawer2': 'حسابي',
    'Drawer3': 'المفضلة',
    'Drawer4': 'عناوين التوصيل',
    'Drawer5': 'طلباتي السابقة',
    'Drawer6': 'الإعدادات',
    'Drawer7': 'حول التطبيق',
    'Drawer8': 'تسجيل الخروج',
    'Drawer9':'الوجبات',
    'Drawer10':'المشروبات',
    'my account': 'حسابي',
    'my email': 'البريد الالكتروني',
    'my name': 'اسمي',
    'my password': 'تغيير كلمة المرور',
    'change email': 'تغيير البريد الالكتروني',
    'save&exit': 'احفظ واخرج',
    'pass': 'كلمة المرور',
    'email': 'البريد الالكتروني',
    'change name': 'تغيير الاسم',
    'name': 'اسمي',
    'current pass': 'كلمة المرور الحالية',
    'new pass': 'كلمة المرور الجديدة',
    'confirm pass': 'تأكيد كلمة المرور',
    'my favorites': 'المفضلة',
    'my addresses': 'عناوين التوصيل',
    'new address': 'اضف عنوان جديد',
    'area': 'المنطقه (مطلوب)',
    'street': 'الشارع : ',
    'street:': 'الشارع : ',
    'phone number': 'رقم الهاتف (مطلوب) :',
    'phone:': 'رقم الهاتف : ',
    'add': 'اضافه',
    'save': 'احفظ',
    'orders history': 'طلباتي السابقة',
    'language': 'اللغة',
    'dark mode': 'الوضع الليلي',
    'call us': 'إتصل بنا',
    'rate app': 'قيم التطبيق',
    'share app': 'شارك التطبيق',
    'required': 'مطلوب',
    'tab1': 'شاورما & بروستد',
    'tab2': 'سناكات & برغر',
    'tab3': 'غير ذلك',
    'tab4': 'كنافه & بيتفور',
    'tab5': 'كيك & وافل',
    'tabPizza':'بيتزا',
    'tabArza':'بيتزا ومعجنات',
    'tabManakeesh':'مناقيش',
    'tabRice': 'سدور الأرز',
    'tabRice2': 'وجبات الأرز',
    'tabPM':'بروستد',
    'tabChicken':'الأرز والدجاج',
    'tabDwairy':'الدويري',
    'tabBreakFast':'الفطور',
    'tabNafesa': 'قوالب جاتو',
    'tabMashrouh':'مشروح',
    'tab1edited':'شاورما',
    'tabfalafel&snacks':'فلافل وسناك',
    'tabmo3ajanat':'معجنات',
    'tabHummus':'حمص فول فتة',
    'tabMilk':'ميلك شيك وبوظة',
    'tabMixes':'مكسات',
    'tabHot':'مشروبات ساخنة',
    'tabSnacks':'سناكات',
    'tabPizza&mnaqish':'بيتزا ومناقيش',
    'tabSweets':'حلويات',
    'tabCocktail':'كوكتيل وايس كريم',

    'tabCockTail':'كوكتيل طبيعي',
    'tabNaturalDrinks':'عصائر طبيعية',
    'tabSpecial':'سبيشل كوكتيل',
    'tabSlushDrinks':'سلاش طبيعي',
    'tabSalads':'سلطات الفواكة',
    'tabWaffles&Pancakes':'كريب, وافل, بان كيك',

    'tabRolls':'مطبقات ورولز',
    'tabWaffle':'وافل وبان كيك',
    'food cart': 'سلة الطلبات',
    'total': 'المجموع :',
    'jd': 'د.أ',
    'price': 'السعر : ',
    'log out?': 'هل تريد تسجيل الخروج؟',
    'clear everything?': 'هل تريد حذف جميع الطلبات ؟',
    'yes?': 'نعم',
    'cancel?': 'الغاء',
    'delete this address?': 'هل تريد حذف هذا العنوان ؟',
    'ur password isnt correct': '! كلمة المرور غير صحيحه',
    'empty field': '! حقل فارغ ',
    'pass must be 6': 'كلمة المرور يجب ان تكون على الاقل 6 حروف ',
    'passwords dont match': 'كلمات المرور لا يتطابقان ',
    'new pass must be':
    ' كلمة السر الجديدة يجب ان تكون مختلفة عن كلمة السر القديمة',
    'delete this meal?': 'هل تريد حذف هذه الوجبة؟',
    'edit meal': 'تغيير الوجبة',
    'meal name': 'اسم الوجبة',
    'meal name : ': 'إسم الوجبة : ',
    'meal price': 'سعر الوجبة',
    'meal price : ': 'السعر : ',
    'quantity : ': 'الكمية : ',
    'add meal': 'اضافة وجبة جديدة',
    'add text': 'اضافة الى',
    'about': 'حول التطبيق',
    'hello': 'مرحبا, شكراً لإستخدامكم تطبيقنا.',
    'If you face':
    'اذا واجهتم مشاكل خلال استخدامكم التطبيق الرجاء التواصل مع الدعم الفني.',
    'Error occurred !': '! حدث خطأ',
    'something went wrong !': '! حدث خطأ',
    'no meals were added to favorites': 'لا يوجد وجبات مفضلة لديك',
    'desc': 'الوصف',
    'Pass Updated': 'تم تحديث كلمة السر بنجاح',
    'Email Updated Successfully': 'تم تحديث بريدك الالكتروني بنجاح',
    'Name Updated Successfully': 'تم تحديث اسمك بنجاح',
    'badly formatted': '! بريد الكتروني خاطئ',
    'new email must diff': 'بريدك الجديد يجب ان يكون مختلف عن بريدك الحالي',
    'new name must diff': 'اسمك الجديد يجب ان يكون مختلف عن اسمك الحالي',
    "Address Deleted": 'تم حذف العنوان',
    'Address Added': 'تم اضافة عنوان جديد',
    'delete': 'احذف',
    'Meal Added': 'تم اضافة الوجبة',
    'Meal Deleted': 'تم حذف الوجبة',
    'location': 'لقد حصلنا على موقعك بنجاح',
    'Choose your area': 'يجب اختيار المنطقة',
    'invalid': 'غير صالح',
    'empty cart': 'سلة الطلبات فارغة !',
    'cart total :': 'سعر الوجبات : ',
    'Next': 'التالي',
    'choose address': 'إختر عنوان',
    'CheckOut': 'تأكيد الطلب',
    'deliver to': 'التوصيل الى :',
    'delivery price': 'سعر التوصيل :',
    'note': 'ملاحظاتك : ',
    'notes':'الملاحظات : ',
    'Shawarma & snacks': 'شاورما وسناكات',
    'homos & falafel': 'حمص وفلافل',
    'Sweets': 'حلويات',
    'drinks': 'مشروبات ومكسات',
    'choose ur sweet': 'اختر محلك المفضل !',
    'empty': 'فارغ !',
    'order confirmed': 'تم تأكيد طلبك بنجاح',
    'reorder?': 'هل تريد إعادة الطلب؟',
    'reorder': 'إعادة الطلب',
    'order deleted': 'تم حذف الطلب بنجاح',
    'delete order?': 'هل تريد حذف هذا الطلب؟',
    'must location on': 'يجب تفعيل الموقع لتجربة افضل',
    'foodCart':
    'هل تريد حذف محتويات سلة الطلبات خاصتك والبدأ بسلة طلبات جديدة؟',
    'no orders': 'لا يوجد لديك طلبات مسبقة',
    'will reach out to u': 'سيتم التواصل معك قريباً',
    'alert': 'إنتباه !',
    'details': 'التفاصيل',
    'orders':'الطلبات',
    'choose one':'إختر طريقة',
    'gallery':'المعرض',
    'camera':'الكاميرا',
    'add image':'إضافة صورة',
    'last note':
    'في بعض الحالات (اذا كان الطلب حساس او كبير الحجم او في حال عدم توفر دراجة بتلك اللحظة) سيتم التوصيل عن طريق السيارة وسيتم زيادة نصف دينار على سعر التوصيل.',
  };
  Map<String, Object> english = {
    'order ur food..': 'Order your food now and enjoy !',
    'choose ur..': 'Choose your favorite restaurant !',
    'welcome': 'Welcome',
    'ok': "OK",
    'Drawer1': 'Home',
    'Drawer2': 'Account',
    'Drawer3': 'Favorites',
    'Drawer4': 'Addresses',
    'Drawer5': 'History',
    'Drawer6': 'Settings',
    'Drawer7': 'About',
    'Drawer8': 'Log out',
    'Drawer9':'Meals',
    'Drawer10':'Drinks',
    'my account': 'My Account',
    'my email': 'My Email',
    'my name': 'My Name',
    'my password': 'My Password',
    'change email': 'Change Email',
    'save&exit': 'Save & exit',
    'pass': 'Password',
    'email': 'E-mail',
    'change name': 'Change Name',
    'name': 'Name',
    'current pass': 'Current Password',
    'new pass': 'New password',
    'confirm pass': 'Confirm Password',
    'my favorites': 'My Favorites',
    'my addresses': 'My Addresses',
    'new address': 'Add A New Address',
    'required': 'Required',
    'area': 'Area (required)',
    'street': 'Street : ',
    'street:': 'street: ',
    'phone number': 'Phone Number (required) :',
    'phone:': 'Mobile : ',
    'add': 'Add',
    'save': 'Save',
    'orders history': 'Orders History',
    'language': 'Language',
    'dark mode': 'Dark Mode',
    'call us': 'Call Us',
    'rate app': 'Rate The Application',
    'share app': 'Share The Application',
    'tab1': 'Shawarma & broasted',
    'tab2': 'Snacks & burgers',
    'tab3': 'Others',
    'tab4': 'Kunafeh & cookies',
    'tab5': 'Cake & waffle',
    'tabPM':'Broasted',
    'tabPizza':'Pizza',
    'tabArza':'Pizza & pastries',
    'tabManakeesh':'Manakeesh',
    'tabRice': 'Rice',
    'tabRice2': 'Rice meals',
    'tabNafesa': 'Gateau',
    'tabMashrouh':'Mashrouh',
    'tabChicken':'Rice & Chicken',
    'tabDwairy':'Aldwairy',
    'tabBreakFast':'BreakFast',
    'tab1edited':'Shawarma',
    'tabfalafel&snacks':'Falafel & snacks',
    'tabmo3ajanat':'Pastries',
    'tabHummus':'Hummus',
    'tabMilk':'MilkShake & IceCream',
    'tabMixes':'Mixes',
    'tabSnacks':'Snacks',
    'tabPizza&mnaqish':'Pizza & Manakeesh',
    'tabSweets':'Sweets',
    'tabRolls':'Rolls',
    'tabWaffle':'Waffles & Pancake',
    'tabCocktail':'Cocktail & IceCream',
    'tabCockTail':'كوكتيل طبيعي',
    'tabNaturalDrinks':'Natural Drinks',
    'tabSpecial':'Special Cocktails',
    'tabSlushDrinks':'Natural Slush',
    'tabSalads':'Fruit Salads',
    'tabWaffles&Pancakes':'Waffle,Crepe,Pancakes',
    'tabHot':'Hot Drinks',
    'food cart': 'Food Cart',
    'total': 'Total :',
    'jd': 'JD',
    'price': 'Price : ',
    'log out?': 'Are you sure you want to log out ?',
    'clear everything?': 'Do you want to clear everything ?',
    'yes?': 'Yes',
    'cancel?': 'Cancel',
    'delete this address?': 'Are you sure you want to delete this address ?',
    'ur password isnt correct': 'Your password is not correct !',
    'empty field': 'Empty field !',
    'pass must be 6': 'Password must be at least 6 characters !',
    'new pass must be': 'New password must be different than old password',
    'passwords dont match': 'The passwords do not match !',
    'delete this meal?': 'Are you sure you want to delete this meal ?',
    'edit meal': 'Edit Meal',
    'meal name': 'Meal Name',
    'meal name : ': 'Meal name : ',
    'meal price : ': 'Price : ',
    'quantity : ': 'Quantity : ',
    'meal price': 'Meal Price',
    'add meal': 'Add Meal',
    'add text': 'Add To',
    'about': 'About The Application',
    'hello': 'Hello, thanks for using our app.',
    'If you face':
    'If you face any problem let the support know please and thank you !',
    'Error occurred !': 'Error occurred !',
    'something went wrong !': 'something went wrong !',
    'no meals were added to favorites': 'you don\'t have any favorite meal',
    'desc': 'Description',
    'Pass Updated': 'Password Updated Successfully',
    'Email Updated Successfully': 'Email Updated Successfully',
    'Name Updated Successfully': 'Name Updated Successfully',
    'badly formatted': 'The email address is badly formatted.',
    'new email must diff':
    'Your new email must be different than your current email',
    'new name must diff':
    'Your new name must be different than your current name',
    'Address Deleted': 'Address Deleted',
    'Address Added': 'Address Added',
    'delete': 'Delete',
    'Meal Added': 'Meal Added',
    'Meal Deleted': 'Meal Deleted',
    'location': 'We have got your location successfully',
    'Choose your area': 'Choose your area',
    'invalid': 'invalid',
    'empty cart': 'your food cart is empty !',
    'cart total :': 'Meals price :',
    'Next': 'Next',
    'choose address': 'Choose an address',
    'CheckOut': 'Confirm order',
    'deliver to': 'Deliver to :',
    'delivery price': 'Delivery price :',
    'note': 'Notes : ',
    'notes':'Notes : ',
    'Shawarma & snacks': 'Shawarma & Snacks',
    'homos & falafel': 'Homos & Falafel',
    'Sweets': 'Sweets',
    'drinks': 'Drinks',
    'choose ur sweet': 'Choose your favorite !',
    'empty': 'Empty !',
    'order confirmed': 'Order Confirmed Successfully',
    'reorder?': 'Do you want to reorder this order?',
    'reorder': 'Reorder',
    'order deleted': 'Order Deleted Successfully',
    'delete order?': 'Do you want to delete this order?',
    'must location on': 'Turn on location to continue',
    'foodCart':
    'Do you want to delete the current food cart and start another one?',
    'no orders': 'No previous orders',
    'will reach out to u': 'We will reach out to you soon !',
    'attention': 'Attention !',
    'details': 'Details',
    'orders':'Orders',
    'choose one':'choose one',
    'gallery':'Gallery',
    'camera':'Camera',
    'add image':'Add image',
    'last note':
    'In some cases we have to use a car instead of a bike,0.50 JD will be added to the delivery price.',
  };

  texts(String txt) {
    if (isEn) return english[txt];
    return arabic[txt];
  }

  void getLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isEn = pref.getBool('language')??false;
    notifyListeners();
  }
}
