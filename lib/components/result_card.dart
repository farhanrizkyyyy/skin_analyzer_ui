// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';

enum ResultCardType { overall, detail }

class ResultCard extends StatelessWidget {
  ResultCardType type;
  double overallPercentage;
  String? text;
  double detailPercentage;
  int? index;
  ResultCard({
    super.key,
    this.text,
    this.index,
    required this.type,
    this.overallPercentage = 0,
    this.detailPercentage = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ResultCardType.overall) {
      return _buildOverallResult();
    } else {
      return _buildDetailResult();
    }
  }

  Widget _buildOverallResult() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Pallete.shadow,
            offset: Offset(2, 5),
            spreadRadius: -7,
            blurRadius: 12,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          _buildOverallPercentage(),
          SizedBox(width: 24),
          Flexible(
            child: RichText(
              text: TextSpan(
                text: 'Your Overall Skin Score is ',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                children: [
                  assignColor(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailResult() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Pallete.shadow,
            offset: Offset(2, 5),
            spreadRadius: -7,
            blurRadius: 12,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        children: [
          _buildDetailPercentage(index!),
          SizedBox(height: 4),
          Flexible(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Your Overall Skin Score is ',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                children: [
                  assignColor(index: index),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailPercentage(int index) {
    var x = (detailPercentage * 100).toInt();
    late Color color;

    if (x == 100) {
      color = Pallete.green;
    } else if (x > 25) {
      color = Pallete.yellow;
    } else {
      color = Pallete.red;
    }

    return CircularPercentIndicator(
      center: Text(
        '$x',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: color,
        ),
      ),
      backgroundColor: Colors.transparent,
      progressColor: color,
      lineWidth: 10,
      radius: 27,
      percent: detailPercentage,
    );
  }

  Widget _buildOverallPercentage() {
    var x = (overallPercentage * 100).toInt();
    late Color color;

    if (x == 100) {
      color = Pallete.green;
    } else if (x > 25) {
      color = Pallete.yellow;
    } else {
      color = Pallete.red;
    }

    return CircularPercentIndicator(
      center: Text(
        '$x',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: color,
        ),
      ),
      progressColor: color,
      backgroundColor: Colors.transparent,
      lineWidth: 12,
      radius: 35,
      percent: overallPercentage,
    );
  }

  assignColor({int? index}) {
    String textResult;
    var x = (detailPercentage * 100).toInt();
    var y = (overallPercentage * 100).toInt();

    if (y == 100 || x == 100) {
      textResult = 'Perfect';
    } else if (y > 25 || x > 25) {
      textResult = 'Good';
    } else {
      textResult = 'Bad';
    }

    var result = TextSpan(
      text: textResult,
      style: TextStyle(
        color: textResult == 'Perfect'
            ? Pallete.green
            : textResult == 'Good'
                ? Pallete.yellow
                : Pallete.red,
        fontWeight: FontWeight.w700,
      ),
    );

    return result;
  }
}
