import 'dart:io' show Platform;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shamsi_date/shamsi_date.dart';

 OsUser osDeviceApp = OsUser.mobile;


final _logger = Logger(
    level: kReleaseMode ? Level.warning : Level.debug, printer: _LogPrinter());

Logger get logger => _logger;

enum ModeChart {day ,month, year}

Map<String, ModeChart> get mapModeChart => {"Day": ModeChart.day,"Month": ModeChart.month, "Year": ModeChart.year};

enum ModeTime {sec ,minute, hour}

Map<String, ModeTime> get mapModeTime => {"Second": ModeTime.sec,"Minute": ModeTime.minute, "Hour": ModeTime.hour};

enum ModelChart {line ,spline, column, bar, splineArea}

Map<String, ModelChart> get mapModelChart => {"line": ModelChart.line,"spline":
ModelChart.spline,  "bar": ModelChart.bar,"column": ModelChart.column, "splineArea": ModelChart.splineArea};



//typedef DeviceTypeAndSubtype = Tuple<int,int>;

String roomPicture(int type) => _roomPictures[type] ?? "room.jpg";

Map<int, String> _roomPictures = {
  0: "kitchen.jpg",
  1: "livingroom.jpg",
  2: "room.jpg"
};


const DEFAULT_HOST = "newdiyar.ir";
// const DEFAULT_HOST = "192.168.101.154";
int? get DEFAULT_PORT => null; // = 8801;
const String DEFAULT_PROTOCOL = "https";
String get HOST_URL => "$DEFAULT_PROTOCOL://$DEFAULT_HOST/$DEFAULT_APIS_PREFIX/";
String get HOST_URL_HOME_AMN => "$DEFAULT_PROTOCOL://$DEFAULT_HOST/";
const String DEFAULT_METHOD_CHANNEL = "channels/default";
const String DEFAULT_APIS_PREFIX = "api/v1";
const String DEFAULT_APIS_PREFIX_HOME_AMN = "api/v1";
const GEO_LOCATION_REG_EX = r"^-?\d+(\.\d+)?,-?\d+(\.\d+)?";

const String PICTURES_ASSET = 'assets/images/pictures/';
const String VECTORS_ASSET = 'assets/images/vectors/';
const String ICONS_ASSET = 'assets/images/icons/';
const String DEVICE_ASSET = 'assets/images/devices/';
const String PROFILE_ASSET = 'assets/images/profile/';
const String HOME_ASSET = 'assets/images/';
const int INVALID_ACCESS_TOKEN_STATUSCODE = 401;
const DEFAULT_RESEND_VERIFICATION_CODE_INITIAL_TIMER = 120;
const MAIN_PAGE_NESTED_NAVIGATOR_KEY = 101;
const VERIFICATION_CODE_LENGTH = 5;
const DEFAULT_LOCALE_LANGUAGE_CODE = "fa";
const DEFAULT_BRIGHTNESS = "light";
//////////////////////////type,subtype
const SENSOR_TYPE = 0;
const ACTUATOR_TYPE = 1;
// Map<String, Tuple<int, SPType>> get THINGS_TYPES =>
//     DeviceType.deviceTypes.asMap().map((key, value) => MapEntry(value.name, value.tupleType));
// Map<String, Tuple<int, SPType>> get THINGS_TYPES_RF =>
//     DeviceType.deviceTypes.where((element) => element.tupleType.value.protocol != ProtocolType.wifi).toList()
//         .asMap().map((key, value) => MapEntry(value.name, value.tupleType));

const DEFAULT_ROOM_TYPE = 0;
const OWNER_ACCESS_LEVEL = 0;
const ADMIN_ACCESS_LEVEL = 1;
const GUEST_ACCESS_LEVEL = 2;
const CUSTOM_ACCESS_LEVEL = 3;

String convertToHttps(String image)=>
    image.replaceAll("http://", "https://");


String deviceIconPathWithType(int type, int subType) =>
    "assets/images/icons/device-$type-$subType.png";

String devicePicPathWithType(int type, int subType) =>
    "assets/images/icons/device-pic-$type-$subType.png";

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

extension MaUtils<K, V> on Map<K, V> {
  K? keyOf(V v) {
    try {
      return entries.firstWhere((e) => e.value == v).key;
    } catch (e) {
      return null;
    }
  }
}

bool isIR() {
  return Get.locale == const Locale('fa');
}

Future<String> version() async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

String imageUrl(String image) {
  String port = DEFAULT_PORT == null ? "" : ":$DEFAULT_PORT";

  if(image!="room.jpg"&&image.split('/')[1]=='media') {
    return "$HOST_URL_HOME_AMN$port$image";
  }
  return "$HOST_URL_HOME_AMN${port}static/$image";
}

class _LogPrinter extends PrettyPrinter {
  @override
  List<String> log(LogEvent event) {
    if (event.level == Level.error ||
        event.level == Level.warning ||
        event.level == Level.wtf) {
      // Sentry.captureException(event.error, stackTrace: event.stackTrace);
    }
    if (event.level.index == Level.info.index) {
      // Sentry.captureMessage(event.message);
    }
    return super.
    log(event);
  }
}

String dateTimeToShamsiString(DateTime dateTime) {
  var jalali = Jalali.fromDateTime(dateTime);
  String date = jalali.toString();
  date = date.substring(7, date.length - 1).replaceAll(",", " /");
  return "$date - ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
}
//
// bool hasMemberPermission(int accessLevel, HomeMemberPermission permission) {
//   if (accessLevel == GUEST_ACCESS_LEVEL) return false;
//   return true;
// }

removeNulls(Map? map) {
  map?.removeWhere((key, value) => value == null);
}

extension MapUtils on Map {
  void removeNullEntries() => removeNulls(this);
}
//
// extension StringDotDot on String {
//   String dotDoer() => this.count;
// }


Future<OsUser?> isMobileApp()async {
  if (kIsWeb) {
    logger.d("run in web");
    osDeviceApp = OsUser.web;
    return OsUser.web;
  } else if (Platform.isLinux) {
    logger.d("run in linux");
    osDeviceApp = OsUser.linux;
    return OsUser.linux;
    } else{
    logger.d("run in mobile");
    osDeviceApp = OsUser.mobile;
    return OsUser.mobile;
    }
}

Color getColorFromHex(String? hexColor) {
  if(hexColor==null) return const Color(0xffffffff);
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
  return const Color(0xffffffff);
}

enum OsUser {web, mobile, linux}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
