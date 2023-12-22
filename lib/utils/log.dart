import 'dart:developer';

class Log{
  static  void printError({required Object error, required String filename}){
    log( filename,error: error,name: "ERROR",);
  }
  static void printInfo({required String filename, required String info}){
    log(filename, error: info, name: "INFO");
  }
}