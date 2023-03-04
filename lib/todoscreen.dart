import 'package:flutter/material.dart';
import 'package:todoapp/style.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {

  List TodoList = [];
  List CompletTask =[];

  TextEditingController textEditingController = TextEditingController();

  SaveData(){
    setState(() {
      TodoList.add({"title": textEditingController.text});
    });
  }

  MyAlartDialog(index){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Notice!'),
            content: Text('Are you sure that your task is completed?'),

            actions: [
              ElevatedButton(onPressed: (){
                CompletTask.add({'title': TodoList[index]["title"].toString()});
                TodoList.removeAt(index);
                Navigator.pop(context);
                setState(() {

                });
              },
                  child: Text('Yes')),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text('No')),

            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            elevation: 0,
            title: Text('To do App'),
            bottom: TabBar(
              labelColor: Colors.black87,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), 
                topRight: Radius.circular(10)
                )
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.work),
                  text: 'Pending Task',
                ),
                Tab(
                  icon: Icon(Icons.task),
                  text: 'Completed Task',
                ),

              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: TodoList.length,
                  itemBuilder: (context, index){


                  return Card(
                    child: ListTile(
                      title: Text(TodoList[index]['title'].toString()),

                      trailing: TextButton(
                        onPressed: (){
                          MyAlartDialog(index);
                          // CompletTask.add({'title': TodoList[index]["title"].toString()});
                          // TodoList.removeAt(index);

                        },
                        child: Icon(Icons.task_alt,color: Colors.green,),
                      ),
                    ),
                  );
                  }),
              ListView.builder(
                itemCount: CompletTask.length,
                  itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      title: Text(CompletTask[index]['title'].toString()),
                      leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.done,color: Colors.white,)),
                      trailing: TextButton(
                        onPressed: (){
                          CompletTask.removeAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Task Deleted successfully')));
                          setState(() {

                          });
                        },
                        child: Icon(Icons.close,color: Colors.red,),
                      ),
                    ),
                  );
                  })
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red
                                  ),
                                  onPressed: (){
                                Navigator.pop(context);
                              },
                                  child: Icon(Icons.close)),
                              SizedBox(width: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green
                                ),
                                  onPressed: (){

                                SaveData();
                                textEditingController.clear();
                                Navigator.pop(context);
                              },
                                  child: Icon(Icons.done_outline)),

                            ],
                          ),
                          SizedBox(height: 40,),
                          TextField(
                            decoration: myfieldStyle("Add Task"),
                            controller: textEditingController,
                            maxLines: 10,
                          ),



                        ],
                      ),
                    );
                  });
            },
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.edit),
          ),

        ));
  }
}
