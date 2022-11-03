// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';
import 'package:skin_analyzer/configs/route.config.dart';
import 'package:skin_analyzer/pages/arguments/result%20_page_argument.dart';

class ProcessingPage extends StatefulWidget {
  ResultPageArgument? argument;
  ProcessingPage({
    this.argument,
    super.key,
  });

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -.15),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticInOut,
      ),
    );
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacementNamed(
        context,
        RouteConfig.result,
        arguments: ResultPageArgument(imagePath: widget.argument!.imagePath),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Pallete.primary,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            SlideTransition(
              position: _animation,
              // duration: Duration(milliseconds: 500),
              // bottom: 20,
              child: Image.asset(
                'assets/processing.png',
                width: 230,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Mohon tunggu beberapa saat..\nSim salabimabracadabra!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
