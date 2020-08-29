import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final items = List<String>.generate(5, (index) => "Task ${index+1}");
  final List<int> colorCode = <int>[600,500,400,300,200];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Task',style: TextStyle(fontSize: 30),)),
        backgroundColor: Colors.blue.shade900,
      ),
      body:ListView.builder(itemCount:items.length,itemBuilder: (context,index){
        final item =items[index];
        return Dismissible(
          key: Key(item),
          background: Container(
            color: Colors.green,
            child: Icon(Icons.archive,color: Colors.white,size: 30,),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Icon(Icons.delete,color: Colors.white,size: 30,),
          ),
          onDismissed: (direction){
            if(direction == DismissDirection.endToStart){
              setState(() {
                items.removeAt(index);
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.subdirectory_arrow_right,color:Colors.red,size: 30,),
                      Text('$item dismissed',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              );
            }else if(direction == DismissDirection.startToEnd){
              setState(() {
                items.removeAt(index);
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.subdirectory_arrow_right,color:Colors.red,size: 30,),
                      Text('$item archived',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              );
            }
          },
          child: Container(
            color: Colors.amber[colorCode[index]],
            child: ListTile(
              leading: Icon(Icons.event_note,color: Colors.black,size: 30,),
              title: Text(
                '${items[index]}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              trailing: Icon(Icons.star_border,color: Colors.black,size: 30,),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        );
      }),
    );
  }
}
