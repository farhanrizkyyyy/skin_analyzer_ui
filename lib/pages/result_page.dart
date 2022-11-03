// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_analyzer/components/result_card.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';
import 'package:skin_analyzer/pages/arguments/result%20_page_argument.dart';

class ResultPage extends StatefulWidget {
  ResultPageArgument? argument;
  ResultPage({
    this.argument,
    super.key,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  final List<double> _detailPercentages = [.25, .75, .75, 1];

  @override
  void initState() {
    log(widget.argument!.imagePath);
    super.initState();
  }

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
        Stack(
          children: [
            Transform.scale(
              scaleX: -1,
              child: Image.file(
                File(widget.argument!.imagePath),
              ),
            ),
            Positioned(
              top: 40,
              left: 24,
              child: _buildCloseButton(),
            ),
            Positioned(
              top: 40,
              right: 24,
              child: _buildShareButton(),
            ),
          ],
        ),
        _buildBottomSheet(),
      ],
    );
  }

  Widget _buildBottomSheet() {
    return DraggableScrollableSheet(
      initialChildSize: .25,
      minChildSize: .15,
      builder: (context, scrollController) {
        return _buildBottomSheetContent(scrollController);
      },
    );
  }

  Widget _buildBottomSheetContent(ScrollController scrollController) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Pallete.grey,
              ),
            ),
            SizedBox(height: 16),
            ResultCard(
              type: ResultCardType.overall,
              overallPercentage: .79,
            ),
            SizedBox(height: 10),
            Flexible(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(_detailPercentages.length, (index) {
                  return ResultCard(
                    type: ResultCardType.detail,
                    index: index,
                    detailPercentage: _detailPercentages[index],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_left_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildShareButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.share,
          size: 21,
          color: Colors.white,
        ),
      ),
    );
  }
}
