import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:learning_awesome_notification/landing_page.dart';
import 'main.dart';

/// Notification constants for better maintainability.
class NotificationConstants {
  NotificationConstants._();

  static const String highImportanceChannelKey = 'high_importance_channel';
  static const String highImportanceChannelGroupKey =
      'high_importance_channel_group';
  static const String highImportanceChannelName = 'Basic Notification';
  static const String highImportanceChannelDescription =
      'Notification channel for learning';
  static const Color defaultColor = Colors.purple;
  static const Color ledColor = Colors.red;
}

/// A singleton service class to handle notifications throughout the app.
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final AwesomeNotifications _awesomeNotifications = AwesomeNotifications();

  /// Private constructor for singleton implementation.
  factory NotificationService() => _instance;

  NotificationService._internal();

  /// Initializes the notification service.
  Future<void> initialize() async {
    await _initializeChannels();
    await _requestNotificationPermissions();
    _setNotificationListeners();
  }

  /// Initializes notification channels and groups.
  Future<void> _initializeChannels() async {
    try {
      await _awesomeNotifications.initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey:
                NotificationConstants.highImportanceChannelGroupKey,
            channelKey: NotificationConstants.highImportanceChannelKey,
            channelName: NotificationConstants.highImportanceChannelName,
            channelDescription:
                NotificationConstants.highImportanceChannelDescription,
            defaultColor: NotificationConstants.defaultColor,
            ledColor: NotificationConstants.ledColor,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
            criticalAlerts: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey:
                NotificationConstants.highImportanceChannelGroupKey,
            channelGroupName: 'Group 1',
          )
        ],
        debug: true,
      );
    } catch (e) {
      debugPrint('Failed to initialize notification channels: $e');
    }
  }

  /// Requests permission from the user to send notifications.
  Future<void> _requestNotificationPermissions() async {
    try {
      final isAllowed = await _awesomeNotifications.isNotificationAllowed();
      if (!isAllowed) {
        await _awesomeNotifications.requestPermissionToSendNotifications();
      }
    } catch (e) {
      debugPrint('Failed to request notification permissions: $e');
    }
  }

  /// Sets up listeners for notification events.
  void _setNotificationListeners() {
    try {
      _awesomeNotifications.setListeners(
        onActionReceivedMethod: _onActionReceived,
        onNotificationDisplayedMethod: _onNotificationDisplayed,
        onNotificationCreatedMethod: _onNotificationCreated,
        onDismissActionReceivedMethod: _onDismissActionReceived,
      );
    } catch (e) {
      debugPrint('Failed to set notification listeners: $e');
    }
  }

  /// Handles when a notification action is received (e.g., notification tap).
  static Future<void> _onActionReceived(ReceivedAction receivedAction) async {
    debugPrint("Notification action received");
    final payload = receivedAction.payload ?? {};
    if (payload['navigate'] == 'true') {
      MyApp.navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => const LandingPage(),
        ),
      );
    }
  }

  /// Handles when a notification is successfully created.
  static Future<void> _onNotificationCreated(
      ReceivedNotification notification) async {
    debugPrint("Notification created");
  }

  /// Handles when a notification is displayed to the user.
  static Future<void> _onNotificationDisplayed(
      ReceivedNotification receivedAction) async {
    debugPrint("Notification displayed");
  }

  /// Handles when a notification is dismissed by the user.
  static Future<void> _onDismissActionReceived(
      ReceivedAction receivedAction) async {
    debugPrint("Notification dismissed");
  }

  /// Shows a basic notification with the given details.
  Future<void> showNotification({
    required String title,
    required String body,
    String? summary,
    Map<String, String>? payload,
    ActionType actionType = ActionType.Default,
    NotificationLayout notificationLayout = NotificationLayout.Default,
    NotificationCategory? category,
    String? bigPicture,
    List<NotificationActionButton>? actionButtons,
    bool scheduled = false,
    int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    try {
      final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: NotificationConstants.highImportanceChannelKey,
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
          payload: payload,
          bigPicture: bigPicture,
          largeIcon: bigPicture,
          backgroundColor: Colors.pink,
        ),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone: AwesomeNotifications.localTimeZoneIdentifier,
                preciseAlarm: true,
              )
            : null,
      );
    } catch (e) {
      debugPrint('Failed to show notification: $e');
    }
  }
}
