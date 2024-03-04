import 'package:flutter/material.dart';
import 'package:to_do_list/list/add_task_botton_sheet.dart';
import 'package:to_do_list/list/list_tap.dart';
import 'package:to_do_list/setting/setting_tap.dart';

class HomeScreen extends StatefulWidget{
  static const String routeName= 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0 ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          'To Do List' , style: Theme.of(context).textTheme.titleLarge,
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex ,
        onTap: (index){
         selectedIndex = index ;
          setState(() {

          });
        },
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.list),label: ''),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: ''),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showAddTaskBottonSheet();
        },

        child: Icon(Icons.add , color: Colors.white,size: 40,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: taps[selectedIndex],
    );
  }
  List<Widget> taps=[ListTap(),SettingsTap()];

  void showAddTaskBottonSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => AddTaskBottonSheet(),
    );
  }
}