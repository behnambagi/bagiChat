import 'dart:io';

import '../utils/utils.dart';


  Future<bool> check() async {
    try{
      final response = await InternetAddress.lookup('www.google.com');
        return response.isNotEmpty && response[0].rawAddress.isNotEmpty;
    }catch(e){
      return false;
    }
  }

  Future<bool> waitForConnection() async {
    if (await check()) {
      logger.d("ping pong to google is ok");
      return true;
    } else {
      bool connected = false;
      int _flag = 4;
      while (!connected&&_flag!=0) {
        _flag -= _flag;
        await Future.delayed(const Duration(milliseconds: 5000));
        if (await check()) {
          logger.d("ping pong to google is ok");
          connected = true;
          return true;
        }
      }
      return false;
    }
  }
