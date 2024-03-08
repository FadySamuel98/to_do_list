class Task{
  static const String collectionName = 'tasks';
  String? id ;
  String? title ;
  String? description ;
  DateTime? dataTime;
  bool? isDone ;

  Task({
    this.id='',
    required this.title , required this.description ,  this.dataTime,
    this.isDone = false
});
  Task.fromFireStore(Map<String , dynamic> data) : this(
    id:data['id'] as String? ,
    title: data['title'] as String?,
    description:data['description'] as String? ,
    dataTime:DateTime.fromMillisecondsSinceEpoch(data['dataTime']??0),
    isDone: data['isDone'] as bool? ,
  );
 Map<String , dynamic> toFireStore(){
   return{
     'id': id ,
     'title' : title,
     'description' : description,
      'dateTime' : dataTime?.millisecondsSinceEpoch ,
     'isDone' : isDone
   };
 }
}