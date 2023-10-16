
import 'package:audioplayers/audioplayers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/app_utils/text_utils.dart';

import 'package:timezone/timezone.dart' as tz;


import '../../../../../main.dart';
import '../../../alarm_helper.dart';
import '../../data/models/alarm_info.dart';
import '../../data/theme_data.dart';
class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  Future<void> playAudio(String filePath) async {
    int result = await audioPlayer.play(filePath, isLocal: true);
    if (result == 1) {
      selectedAudio;
      audioPlayer.playerId.toString();
    }
  }
  TextUtils _textUtils = TextUtils();
  DateTime? _alarmTime;
  late String _alarmTimeString;
  bool _isRepeatSelected = false;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  final List<String> audioList = ["assets/audio/azan.mp3", "assets/audio/alarm_clock 1.mp3",
    "assets/audio/alarm_clock 2.mp3","assets/audio/alarm_clock 3.mp3","assets/audio/alarm_clock 4.mp3"];

  AudioPlayer audioPlayer = AudioPlayer();
  String? selectedAudio;

  String? selectedValue;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        // actions: [
        //   InkWell(
        //       onTap: (){
        //         Get.to(()=>AlarmManagerExampleApp());
        //       },
        //       child: Icon(Icons.alarm,))
        // ],
        backgroundColor: arabicColor,
        leading: InkWell(onTap:(){
          Get.back();
        },child: Icon(Icons.arrow_back_ios,size:16 ,color: Colors.white,)),
        title:
            _textUtils.medium("Set Reminder", whiteColor, 18.0, TextAlign.center),
        // Text(
        //   'Set  Namaz  Reminder',
        //   style:
        //   TextStyle(fontFamily: 'AlQalamQuran', fontWeight: FontWeight.w700, color: Colors.white, fontSize: 24),
        // ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<List<AlarmInfo>>(
                future: _alarms,

                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _currentAlarms = snapshot.data;
                    return ListView(
                      children: snapshot.data!.map<Widget>((alarm) {
                        var alarmTime = DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                        var gradientColor = GradientTemplate.gradientTemplate[alarm.gradientColorIndex!].colors;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: gradientColor.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.label,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        alarm.title!,
                                        style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    onChanged: (bool value) {},
                                    value: true,
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                              const Text(
                                'Mon-Fri',
                                style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    alarmTime,
                                    style: const TextStyle(
                                        color: Colors.white, fontFamily: 'avenir', fontSize: 24, fontWeight: FontWeight.w700),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.white,
                                      onPressed: () {
                                        deleteAlarm(alarm.id);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).followedBy([
                        if (_currentAlarms!.length <6)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: arabicColor,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: InkWell(
                              onTap: (){
                                _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Container(
                                          padding: const EdgeInsets.all(32),
                                          child: Column(
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  var selectedTime = await showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay.now(),
                                                  );
                                                  if (selectedTime != null) {
                                                    final now = DateTime.now();
                                                    var selectedDateTime = DateTime(
                                                        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                                                    _alarmTime = selectedDateTime;
                                                    setModalState(() {
                                                      _alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  _alarmTimeString,
                                                  style: TextStyle(fontSize: 32),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text('Repeat'),
                                                trailing: Switch(
                                                  onChanged: (value) {
                                                    setModalState(() {
                                                      _isRepeatSelected = value;
                                                    });
                                                  },
                                                  value: _isRepeatSelected,
                                                ),
                                              ),
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,

                                                  hint: const Text(
                                                    'Sound',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  items:  audioList.map((String audio) {
                                                    return DropdownMenuItem<String>(
                                                      value: audio,
                                                      child: Text(audio),
                                                    );
                                                  }).toList(),
                                                  value: selectedAudio,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      selectedAudio = value;
                                                      playAudio(selectedAudio!);
                                                      audioPlayer.seek(selectedAudio as Duration);
                                                      audioPlayer.play(selectedAudio!);

                                                    });
                                                  },
                                                  buttonStyleData: const ButtonStyleData(
                                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                                    height: 40,
                                                    width: 350,
                                                  ),
                                                  menuItemStyleData: const MenuItemStyleData(
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              // ListTile(
                                              //   onTap:(){
                                              //
                                              //   },
                                              //   title: Text('Sound'),
                                              //   trailing: Icon(Icons.arrow_forward_ios),
                                              // ),
                                              const ListTile(
                                                title: Text('Title'),
                                                trailing: Icon(Icons.arrow_forward_ios),
                                              ),
                                              FloatingActionButton.extended(
                                                onPressed: () {

                                                  setState(() {
                                                    onSaveAlarm(_isRepeatSelected);
                                                    loadAlarms();
                                                  });
                                                },
                                                icon: Icon(Icons.alarm),
                                                label: Text('Save'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                                // scheduleAlarm();
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.alarm,color: Colors.white,),
                                  SizedBox(height: 4),
                                  Text(
                                    'Add Alarm',
                                    style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Center(
                              child: Text(
                                'Only 7 alarms allowed!',
                                style: TextStyle(color: Colors.white),
                              )),
                      ]).toList(),
                    );
                  }
                  return Center(
                    child: Text(
                      'Loading..',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo, {required bool isRepeating}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('azan'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'azan.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (isRepeating)
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Alaram',
        alarmInfo.title,
        Time(
          scheduledNotificationDateTime.hour,
          scheduledNotificationDateTime.minute,
          scheduledNotificationDateTime.second,
        ),
        platformChannelSpecifics,
      );
    else
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        alarmInfo.title,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
  }

  void onSaveAlarm(bool _isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      scheduleAlarm(scheduleAlarmDateTime, alarmInfo, isRepeating: _isRepeating);
    }
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
