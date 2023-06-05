import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final weekList = ['Sun','Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  List<int> weekDayIndex = [0,0,0,0,0,0,0];
  final dayList = ['24', '25', '26', '27', '28','29', '30'];
  String dateTime = DateTime.now().day.toString();
  var selected = 4;

  void _populateDayList() {
 /*   int day = DateTime.now().weekday;

    switch (day) {
      case 1:
        weekDayIndex[0] = day - 1;
        break;
      case 2:
        weekDayIndex[1] = day-1;
        break;
      case 3:
        weekDayIndex[2] = day-1;
        break;
      case 4:
        weekDayIndex[3] = day-1;
        break;
      case 5:
        weekDayIndex[4] = day-1;
        break;
      case 6:
        weekDayIndex[5] = day-1;
        break;
      case 7:
        weekDayIndex[6] = day-1;
        break;
      default:
        print('Unknown cart operation');
        break;
    }*/
       log(weekDayIndex.toString());
        for (int i = 0; i< weekList.length; i++) {
            dayList[DateTime.now().weekday - i -1] = (int.parse(dateTime) + i).toString();
        }
       /*for (int i = 0; i< weekList.length; i++) {
         dayList[weekList.length - i - 1] = dayList[i];
         log('${dayList[weekList.length - i - 1]} -------> ${dayList[i]}');
       }*/
      /* [log] 10 -------> 10
    [log] 9 -------> 9
    [log] 8 -------> 8
    [log] 7 -------> 7
    [log] 8 -------> 8
    [log] 9 -------> 9
    [log] 10 -------> 10*/

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _populateDayList();
  }


  @override
  Widget build(BuildContext context) {





    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),

     child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => setState(() => selected = index),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == index ? Colors.grey.withOpacity(0.1) : null

              ),
              child: Column(
                children: [
                  Text(weekList[index],
                      style: TextStyle(
                        color: selected == index ? Colors.black : Colors.grey
                      ),
                  ),

                  SizedBox(height: 5),

                  Text(dayList[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selected == index ? Colors.black : Colors.grey
                    ),)
                ],
              ),
            ),
          ),
          separatorBuilder: (_, index) => SizedBox(width: 5,),
          itemCount: weekList.length) ,
    );
  }
}
