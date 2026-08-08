import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Backend/Api/api_service.dart';
import 'Providers/detail_provider.dart';
import 'Providers/episode_provider.dart';
import 'Providers/home_provider.dart';
import 'Providers/server_provider.dart';
import 'Providers/stream_provider.dart';
import 'Providers/genre_provider.dart';
import 'Screens/homepage.dart';
import 'Screens/explorepage.dart';
import 'Widgets/bottom_nav.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> initFirebase() async {
  await Firebase.initializeApp();
}

Future<void> initAwesomeNotifications() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/img',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for app updates',
        defaultColor: Colors.black,
        ledColor: Colors.orange,
        playSound: true,
        soundSource: 'resource://raw/pikachu', // Custom sound from res/raw (without extension)
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
    debug: true,
  );
  bool allowed = await AwesomeNotifications().isNotificationAllowed();
  if (!allowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}

Future<void> initMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(alert: true, badge: true, sound: true);
  await messaging.getToken();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notification.hashCode,
          channelKey: 'basic_channel',
          title: notification.title,
          body: notification.body,
          payload: {'redirect': '/'},
        ),
      );
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    navigatorKey.currentState?.pushNamed('/');
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize API Service with saved provider
  final prefs = await SharedPreferences.getInstance();
  final savedProvider = prefs.getString('selectedProvider') ?? 'brainudeu';
  final provider = AnimeProvider.values.firstWhere(
    (p) => p.toString().split('.').last == savedProvider,
    orElse: () => AnimeProvider.brainudeu,
  );
  ApiService.setProvider(provider);
  
  await initFirebase();
  await initAwesomeNotifications();
  await initMessaging();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => DetailProvider()),
        ChangeNotifierProvider(create: (context) => EpisodeProvider()),
        ChangeNotifierProvider(create: (context) => ServerProvider()),
        ChangeNotifierProvider(create: (context) => StreamingProvider()),
        ChangeNotifierProvider(create: (context) => GenreProvider()),
      ],
      child: const AnimeApp(),
    ),
  );
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const NavigationWrapper(),
        '/page1': (context) => const ExplorePage(),
        '/page2': (context) => const AnimeHomeScreen(),
      },
    );
  }
}
