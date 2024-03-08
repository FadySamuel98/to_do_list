

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/model/my_user.dart';
import 'package:to_do_list/model/task.dart';

class FireBaseUtils{
  static CollectionReference<Task> getTasksCollection(String uId){
    return getUsersCollection().doc(uId)
        .collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: ((snapshot , options )=> Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task , _) => task.toFireStore()
    );
  }
  static Future<void> addTaskToFireStore(Task task , String uId){
    CollectionReference<Task> taskCollection = getTasksCollection(uId);//collection
      DocumentReference<Task> taskDocRef = taskCollection.doc();
      task.id = taskDocRef.id ;
       return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireSore(Task task , String uId){
     return getTasksCollection(uId).doc(task.id).delete();
  }
  static Future<void> editTaskToFireStore(Task task , String uId) {
    return getTasksCollection(uId).doc(task.id).update({

    });
  }
  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore
        .instance.collection(MyUser.collectionName).
    withConverter<MyUser>(fromFirestore: ((snapshot , options)=>MyUser.fromFireStore(snapshot.data())),
        toFirestore: (MyUser , _)=> MyUser.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser){
     return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId)async{
    var querySnapShot =await  getUsersCollection().doc(uId).get();
   return querySnapShot.data();
  }

  }

