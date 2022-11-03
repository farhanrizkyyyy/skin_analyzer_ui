// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_analyzer/components/button.dart';
import 'package:skin_analyzer/components/survey.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';
import 'package:skin_analyzer/configs/route.config.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final List<bool> _barStatus = [true, false, false, false, false];
  final List<List<String>> _chipTitles = [
    ['Normal', 'Kering', 'Berminyak', 'Sensitif', 'Kombinasi'],
    [
      'Garis halus & kerutan',
      'Kulit kusam',
      'Kemerahan',
      'Pori-pori besar',
      'Pigmentasi',
      'Kulit mengendur',
      'Noda kulit',
      'Mata bengkak',
      'Dark spots'
    ],
    ['18-24 Tahun', '25-34 Tahun', '35-44 Tahun', '45-54 Tahun', '55+ Tahun'],
    [''],
  ];
  final List<String> _surveyTitle = [
    '',
    'Bagaimana kondisi kulit kamu?',
    'Apa masalah utama kulit kamu?',
    'Berapa umur kamu?',
    'Dimana lokasi anda sering menghabiskan waktu?'
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBars(),
                _buildSurveyContent(),
              ],
            ),
          ),
          Builder(builder: (context) {
            if (_currentIndex == _barStatus.length - 1) {
              return _buildSelfieButton();
            } else {
              return _buildButtons();
            }
          })
        ],
      ),
    );
  }

  Widget _buildSurveyContent() {
    return Builder(builder: (context) {
      if (_currentIndex != _barStatus.length - 1) {
        List<bool> chipValue = [];
        for (int i = 0; i < _chipTitles[_currentIndex].length; i++) {
          chipValue.insert(i, false);
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: FadeTransition(
            opacity: _animation,
            child: Survey(
              currentIndex: _currentIndex,
              title: _surveyTitle[_currentIndex + 1],
              chipText: _chipTitles[_currentIndex],
              isSelected: chipValue,
            ),
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: _buildSelfie(),
        );
      }
    });
  }

  Widget _buildSelfie() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ambil foto selfie anda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Berikan foto selfie terbaik anda',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Pallete.textDescription,
            ),
          ),
          SizedBox(height: 70),
          Image.asset(
            'assets/selfie.png',
            width: 220,
          ),
          SizedBox(height: 30),
          Text(
            'Untuk hasil yang maksimal pastikan anda berada di tempat dengan pencahayaan yang cukup',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Pallete.textDescription,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar({required bool isActive}) {
    return Container(
      width: MediaQuery.of(context).size.width / 6.2,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Pallete.primary : Pallete.disabled,
        borderRadius: BorderRadius.circular(60),
      ),
    );
  }

  Widget _buildBars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_barStatus.length, (index) {
        return _buildBar(
          isActive: _barStatus[index],
        );
      }),
    );
  }

  Widget _buildSelfieButton() {
    return Button(
      text: 'Ambil foto',
      onPressed: () => Navigator.pushNamed(context, RouteConfig.selfie),
      prefixIcon: Icon(
        Icons.camera_alt,
        size: 20,
        color: Colors.white,
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Flexible(
          child: Button(
            onPressed: () {
              setState(() {
                if (_currentIndex != 0) {
                  setState(() {
                    _animationController.repeat();
                    _currentIndex -= 1;
                    _barStatus[_currentIndex + 1] = false;
                    // log('CURRENT INDEX: $_currentIndex');
                  });
                } else {
                  Navigator.pop(context);
                }
              });
            },
            text: _currentIndex != 0 ? 'Kembali' : 'Batalkan',
            isBackgroundFilled: false,
          ),
        ),
        SizedBox(width: 16),
        Flexible(
          child: Button(
            onPressed: () {
              setState(() {
                if (_currentIndex != _barStatus.length - 1) {
                  setState(() {
                    _animationController.repeat();
                    _currentIndex += 1;
                    _barStatus[_currentIndex] = true;
                    // log('CURRENT INDEX: $_currentIndex');
                  });
                }
              });
            },
            text: 'Lanjutkan',
          ),
        ),
      ],
    );
  }
}
