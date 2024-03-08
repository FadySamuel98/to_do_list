

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/firebase_utils.dart';
import 'package:to_do_list/model/task.dart';
import 'package:to_do_list/my_theme.dart';
import 'package:to_do_list/provider/provider.dart';


class AddTaskBottonSheet extends StatefulWidget {
  const AddTaskBottonSheet({super.key});

  @override
  State<AddTaskBottonSheet> createState() => _AddTaskBottonSheetState();
}

class _AddTaskBottonSheetState extends State<AddTaskBottonSheet> {
  var selectedDate = DateTime.now() ;
  var formKey = GlobalKey<FormState>() ;
  String title = '';
  String description = '';
  late ListProvider listProvider ;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Text('Add New Task' , style: Theme.of(context).textTheme.titleMedium,),
          Form(
            key: formKey,
              child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (text){
                  title = text ;
                },
                validator :(text){
                  if(text == null || text.isEmpty ){
                    return 'please enter task title' ;
                  }
                  return null ;
                },

                decoration: InputDecoration(
                hintText: 'Enter Task Title'
              ),),
              SizedBox(height: 15,),
              TextFormField(
                onChanged: (text){
                  description = text ;
                },
                validator: (text){
                  if(text == null || text.isEmpty){
                    return ' please enter task description';
                  }
                  return null ;
                }
                ,decoration: InputDecoration(
                  hintText: 'Enter Task description' ,
              ),
              maxLines: 4,),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.centerLeft,
                  child: Text('Select Date', style: Theme.of(context).textTheme.titleMedium,)),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  showCalender();
                },
                  child: Text('${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}' , style: Theme.of(context).textTheme.titleSmall, textAlign:TextAlign.center,)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(onPressed: (){
                    addTask();
                  },style: ElevatedButton.styleFrom(backgroundColor:MyTheme.primaryColor) ,child: Text('Add' ,style: Theme.of(context).textTheme.titleLarge,)),
                ],
              )
            ],
          )),



        ],
      ),

    );
  }

  void showCalender()async {
      var chosenDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

      if(chosenDate != null){
        selectedDate = chosenDate ;
        setState(() {

        });
      }
  }

  void addTask() {
    if(formKey.currentState?.validate() ==true){
      Task task = Task(title: title, description: description, dataTime: selectedDate);
      FireBaseUtils.addTaskToFireStore(task).timeout(Duration(milliseconds: 500),
          onTimeout:(){
        print('task add successfully');
        listProvider.getAllTasksFromFireStore();
        Navigator.pop(context);
          }
      );
    }

  }
}
