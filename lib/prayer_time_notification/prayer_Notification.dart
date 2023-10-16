import 'package:flutter/material.dart';

import 'package:islamm786/prayer_time_notification/prayer_time_notifocation.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class PrayerNotification extends StatefulWidget {


  @override
  State<PrayerNotification> createState() => _PrayerNotificationState();
}

class _PrayerNotificationState extends State<PrayerNotification> {

  List<String> scheduledPrayers = [];

  @override
  void initState() {
    super.initState();
    loadScheduledPrayers();
  }

  Future<void> loadScheduledPrayers() async {
    final prayers = await NotificationService().getScheduledPrayerTimes();
    setState(() {
      scheduledPrayers = prayers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {

              // Schedule alarm
              await AndroidAlarmManager.periodic(
                Duration(hours: 24),
                0,
                NotificationService().backgroundTask,

                exact: true,
                wakeup: true,
              );

              // Reload scheduled prayers
              await loadScheduledPrayers();

              // Call setState
              setState(() {});

            },
            child: Text('Schedule Notifications'),
          ),

          // List scheduled prayers
          Expanded(
            child: ListView.builder(
              itemCount: scheduledPrayers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(scheduledPrayers[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}