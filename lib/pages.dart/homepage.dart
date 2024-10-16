import 'package:flutter/material.dart';
import 'package:practice/Api_Model/function.dart';
import 'package:practice/Api_Model/tasksmodel.dart';
import 'package:practice/pages.dart/createPage.dart';
import 'package:practice/utils/configs.dart';
import 'package:practice/utils/widget.dart';

Map<String, dynamic> data = {}; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   void sortTasks(List<TasksModel> tasksData , String sortMode) {
    switch (sortMode) {
      case 'priority_desc':
        tasksData.sort((a, b) => b.priority!.compareTo(a.priority!));
        break;
      case 'created_asc':
        tasksData.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        break;
      case 'created_desc':
        tasksData.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        break;
      case 'priority_asc':
        tasksData.sort((a, b) => a.priority!.compareTo(b.priority!));
        break;      
      default:
        // Handle unexpected sort modes (optional)
        print("Unknown sort mode: $sortMode");
    }
  //  setState(() {});
  }

  @override
  void initState() {
    super.initState();
    
    //  readAllTasks();
    
     // Fetch tasks on initialization
  }
    String filter = "all";
    String sort = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Tasks",
          style: TextStyle(        
          fontWeight: FontWeight.bold,
         fontSize: 30,
       ),),
       actions: [

        IconButton(onPressed: (){setState(() {
          
        });}, icon: Icon(Icons.refresh,color: Mycolor.primary,)),
        
          PopupMenuButton(
            icon: Icon(Icons.filter_alt,color: Mycolor.primary,),

            itemBuilder: (context) => [
              const PopupMenuItem(
              value : "all",
              child : Text("None"),
              ),
              const PopupMenuItem(
              value : "hp",
              child : Text("HP"),
              ),
              const PopupMenuItem(
              value : "lp",
              child : Text("LP"),
              ),

            ],
            onSelected:(value) {filter = value; setState(() {
              print(filter);
            });},

          ),
         PopupMenuButton(
            icon: Icon(Icons.sort , color: Mycolor.primary,),
            itemBuilder: (context) => [
               const PopupMenuItem(
              value : "",
              child : Text("None"),
              ),
              const PopupMenuItem(
              value : "priority_asc",
              child : Text("HP to LP "),
              ),
              const PopupMenuItem(
              value : "priority_desc",
              child : Text("LP to HP"),
              ),
              const PopupMenuItem(
              value : "created_asc",
              child : Text("Old to New"),
              ),
              const PopupMenuItem(
              value : "created_desc",
              child : Text("New to Old"),
              ),
              

            ],
            onSelected: (value ){sort = value; setState(() {
              
            }); },

          ),
        const SizedBox(width: 20,),

       ],
      ),
      backgroundColor: Mycolor.white,
      floatingActionButton: InkWell(
        onTap: (){
          goto(context , Createpage(null));
        },
        child: CircleAvatar(
          backgroundColor: Mycolor.primary,
          foregroundColor: Mycolor.white,
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
              const Row(
                 children: [
                     
                 ],
               ),
                 
               const SizedBox(height: 10.0),
               FutureBuilder<List<TasksModel>>(
              future: readAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child:  CircularProgressIndicator());
                } else if (snapshot.hasError)
                {
                  return Text('Error: ${snapshot.error}',style: const TextStyle(fontSize: 17),);
                } else if (snapshot.hasData) {
                  final tasksData = snapshot.data!;
                  print(sort.length);
                  (sort.length >=3 )?sortTasks(tasksData, sort):null;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasksData.length,
                    itemBuilder: (context, index) {
                        mytask(TasksModel task){
                          return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap:(){goto(context,Createpage(task));},
                          child: ListTile(
                            shape: RoundedRectangleBorder( // Add rounded corners
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            tileColor: Mycolor.grey, // Light grey background
                            contentPadding: const EdgeInsets.all(16.0), // Add padding
                            leading: (task.priority == 1)? const Text("HP",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),):  const Text("LP",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),), 
                            title: Text(
                              task.content ?? 'No content',
                              style: const TextStyle(fontWeight: FontWeight.bold), // Bold title
                            ),
                            subtitle: Text(
                              "Created: ${task.createdAt!.substring(0, 10)}   ${task.createdAt!.substring(11, 16)}",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min, // Compact trailing icons
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue), // Blue edit icon
                                  onPressed: () => goto(context,Createpage(task)), // Handle update button press
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red), // Red delete icon
                                  onPressed: (){
                                    try{
                                       deleteTask(task.id!); 
                                  setState(() {
                                    
                                  });
                                    }
                                    catch(e){print(e);}
                                  }, // Handle delete button press
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                   }
                                
                       TasksModel task = tasksData[index];      
                    if (filter == "all") {
      // Return all tasks
      return mytask(task);
    } else if (filter == "hp") {
      // Return tasks with priority 1 (High Priority)
      if (task.priority == 1) {
        return mytask(task);
      } else {
        return Container(); // Or any placeholder widget
      }
    } else if (filter == "lp") {
      // Return tasks with priority 0 (Low Priority)
      if (task.priority == 2) {
        return mytask(task);
      } else {
        return Container(); // Or any placeholder widget
      }
    } else {
      // Handle unexpected filter values (optional)
      print("Unknown filter: $filter");
      return Container(); // Or any placeholder widget
    }
                    
                    },
                  );
                } else {
                  return const Text('No data');
                }
              },
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

