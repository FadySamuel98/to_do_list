import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> tasksList = [];
//  DateTime selectedDate = DateTime.now();
  void getAllTasksFromFireStore (String uId) async {
    QuerySnapshot<Task> querySnapshot = await FireBaseUtils.getTasksCollection(uId).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();

    }).toList();

    // tasksList = tasksList.where((task) {
    //   if( selectedDate.day == task.dataTime!.day &&
    //       selectedDate.year == task.dataTime!.year &&
    //       selectedDate.month == task.dataTime!.month){
    //     return true ;
    //   } return false ;
    //
    // }).toList();

    // tasksList.sort((task1 , task2){
    //   return task1.dataTime!.compareTo(task2.dataTime!);
    // });


   notifyListeners();

  }

 // void changeSelectedDate (DateTime newSelectedDate){
  //  selectedDate = newSelectedDate ;
  //  getAllTasksFromFireStore();

 // }
}