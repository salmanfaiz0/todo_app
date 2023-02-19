import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/todo_model.dart';

import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      guideinfo(context);
    });

    super.initState();
  }

  //  Todo LIST
  final List<Todo> _todos = [
    Todo(title: "AethAnalytic", description: "create a todo list application")
  ];
  //  Todo LIST

  int selectedIndexn = -1;

//  Controller for Title and Description
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  //  Controller for Title and Description

//  UPDATE THE TODO LIST
  _updateTodoTitle(int index, String newTitle, String newDescription) {
    setState(() {
      _todos[index].title = newTitle;
      _todos[index].description = newDescription;
    });
  }
  //  UPDATE THE TODO LIST

//  ADD ITEM - TODO LIST
  _addTodo() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        Todo todo = Todo(
            title: titleController.text,
            description: descriptionController.text);
        _todos.add(todo);
        titleController.clear();
        descriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(' Added successfully'),
          ),
        );
      });
    }
  }
  //  ADD ITEM - TODO LIST

//  REMOVE ITEM
  _removeTodoAtIndex(int index) {
    setState(() {
      _todos.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete'),
        ),
      );
    });
  }
//  REMOVE ITEM

//  TEXTFEILD WIDGET
  Widget textFeild(String txt, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        right: 20,
        left: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: txt, border: InputBorder.none),
      ),
    );
  }
//  TEXTFEILD WIDGET

// GUIDE INFORMATION
  guideinfo(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22)), //this right here
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
              ),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Iconsax.close_circle,
                            color: Colors.white,
                          )),
                    ),
                    Text("Todo Guide",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "1: Click the add symbol button\n2: Enter your title and description \n3: Click the add button\n4: Display the items",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          );
        });
  }
// GUIDE INFORMATION

// FLOATINGBUTTON - TWO TEXTFEILDS
  floatingbutton(BuildContext context, {bool isUpdate = false}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textFeild("Title", titleController),
            textFeild("Description", descriptionController),
            if (isUpdate)
              Padding(
                padding: const EdgeInsets.only(right: 17, left: 17),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 60)),
                    onPressed: () {
                      _updateTodoTitle(selectedIndexn, titleController.text,
                          descriptionController.text);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Updated'),
                        ),
                      );
                    },
                    child: Text("Update")),
              ),
            SizedBox(
              height: 10,
            ),
            if (!isUpdate)
              Padding(
                padding: const EdgeInsets.only(right: 17, left: 17),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 60)),
                    onPressed: () {
                      _addTodo();
                      Navigator.pop(context);
                    },
                    child: Text("Add")),
              ),
          ],
        );
      },
    );
  }
  // FLOATINGBUTTON - TWO TEXTFEILDS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Todo"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                guideinfo(context);
              },
              icon: const Icon(Iconsax.information5))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    // color: Colors.red,
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      )),
                ),
                key: UniqueKey(),
                // key: ValueKey(_todos[index].id),
                onDismissed: (direction) {
                  setState(() {
                    _removeTodoAtIndex(index);
                  });
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              titleController.text = _todos[index].title;
                              descriptionController.text =
                                  _todos[index].description;
                              selectedIndexn = index;
                              floatingbutton(context, isUpdate: true);
                            },
                            icon: Icon(
                              Iconsax.edit,
                              color: Colors.white,
                            )),
                        title: Text(
                          _todos[index].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        subtitle: Text(_todos[index].description,
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          floatingbutton(context);
        },
        child: Icon(Iconsax.add_circle),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
