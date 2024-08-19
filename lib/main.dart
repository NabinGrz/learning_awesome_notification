import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:learning_awesome_notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "Basic Notification",
                  body: "This is a Basic Notification",
                );
              },
              label: const Text("Default Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "Basic Notification",
                  body: "This is a Basic Notification",
                  summary: "This is Basic Summary",
                  notificationLayout: NotificationLayout.Inbox,
                );
              },
              label: const Text("Notification With Summary"),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await showNotification(
                  title: "Basic Notification",
                  body: "This is a Basic Notification",
                  summary: "This is Basic Summary",
                  notificationLayout: NotificationLayout.BigPicture,
                  bigPicture:
                      "https://i0.wp.com/devhq.in/wp-content/uploads/2024/07/2.png?w=1280&ssl=1",
                );
              },
              label: const Text("BigPicture Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "Action noti",
                  body: "This is a Action",
                  payload: {
                    "navigate": "true",
                  },
                  actionButtons: [
                    NotificationActionButton(
                      key: 'demo',
                      label: "Demo Page",
                      actionType: ActionType.SilentAction,
                      color: Colors.deepPurple,
                    )
                  ],
                );
              },
              label: const Text("Action Button Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "Big Text Notification",
                  body: "This is Big Text",
                  notificationLayout: NotificationLayout.BigText,
                );
              },
              label: const Text("BigText Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "Song Downloading",
                  body: "Please wait",
                  notificationLayout: NotificationLayout.ProgressBar,
                );
              },
              label: const Text("ProgressBar Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "Nitish Kumar",
                  body: "Hello What are you doing",
                  notificationLayout: NotificationLayout.Messaging,
                );
              },
              label: const Text("Messaging Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "Nitish Kumar",
                  body: "Hello What are you doing",
                  notificationLayout: NotificationLayout.MessagingGroup,
                );
              },
              label: const Text("Messaging Group Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "New song playing",
                  body: "Arjit ",
                  notificationLayout: NotificationLayout.MediaPlayer,
                );
              },
              label: const Text("MediaPlayer Notification"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showNotification(
                  title: "New song playing",
                  body: "Arjit ",
                  notificationLayout: NotificationLayout.MediaPlayer,
                );
              },
              label: const Text("MediaPlayer Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
