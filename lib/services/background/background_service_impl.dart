import 'package:background_fetch/background_fetch.dart';
import 'package:fridayy_one/services/background/background_service.dart';

class BackgroundServiceImpl extends BackgroundService {
  BackgroundServiceImpl() {
    registerBackgroundService();
  }

  @override
  void registerBackgroundService() {
    BackgroundFetch.registerHeadlessTask((HeadlessTask task) async {
      final String taskId = task.taskId;
      final bool isTimeout = task.timeout;
      if (isTimeout) {
        BackgroundFetch.finish(taskId);
        return;
      }
      BackgroundFetch.finish(taskId);
    });
    initializeService();
  }

  @override
  Future<void> initializeService() async {
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE,
        ), (String taskId) async {
      // <-- Event handler
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      BackgroundFetch.finish(taskId);
    });
  }
}
