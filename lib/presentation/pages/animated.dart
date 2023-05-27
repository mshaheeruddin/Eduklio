import 'package:flutter/cupertino.dart';

class CustomerDrawerState extends StatefulWidget {
  const CustomerDrawerState({Key? key}) : super(key: key);

  @override
  State<CustomerDrawerState> createState() => _CustomerDrawerStateState();
}

class _CustomerDrawerStateState extends State<CustomerDrawerState> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(color: Color.fromRGBO(48, 15, 187, 1.0));
    var myChild = Container(color: Color.fromRGBO(252, 191, 0, 1.0));

    return Directionality(
      textDirection: TextDirection.ltr, // or TextDirection.rtl, depending on your app's language
      child: Stack(
        children: [
          Transform(
              transform: Matrix4.identity()..scale(0.5),
              alignment: Alignment.centerLeft,
              child: myChild),
          myDrawer,
        ],
      ),
    );
  }
}