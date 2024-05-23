



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/provider/task_list_provider.dart';


class AddPage extends StatefulWidget {
  const AddPage({Key? key, this.todo});
  final Map? todo;
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your task has been added successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);  // This closes the AddPage
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<Taskprovider>(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: Text(
          isEdit ? 'Edit task' : 'Add task',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
           SizedBox(
            height: 20.h,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
           SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            onPressed: isEdit
                ? () {
                    final id = widget.todo!['_id'];
                    final updatedTodo = {
                      "title": titleController.text,
                      "description": descriptionController.text,
                    };
                    todoProvider.updateTodo(id, updatedTodo);
                    _showSuccessDialog(context);
                  }
                : () {
                    final newTodo = {
                      "title": titleController.text,
                      "description": descriptionController.text,
                    };
                    todoProvider.addTodo(newTodo);
                    _showSuccessDialog(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amberAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
                style:  TextStyle(fontSize: 20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




