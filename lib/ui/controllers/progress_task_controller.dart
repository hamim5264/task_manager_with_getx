import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/task_list_model.dart';
import 'package:task_manager_with_getx/data/network_caller/network_caller.dart';
import 'package:task_manager_with_getx/data/network_caller/network_response.dart';
import 'package:task_manager_with_getx/data/utility/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressInProgress => _getProgressTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTasks);
    _getProgressTaskInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
