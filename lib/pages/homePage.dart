import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_web/models/todoModel.dart';
import 'package:todo_web/pages/secondScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController;

  List<TodoModel> _todos;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: '');
    _todos = [
      TodoModel(1, "Default Todo", true),
    ];
  }

  void _addTodo(String text) {
    setState(() {
      if (text != "") {
        _todos.insert(0, TodoModel(_todos.length + 1, text.trim(), false));
      }
    });
    _textEditingController.text = "";
  }

  void _markAsDone(int index) {
    setState(() {
      _todos[index].done = !_todos[index].done;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFF6983aa),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: 384,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(),
                    ),
                  ),
                  child: Text("Second Page"),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Color(0xFF8566aa),
                  child: Center(
                    child: Text(
                      "ToDo List",
                      style: GoogleFonts.josefinSans(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: 300,
                      height: 60,
                      child: Center(
                        child: TextField(
                          controller: _textEditingController,
                          textAlign: TextAlign.center,
                          cursorColor: Color(0xFF8566aa),
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF8566aa),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF8566aa),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF8566aa),
                              ),
                            ),
                            hintText: 'Add a Item',
                            hintStyle: GoogleFonts.josefinSans(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8566aa),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      hoverColor: Colors.green,
                      onPressed: () => _addTodo(_textEditingController.text),
                      backgroundColor: Color(0xFF8566aa),
                      focusColor: Colors.black,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 350,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            IconButton(
                              color: Colors.green,
                              icon: Icon(
                                _todos[index].done
                                    ? Icons.refresh
                                    : Icons.check,
                              ),
                              onPressed: () => _markAsDone(index),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                "${_todos[index].text}",
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  decoration: _todos[index].done
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteTodo(index),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
