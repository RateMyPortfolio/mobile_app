// import 'dart:convert';
// import 'dart:developer';
// import 'package:dancyflix/view/Home/BottomNavBarScreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class PushNotificationService {
//   static final PushNotificationService _notificationService = PushNotificationService._internal();
//
//   factory PushNotificationService() {
//     return _notificationService;
//   }
//
//   PushNotificationService._internal();
//
//   late FirebaseMessaging _messaging;
//   int id = 0;
//
//   // PushNotification _notificationInfo;
//   bool _initialized = false;
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//     setupFlutterNotifications();
//     if (!_initialized) {
//       registerNotification();
//       _initialized = true;
//     }
//   }
//
//   late AndroidNotificationChannel channel;
//
//   Future<void> setupFlutterNotifications() async {
//
//     channel = const AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'Dancyflix', // title
//         description: 'This channel is used for important notifications.', // description
//         importance: Importance.high,
//         playSound: true,
//         showBadge: true);
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   ///*
//   ///
//   ///
//   Future<void> registerLocalNotification(RemoteMessage message) async {
//     AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//     InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});
//   }
//
//   ///*
//   ///
//   ///
//
//   ///*
//   ///
//   ///
//   void registerNotification() async {
//     await Firebase.initializeApp();
//     _messaging = FirebaseMessaging.instance;
//
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//         log("message_Data: " + message.data.toString());
//         print('Message notification: ${message.notification.toString()}, data: ${message.data}');
//         // print(">>>>${message.notification!.title}>>>>${message.notification!.body}");
//         registerLocalNotification(message);
//         // if (message.notification != null) {
//           showNotification(message, 'high_importance_channel');
//         // }
//       });
//       tapNatiFicationAppBackground();
//       tapNotificationAppKilled();
//     } else {
//       print('User declined');
//     }
//   }
//
//   Future<void> showNotification(RemoteMessage message, String channelId) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics;
//           androidPlatformChannelSpecifics = AndroidNotificationDetails(channelId, 'Dancyflix',
//               importance: Importance.high,
//               priority: Priority.high,
//               ticker: 'ticker',
//               playSound: true);
//
//
//     DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);
//     NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosPlatformChannelSpecifics);
//     // if (Platform.isAndroid) {
//
//       await flutterLocalNotificationsPlugin.show(
//         id++,
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         platformChannelSpecifics, /*payload: payload*/
//       );
//
//
//     // }
//   }
//
//   @override
//   void dispose() {
//     _initialized = false;
//   }
//
//   ///*
//   ///
//   /// tap notification when app foreground
//   Future selectNotification(String payload) async {
//     print('LocalNotification Payload : ${payload}');
//   }
//
//   ///*
//   ///
//   ///
//   void tapNotificationAppKilled() {
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
//       if (message != null) {
//         Navigator.pushAndRemoveUntil(
//           Get.context!,
//           MaterialPageRoute(builder: (BuildContext context) => BottomNavBarScreen()),
//               (route) => false,
//         );
//         print('on click : ');
//       }
//     });
//   }
//
//   void tapNatiFicationAppBackground() async {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       Navigator.pushAndRemoveUntil(
//         Get.context!,
//         MaterialPageRoute(builder: (BuildContext context) => BottomNavBarScreen()),
//             (route) => false,
//       );
//     });
//   }
// }