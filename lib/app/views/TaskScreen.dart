import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/TaskController.dart';
import '../widgets/TaskItem.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: GetBuilder<TaskController>(
        builder: (_) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Incomplete Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              controller.tasks.isEmpty
                  ? const Text('No task found...')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {

                        if(controller.tasks[index].isDone) return SizedBox();

                        return TaskItem(
                          key: ValueKey(controller.tasks[index].title),
                          task: controller.tasks[index],
                          onChanged: (val) => controller.updateTask(index, false),
                        );
                      },
                    ),
              const SizedBox(height: 24),
              const Text("Completed Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              controller.tasks.isEmpty
                  ? const Text('No task found...')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {

                        if(!controller.tasks[index].isDone) return SizedBox();

                        return TaskItem(
                          key: ValueKey(controller.tasks[index].title),
                          task: controller.tasks[index],
                          onChanged: (val) => controller.updateTask(index, true),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => _buildBottomSheet(controller),
          );
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBottomSheet(TaskController controller) {
    final TextEditingController textController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Add New Task", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Task Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              onPressed: () {
                if (textController.text.trim().isNotEmpty) {
                  controller.addTask(textController.text.trim());
                  Get.back();
                }
              },
              child: const Text("Add Task", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
