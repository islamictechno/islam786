import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:islamm786/logo_screen.dart';
import 'package:provider/provider.dart';
import 'AppPrefs.dart';
import 'Screens/bottom_bar.dart';
import 'Screens/splash_screen.dart';
import 'Screens/splash_screen_2.dart';
import 'extra/audio_surah2/frontend/providers/app_provider.dart';
import 'extra/audio_surah2/frontend/providers/chapter_list_provider.dart';
import 'extra/audio_surah2/utils/route.dart';
import 'extra/jus_screen.dart';

import 'extra/surah_detail.dart';
var tokenDevice="a";
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    // 'resource://drawable/res_icon_100',
    null,
    [
      NotificationChannel(
        // channelGroupKey: "reminders",
        channelKey: "Islam786",
        channelName: "Namaz Time",
        channelDescription: "Go For Namaz",
        channelShowBadge: true,

        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        // channelGroupKey: "reminders",
        channelKey: "Islam786",
        channelName: "Namaz Time",
        channelDescription: "Go For Namaz",
        channelShowBadge: true,
        locked: true,

        importance: NotificationImportance.High,
      )
    ],
  );
  var initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  Get.put<GetStorage>(GetStorage());


  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
  // _firebaseMessaging.getToken().then((token){
  //   print("token is $token");
  //   tokenDevice=token;
  //
  // });

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppProvider(),),
          ChangeNotifierProvider(create: (context) => ChapterListProvider())
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppPrefs.setPhoneNumber('false');

    return GetMaterialApp(
      onGenerateRoute: (settings) => RouteGenerator.onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home:  SplashScreen(),
      routes: {
        JuzScreen.id:(context)=>JuzScreen(),
        Surahdetail.id:(context)=>Surahdetail(),
      },
      getPages: [
        // Get.to(()=>LogoScreen());
        GetPage(name: '/splashScreen', page: () => SplashScreen()),



      ],
    );
  }
}

