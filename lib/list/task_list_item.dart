import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/firebase_utils.dart';
import 'package:to_do_list/list/add_task_botton_sheet.dart';
import 'package:to_do_list/model/task.dart';
import 'package:to_do_list/my_theme.dart';
import 'package:to_do_list/provider/provider.dart';

class TaskListItem extends StatefulWidget{
  Task task ;
  TaskListItem({required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: 0.40,
      // A motion is a widget used to control how the pane animates.
      motion: const ScrollMotion(),

      // All actions are defined in the children parameter.
      children:  [
      // A SlidableAction can have an icon and/or a label.
      SlidableAction(
        borderRadius: BorderRadius.circular(15),
      onPressed: (context){
          FireBaseUtils.deleteTaskFromFireSore(widget.task).
          timeout(Duration(milliseconds: 500),onTimeout: (){
            print('task deleted successfully');
           listProvider.getAllTasksFromFireStore();
          });

      },
      backgroundColor: MyTheme.redColor,
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
      ),
        SlidableAction(
          borderRadius: BorderRadius.circular(15),
          onPressed: (context){
            FireBaseUtils.editTaskToFireStore(widget.task).timeout(Duration(milliseconds: 500),
                onTimeout: (){
              print('task edit successfully');
              listProvider.getAllTasksFromFireStore();
                });

          },
          backgroundColor: MyTheme.primaryColor,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
        ),

      ],
      ),

        child:
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyTheme.whiteColor,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.12,
                width: 4,
                color: MyTheme.primaryColor,
              ),
              SizedBox(width: 15,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title ?? '' , style: Theme.of(context).textTheme.titleLarge?.copyWith(color: MyTheme.primaryColor),),
                  Text(widget.task.description ?? ''),
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10 ,
                  horizontal: 30
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyTheme.primaryColor
                ),
                child: Icon(Icons.check , size: 30, color: Colors.white,),
              ),
            ],
          ),
        ),
      ),
    );
  }



}