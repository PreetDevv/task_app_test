import 'package:get/get.dart';
import '../models/TaskModel.dart';

class TaskController extends GetxController {
  List<TaskModel> tasks = [];

  void addTask(String title) {
    tasks.insert(0, TaskModel(title: title));
    update();
  }

  void updateTask(int index, bool isCompletedList) {
    tasks[index].isDone = !tasks[index].isDone;

    update();
  }
}
