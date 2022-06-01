import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task3/listdisplay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage(),
          
      );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomepageState createState()  =>_HomepageState();

}
class _HomepageState extends State<HomePage>{
  
  bool startIsPressed=true;
  bool stopIsPressed=true;
  String displayTimer='00:00:00';
  var sWatch=Stopwatch();
  final dur=const Duration(seconds: 1); 

    List<Widget>? _children;

  void initState() {
    _children = [];
  }

  void someHandler(data) {
    setState(() {
        _children!.add(Text(data));
    });
  }



  Stream<String> autoCounter() async*{
    String time= displayTimer;
    while(true){
      await Future.delayed(const Duration(seconds: 1));
      yield time=sWatch.elapsed.inHours.toString().padLeft(2,'0') +":" 
                   + (sWatch.elapsed.inMinutes % 60).toString().padLeft(2,'0') +":"
                   + (sWatch.elapsed.inSeconds % 60).toString().padLeft(2 ,'0');
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title:const Text('timer'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            stopWatch(),
            StreamBuilder<String>(
              stream: autoCounter(),
              builder: (_, snapshot) {
                // someHandler(snapshot.data);
                if(snapshot.hasError){
                  return const Text("Some thing went wrong");
                }
                 if (snapshot.data != null) {
                   Future.delayed(Duration(seconds: 5), (){
                    _children!.add(Text('timer logs'));
                   });
                   if(_children?.length ==15){
                      _children=[];
                   }else{
                    return Column(
                    children: _children!,
                  );
                   }

                 
               }
               return const Text("Starting...");
              }
            )
          ],
        ),
      ),
    );
  }

    void startTime(){
      setState(() {
        stopIsPressed=false;
      }); 
      sWatch.start();
      starTimer();
    }
    void stopTime(){

    }
    void starTimer(){
      Timer(dur, keepRunning);
    }

  @override
  Widget stopWatch(){
     return Container(
      margin: const EdgeInsets.only(top: 100),
     child: Column(
       children: [
         Container(
           child: Container(
             alignment: Alignment.center,
             child: Text(
                displayTimer,
               style: const TextStyle(
                 fontSize: 25.0 ,
                 fontWeight: FontWeight.w200,
                 color: Colors.black
               ),
             ),
           ),
         ),
         Container(
           child: Container(
           margin: const EdgeInsets.only(top:100),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: stopIsPressed ? null :stopTime ,
                        child:const Text("Stop",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                        )
                      )
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: startIsPressed ? startTime: null ,
                        child:const Text("Start",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                        )
                      )
                    ],
                  ),

                ],
             ),
           ),
         )
       ],
     ),
   );
}

  void keepRunning() {
    if(sWatch.isRunning){
      starTimer();
    }
    setState(() {
      displayTimer=sWatch.elapsed.inHours.toString().padLeft(2,'0') +":" 
                   + (sWatch.elapsed.inMinutes % 60).toString().padLeft(2,'0') +":"
                   + (sWatch.elapsed.inSeconds % 60).toString().padLeft(2 ,'0');
    });
  }
  
  Column listdisplay(list){
    return Column(
      children: [],
);
  }
}