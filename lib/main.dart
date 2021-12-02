import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(),
      bottomNavigationBar: const TabBarWidget(),
    );
  }
}

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({ Key? key }) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  //top is negative
  late Animation<double> animationX;
  //right is negative
  late Animation<double> animationY;

  var selectedIndex = 0;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animationX = Tween<double>(begin: 0, end: 0).animate(controller);
    animationY = Tween<double>(begin: 0, end: 0).animate(controller);
    controller.addListener(() {
      if(controller.isCompleted){
        controller.reverse();
      }
      setState(() {});
    });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void animate(double x, double y){
    animationX = Tween<double>(begin: 0, end: x).animate(CurvedAnimation(
      parent: controller, curve: Curves.ease
    ));
    animationY = Tween<double>(begin: 0, end: y).animate(CurvedAnimation(
      parent: controller, curve: Curves.ease
    ));
    controller.forward();
  }

  void animatedLeft(){
    selectedIndex = 0;
    animate(0, 0.08);
  }

  void animatedMiddleLeft(){
    selectedIndex = 1;
    animate(0.15, 0.1);
  }

  void animatedCenter(){
    selectedIndex = 2;
    animate(-0.4, 0.0);
  }

  void animatedMiddleright(){
    selectedIndex = 3;
    animate(0.15, -0.1);
  }

  void animatedright(){
    selectedIndex = 4;
    animate(0.0, -0.08);
  }

  Color getColorIcon(int index){
    return selectedIndex == index ? Theme.of(context).primaryColor : Colors.grey.shade400;
  }

  Widget buildContainerIcon(int index, IconData icon, double width, double height){
    return Container(
        color: Colors.white,
        width: width,
        height: height,
        child: Icon(icon, color: getColorIcon(index))
    );
  }

  @override
  Widget build(BuildContext context) {
    var widthContainerIcon = MediaQuery.of(context).size.width/5-10;
    var heightContainerIcon = 50.0;
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.003)
        ..rotateX(animationX.value)
        ..rotateY(animationY.value),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: animatedLeft,
                child: buildContainerIcon(
                  0, Icons.outlined_flag, widthContainerIcon, heightContainerIcon
                )
              ),
              GestureDetector(
                onTap: animatedMiddleLeft,
                child: buildContainerIcon(
                  1, Icons.dashboard, widthContainerIcon, heightContainerIcon
                )
              ),
              GestureDetector(
                onTap: animatedCenter,
                child: buildContainerIcon(
                  2, Icons.favorite_outline_outlined, widthContainerIcon, heightContainerIcon
                )
              ),
              GestureDetector(
                onTap: animatedMiddleright,
                child: buildContainerIcon(
                  3, Icons.shop_2_outlined, widthContainerIcon, heightContainerIcon
                )
              ),
              GestureDetector(
                onTap: animatedright,
                child: buildContainerIcon(
                  4, Icons.person_outline_outlined, widthContainerIcon, heightContainerIcon
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}