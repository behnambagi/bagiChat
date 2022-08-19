
import '../utils/ui/ui_util.dart';
import '../utils/utils.dart';

class ApiCallException implements Exception {
  final int statusCode;
  final String? message;
  final String? api;

  const ApiCallException(this.statusCode, {this.message, this.api});

  @override
  String toString() {
    String s = "ApiCallException|status code:$statusCode";
    if (message?.isNotEmpty ?? false) s = s + "|message:$message";
    if (api?.isNotEmpty ?? false) s = s + "|api:$api";
    return s;
  }

  static List<ApiCallException> get customApiErrors => [
        const BadRequestError(),
        const UnauthorizedError(),
        const ForbiddenError(),
        const NotFoundError(),
        const NotImplemented(),
        const InternalServerError(),
        const BadGateway(),
        const ServiceUnavailable(),
        const HTTPVersionNotSupported(),
        const GatewayTimeout(),
        const InsufficientStorage(),
        const VariantAlsoNegotiates(),
        const LoopDetected(),
        const NotExtended(),
        const NetworkAuthenticationRequired(),
      ];

  get reaction=>null;
}

class BadRequestError extends ApiCallException {
  const BadRequestError() : super(400);
  @override
  get reaction => AppSnackBar.snackBar("(400)خطای کاربر!", "شناسه دستگاه نامعتبر است");
}

class UnauthorizedError extends ApiCallException {
  const UnauthorizedError() : super(401);
  // get reaction => UiUtil.snackBar("title", "401");
}

class ForbiddenError extends ApiCallException {
  const ForbiddenError() : super(403);
  @override
  get reaction => AppSnackBar.snackBar("forbidden!(403)",
      "سرور درخواست را درک کرده است اما از اجازه دادن به آن خودداری می‌کند");
}

class NotFoundError extends ApiCallException {
  const NotFoundError() : super(404);
}

class InternalServerError extends ApiCallException {
  const InternalServerError() : super(500);
  @override
  get reaction => AppSnackBar.snackBar("(500)مشکل سرور!",
      "یک پیام خطای عمومی، زمانی که با شرایط غیرمنتظره‌ای مواجه شد و پیام خاصی مناسب نیست، داده می‌شود.");
}

class NotImplemented extends ApiCallException {
  const NotImplemented() : super(501);
  @override
  get reaction => AppSnackBar.snackBar("(501)مشکل سرور!",
      "سرور یا روش درخواست را نمی شناسد یا توانایی انجام درخواست را ندارد. معمولاً این به معنای در دسترس بودن آینده است (به عنوان مثال، ویژگی جدید یک API وب سرویس)");
}

class BadGateway extends ApiCallException {
  const BadGateway() : super(502);
  @override
  get reaction => AppSnackBar.snackBar("(502)مشکل سرور!",
      "سرور به عنوان یک دروازه یا پروکسی عمل می کرد و یک پاسخ نامعتبر از سرور بالادستی دریافت کرد");
}

class ServiceUnavailable extends ApiCallException {
  const ServiceUnavailable() : super(503);
  @override
  get reaction => AppSnackBar.snackBar("(503)مشکل سرور!",
      "سرور نمی تواند درخواست را رسیدگی کند (زیرا برای تعمیر و نگهداری بیش از حد بارگذاری شده یا از کار افتاده است). به طور کلی، این یک حالت موقت است");
}

class HTTPVersionNotSupported extends ApiCallException {
  const HTTPVersionNotSupported() : super(505);
  @override
  get reaction => AppSnackBar.snackBar("(505)مشکل سرور!",
      "سرور از نسخه پروتکل HTTP استفاده شده در درخواست پشتیبانی نمی کند");
}

class GatewayTimeout extends ApiCallException {
  const GatewayTimeout() : super(504);
  @override
  get reaction => AppSnackBar.snackBar("(504)مشکل سرور!",
      "سرور از نسخه پروتکل HTTP استفاده شده در درخواست پشتیبانی نمی کند");
}

class VariantAlsoNegotiates extends ApiCallException {
  const VariantAlsoNegotiates() : super(506);
  @override
  get reaction => AppSnackBar.snackBar("(506)مشکل سرور!",
      "مذاکره محتوای شفاف برای درخواست منجر به یک مرجع دایره ای می شود.");
}

class InsufficientStorage extends ApiCallException {
  const InsufficientStorage() : super(507);
  @override
  get reaction => AppSnackBar.snackBar("(507)مشکل سرور!",
      "سرور قادر به ذخیره نمایش مورد نیاز برای تکمیل درخواست نیست");
}

class LoopDetected extends ApiCallException {
  const LoopDetected() : super(508);
  @override
  get reaction => AppSnackBar.snackBar("(508)مشکل سرور!",
      "سرور در حین پردازش درخواست ها یک حلقه بی نهایت را شناسایی کرد");
}

class NotExtended extends ApiCallException {
  const NotExtended() : super(510);
  @override
  get reaction => AppSnackBar.snackBar("(510)مشکل سرور!",
      "پسوندهای بیشتری برای درخواست مورد نیاز است تا سرور بتواند آن را برآورده کند");
}

class NetworkAuthenticationRequired extends ApiCallException {
  const NetworkAuthenticationRequired() : super(511);
  @override
  get reaction => AppSnackBar.snackBar("(511)مشکل سرور!",
      "کلاینت برای دسترسی به شبکه نیاز به احراز هویت دارد");
}

class InvalidAccessTokenError extends ApiCallException {
  const InvalidAccessTokenError() : super(INVALID_ACCESS_TOKEN_STATUSCODE);
}
