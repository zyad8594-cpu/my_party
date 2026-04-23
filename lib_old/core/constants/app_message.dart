
// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

part of 'constants.dart';

class _Basec{ }

mixin _Short { late final String short; }
mixin _Empty { late final String empty; }
mixin _NotValide { late final String notValide; }
mixin _Error { late final String error; }
mixin _Success { late final String success;}
mixin _UnMatchPasswords{ late final String unMatch; }

class _Service extends _Basec with _Error, _Success
{
  _Service({
    String error = '',
    String success = ''
  }) {
    this.error = error;
    this.success = success;
  }
}

class _Email extends _Basec with _Empty, _NotValide
{
  _Email({
    String empty = "لا يمكن ترك حقل ال 'email' فارغا",
    String notValide = 'البريد الإلكتروني غير صالح'
  }){
    this.empty = empty;
    this.notValide = notValide;
  }
}

class _Password extends _Basec with _Empty, _NotValide, _Short, _UnMatchPasswords
{
  _Password({
    String empty = "لا يمكن ترك حقل ال 'password' فارغا",
    String notValide = 'يجب أن تحتوي كلمة المرور على أحرف كبيرة وصغيرة وأرقام وأحرف خاصة',
    String short = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
    String unMach = 'كلمتا المرور غير متطابقتين'
  }){
    this.empty = empty;
    this.notValide = notValide;
    this.short = short;
    this.unMatch = unMach;
  }
}



class Messages 
{
  
  static final _Service login = _Service(
      success: 'تم تسجيل الدخول بنجاح', 
      error: 'فشل في تسجيل الدخول',
  );

  static final _Service login_service = _Service(
    error: "في خدمة تسجيل الدخول",
  );

  static final _Service login_repository = _Service(
    error: 'خطاء في تسجيل الدخول إلى مستودع المستخدم',
  );

  static final _Email email = _Email();
  static final _Password password = _Password();

  static final _Service register = _Service(
      success: 'تم إنشاء الحساب بنجاح', 
      error: 'فشل في إنشاء الحساب',
  );
  
  static final _Service register_service = _Service(
    error: "في خدمة تسجيل الدخول",
  );

  static final _Service register_repository = _Service(
    error: "خطاء في تسجيل مستودع المستخدم",
  );


  static final _Service server = _Service(
    error: 'هناك خطاء في السيرفر'
  );

  static final _Service request = _Service(
    error: 'فشل الطلب'
  );

  static final _Service update = _Service(
    error: "خطاء في التحديث",
    success: 'تم التحديث بنجاح'
  );

  static final _Service title = _Service(
    error: 'خطأ',
    success: 'نجاح'
  );

  static final _Service getUsersRepository = _Service(
    error: 'خطأ في الحصول على المستخدمين في مستودع المستخدم'
  );

  static final _Service getUserRepositoryById = _Service(
    error: 'خطأ في الحصول على المستخدم عن طريق معرف مستودع المستخدم'
  );

  static final _Service userRepositoryUpdate = _Service(
    error: 'خطأ في تحديث مستودع المستخدم'
  );

  static final _Service userRepositoryDelete = _Service(
    error: 'خطأ في حذف مستودع المستخدم'
  );

  static final _Service fileUpload = _Service(
    error: 'فشل في تحميل الملف'
  );

  // رسائل أخطاء أخرى
  static _Service requestOf([methode]) => _Service(
    error: 'فشل في طلب ال $methode'
  );

  static _Service requestWithStatus([status = '']) => _Service(
    error: 'فشل الطلب مع الحالة: $status'
  );

  static _Service uploadWithStatus([status = '']) => _Service(
    error: 'فشل التحميل مع الحالة: $status'
  );

  static final _Service changePass= _Service(
    success: 'تم تغيير كلمة المرور بنجاح'
  );
}