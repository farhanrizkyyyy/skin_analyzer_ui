// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_analyzer/components/button.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';
import 'package:skin_analyzer/configs/route.config.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<String> _imagesPath = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg'
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildBackground(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildIndicator(_imagesPath.length, _currentIndex),
              ),
              SizedBox(height: 24),
              _buildBottomSection(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _buildTitle(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: _buildCloseButton(),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return PageView.builder(
      itemCount: _imagesPath.length,
      pageSnapping: true,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Image.asset(
              _imagesPath[_currentIndex],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(.6),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIndicator(int length, int currentIndex) {
    var indicator = List<Widget>.generate(length, (index) {
      return Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: currentIndex == index ? Pallete.primary : Pallete.grey,
          shape: BoxShape.circle,
        ),
      );
    });

    return Column(
      children: [
        Text(
          'Analisa kondisi kulit kamu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Analisa kulit wajah akan membantu menentukan perawatan kulit wajah yang paling Anda butuhkan',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicator,
        ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0, left: 8),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Text(
        'Skin Analyzer',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Button(
        onPressed: () {
          Navigator.pushNamed(context, RouteConfig.survey);
        },
        text: 'Mulai sekarang',
        padding: EdgeInsets.all(10),
        prefixIcon: Icon(
          Icons.face,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
