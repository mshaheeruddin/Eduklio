import 'package:flutter/material.dart';

import '../../widgets/date_picker.dart';
import '../../widgets/task_title.dart';

class ClassSchedule extends StatefulWidget {
  const ClassSchedule({Key? key}) : super(key: key);

  @override
  State<ClassSchedule> createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {

  List<String> items = ['Assignment 1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              ),
              child: Column(
                children: [
                  DatePicker(),
                  TaskTitle(),
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {

    return SliverAppBar(
      expandedHeight: 90,
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 20,
      ),
      actions: [
        Icon (
          Icons.more_vert,
          size: 40
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Schedule',
                style:TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Manage Your daily scheduling',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green
                ),
              ),
            ],
          )
      )
    );

  }

}