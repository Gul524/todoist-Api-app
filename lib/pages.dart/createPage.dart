import 'package:flutter/material.dart';
import 'package:practice/Api_Model/function.dart';
import 'package:practice/Api_Model/tasksmodel.dart';
import 'package:practice/utils/configs.dart';
 import 'package:practice/utils/widget.dart';

class Createpage extends StatelessWidget {
  TasksModel? edittask ;
   Createpage(this.edittask);

TextEditingController name = TextEditingController();
TextEditingController description = TextEditingController();
int priorty = 1;

  @override
  Widget build(BuildContext context) {  
    if(edittask != null){
      name.text = edittask!.content!.toString();
      description.text = edittask!.description!.toString();
      priorty = edittask!.priority!;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mycolor.scaffoldBgColor,
        title: const Text("Create Task"),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Mycolor.primary,)),
        automaticallyImplyLeading: true,
        actions: [
           IconButton(onPressed: ()async{
              TasksModel newtask = TasksModel(
                content: name.text.toString(),
                priority: priorty,
                description: description.text.toString(),
               );
               try{
                  await createTask(newtask);
                  Navigator.pop(context);
               }
               catch(error){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error : $error"),));
               }
               

           }, icon: const Icon(Icons.check) , color : Mycolor.primary),

        ],
      ),
      backgroundColor: Mycolor.scaffoldBgColor,
      body: SafeArea(
        child:SingleChildScrollView(
          child: 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                 priortyselect(priority: priorty,),
                 const SizedBox(height: 10,),
                 MyTextField(hintText: "Title", controller: name ),
                 const SizedBox(height: 10,),
                 MyTextField(hintText: "Description", controller: description),
            
            
              ],
            ),
          ),
        )
      ),
    );
  }
}
   
class priortyselect extends StatefulWidget {
   int? priority;

   priortyselect({super.key, this.priority });

  @override
  State<priortyselect> createState() => _priortyselectState();
}

class _priortyselectState extends State<priortyselect> {
  @override
  Widget build(BuildContext context) {
    return  Row(
             mainAxisAlignment: MainAxisAlignment.end,
           children: [
           ElevatedButton(
          onPressed: () { setState(() {
            widget.priority = 1;
          });},
          style: ElevatedButton.styleFrom(
            foregroundColor: Mycolor.white, 
            backgroundColor: widget.priority == 1 ? Mycolor.primary : Mycolor.grey,
            elevation: 1,
          ),
          child: Text('High Priority'),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {setState(() {
            widget.priority = 2;
          });},
          style: ElevatedButton.styleFrom(
            foregroundColor: Mycolor.white,
             backgroundColor: widget.priority == 2 ? Colors.red : Mycolor.grey,
            elevation: 1,
          ),
          child: Text('Low Priority'),
        ),
       const SizedBox(width: 10,),

                      //MyPopupMenu(tostore: priorty,),
     ],
    );
  }
}