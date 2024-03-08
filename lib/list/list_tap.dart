
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';

import 'package:to_do_list/list/task_list_item.dart';
import 'package:to_do_list/my_theme.dart';
import 'package:to_do_list/provider/auth_provider.dart';
import 'package:to_do_list/provider/provider.dart';

import '../model/task.dart';


class ListTap extends StatefulWidget{
  @override
  State<ListTap> createState() => _ListTapState();
}

class _ListTapState extends State<ListTap> {

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);

    if(listProvider.tasksList.isEmpty){
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }

    return Container(
      child: Column(
        children: [
          Container(
            child: EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
                  activeColor: MyTheme.primaryColor,
                  locale: "en",


            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context , index){
                  return TaskListItem(task: listProvider.tasksList[index] ,);
                },
              itemCount: listProvider.tasksList.length,
            ),
          )
        ],
      ),
    );
  }


}