import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:task_management/app/app.dart';
import 'package:task_management/bootstrap.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:task_management/utils/hivePrefs/user_prefs.dart';

void main() async{
  await initializeServices();
  await bootstrap(() => const App());
}
Future<void> initializeServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  await initializeUserPrefs();
}
Future<void> initializeHive() async {
  final dir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}
Future<void> initializeUserPrefs() async {
  await UserPrefs().init();

}
