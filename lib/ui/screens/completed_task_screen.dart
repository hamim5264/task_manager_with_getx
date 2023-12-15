import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/completed_task_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_with_getx/ui/widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CompletedTaskController>().getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<CompletedTaskController>(
                  builder: (completedTaskController) {
                return Visibility(
                  visible: completedTaskController.getCompletedTaskInProgress ==
                      false,
                  replacement: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                      color: Colors.white,
                    ),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () =>
                        completedTaskController.getCompletedTaskList(),
                    child: ListView.builder(
                        itemCount: completedTaskController
                                .taskListModel.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: completedTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              completedTaskController.getCompletedTaskList();
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
