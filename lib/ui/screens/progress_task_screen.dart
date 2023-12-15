import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_with_getx/ui/widgets/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProgressTaskController>().getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<ProgressTaskController>(
                  builder: (progressTaskController) {
                return Visibility(
                  visible:
                      progressTaskController.getProgressInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                      color: Colors.white,
                    ),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () =>
                        progressTaskController.getProgressTaskList(),
                    child: ListView.builder(
                        itemCount: progressTaskController
                                .taskListModel.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: progressTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              progressTaskController.getProgressTaskList();
                            },
                            showProgress: (inProgress) {},
                          );
                        }),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
