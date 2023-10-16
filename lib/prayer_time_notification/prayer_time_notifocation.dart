import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
// import 'package:islamic/getprayertime.dart';
// Import the alarm manager package
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';


class NotificationService {
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static final NotificationService _notificationService =
  NotificationService._internal();

  var Prayers;



  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> initializenotification() async {
    // Android Platform configuration required to send notifications
    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings('logo');
    InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> saveScheduledPrayerTime(
      DateTime prayerTime, String prayerName) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('scheduled_prayers') ?? [];

    final formattedTime = DateFormat('h:mm a').format(prayerTime);
    final notificationData = '$prayerName - $formattedTime';

    notifications.add(notificationData);
    await prefs.setStringList('scheduled_prayers', notifications);
  }

  Future<List<String>> getScheduledPrayerTimes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('scheduled_prayers') ?? [];
  }

  backgroundTask() async {



    Prayers.getPrayertimes().then((value) {
      final currenttime = DateTime.now();
      if (value.fajr!.toLocal().isAfter(currenttime)) {
        schedulePrayerTimeNotification(value.fajr!.toLocal(), 'Fajr');
        saveScheduledPrayerTime(value.fajr!.toLocal(), 'Fajr');
      }
      if (value.dhuhr!.toLocal().isAfter(currenttime)) {
        schedulePrayerTimeNotification(value.dhuhr!.toLocal(), 'Dhuhr');
        saveScheduledPrayerTime(value.dhuhr!.toLocal(), 'Dhuhr');
      }
      if (value.asr!.toLocal().isAfter(currenttime)) {
        schedulePrayerTimeNotification(value.asr!.toLocal(), 'Asr');
        saveScheduledPrayerTime(value.asr!.toLocal(), 'Asr');
      }
      if (value.maghrib!.toLocal().isAfter(currenttime)) {
        schedulePrayerTimeNotification(value.maghrib!.toLocal(), 'Maghrib');
        saveScheduledPrayerTime(value.maghrib!.toLocal(), 'Maghrib');
      }
      if (value.isha!.toLocal().isAfter(currenttime)) {
        schedulePrayerTimeNotification(value.isha!.toLocal(), 'Isha');
        saveScheduledPrayerTime(value.isha!.toLocal(), 'Isha');
      }
    });
  }

  Future<void> schedulePrayerTimeNotification(
      DateTime prayerTime, String prayerName) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: "Channel for Alarm notification",
      icon: 'codex_logo',
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('azan'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    final formattedTime = DateFormat('h:mm a').format(prayerTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      prayerName.hashCode,
      'Prayer Time',
      'It\'s time for $prayerName prayer at $formattedTime.',
      tz.TZDateTime.from(prayerTime, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true, // to show notification when the app is closed
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

