import 'package:flutter/material.dart';

class EmployeeTaskPage extends StatefulWidget {
  const EmployeeTaskPage({Key? key}) : super(key: key);

  @override
  State<EmployeeTaskPage> createState() => _EmployeeTaskPageState();
}

class _EmployeeTaskPageState extends State<EmployeeTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      // StreamBuilder(
      //   stream: ,
      //   builder: (context, AsyncSnapshot<dynamic> tasks){
      //
      //     if(tasks.connectionState == ConnectionState.waiting){
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }else if(tasks.hasError){
      //       return const Center(
      //         child: Text('Your tasks have not been loaded check your connection or try again'),
      //       );
      //     }else if(tasks.hasData){
      //       return
      //     }
      //
      //   },
      // )
    );
  }
}
