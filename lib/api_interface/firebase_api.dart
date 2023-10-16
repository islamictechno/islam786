import 'package:firebase_messaging/firebase_messaging.dart';
//
Future<void>handleBackgroundMessage(RemoteMessage message)async{
 print('Title: ${message.notification?.title}');
 print('Body: ${message.notification?.body}');
 print('PlayLoad: ${message.data}');

}
class FirebaseApi {
//
final _firbaseMessaging = FirebaseMessaging.instance;
Future<void> initNotification()async{
 await _firbaseMessaging.requestPermission();
 final fcmToken = await _firbaseMessaging.getToken();
 print("Token: $fcmToken" );
 FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
}
}
