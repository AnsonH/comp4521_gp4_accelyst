import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';

/// A utility class to provide notification services.
///
/// It uses [awesome_notifications](https://pub.dev/packages/awesome_notifications) under the hood
/// to manage notifications.
class NotificationService {
  /// Initialize the AwesomeNotifications plugin.
  ///
  /// Call this function in `main()` before `runApp()` in `main.dart`.
  static void initialize() {
    // Stored in android/app/src/main/res/drawable/res_app_icon.png
    const icon = "resource://drawable/res_app_icon";

    // A notification channel is like a group of notifications that share the same properties
    // (e.g. priority level, alert sound, etc.). With notification channels, users have the
    // flexibility to choose what type of notifications they wish to receive. For example, they
    // can set to only receive Todo notifications but not Timer notifications via the app settings.
    //
    // Read more: https://developer.android.com/training/notify-user/channels
    final notificationChannels = <NotificationChannel>[
      NotificationChannel(
        channelKey: NotificationChannelKey.timer,
        channelName: "Timer Notifications",
        channelDescription: "Notifications for the study timer page.",
        defaultColor: primaryColor,
        importance: NotificationImportance.High,
        locked: true,
        soundSource: "resource://raw/res_timer_notification", // Custom sound
      ),
      NotificationChannel(
        channelKey: NotificationChannelKey.todo,
        channelName: "To-dos Notifications",
        channelDescription: "Notifications for to-do tasks.",
        defaultColor: primaryColor,
        importance: NotificationImportance.High,
        locked: true,
        channelShowBadge: true, // Show badge at app icon
        soundSource: "resource://raw/res_todo_notification", // Custom sound
      ),
    ];

    AwesomeNotifications().initialize(icon, notificationChannels);
  }

  /// Add a listener for user actions.
  ///
  /// [callback] is run automatically when the user taps on the notification, or taps on any action
  /// buttons if any.
  static void listenActions(
    void Function(ReceivedNotification notification) callback,
  ) {
    AwesomeNotifications().actionStream.listen(callback);
  }

  /// Creates a notification.
  ///
  /// For [channelKey], you should use a constant from the [NotificationChannelKey] class.
  ///
  /// [payload] lets you store extra info related to this notification in the form of key-value
  /// pairs. These info are hidden from user view.
  static void createNotification({
    required String channelKey,
    String? title,
    String? body,
    Map<String, String>? payload,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: channelKey,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }

  /// Disposes resources consumed by this service to avoid memory leaks.
  static void dispose() {
    AwesomeNotifications().createdSink.close();
    AwesomeNotifications().dismissedSink.close();
    AwesomeNotifications().displayedSink.close();
    AwesomeNotifications().actionSink.close();
  }
}

/// Keys to identify different notification channels.
///
/// A channel key is required (via the `channelKey` argument) to identify the notification channel when
/// we create it. Later when we create a new notification, we can use the channel key to specify which
/// channel should the notification be assigned to.
class NotificationChannelKey {
  static const timer = "timer_channel";
  static const todo = "todo_channel";
}

/// Creates a random unique integer ID.
int createUniqueId() {
  return Random().nextInt(999999999);
}
