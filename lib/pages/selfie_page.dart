// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';
import 'package:skin_analyzer/configs/route.config.dart';
import 'package:skin_analyzer/main.dart';
import 'package:skin_analyzer/pages/arguments/result%20_page_argument.dart';

class SelfiePage extends StatefulWidget {
  const SelfiePage({super.key});

  @override
  State<SelfiePage> createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage> with WidgetsBindingObserver {
  bool _isCameraInitialized = false;
  final CameraController _cameraController = CameraController(
    cameras[1],
    ResolutionPreset.high,
    imageFormatGroup: ImageFormatGroup.jpeg,
  );

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isCameraInitialized) {
      return _buildCameraPreview();
    } else {
      return Container();
    }
  }

  Widget _buildCameraPreview() {
    return Stack(
      children: [
        Center(
          child: CameraPreview(_cameraController),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: 100.0),
            child: _buildShape(),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: _buildCameraShutter(),
          ),
        ),
        Positioned(
          top: 40,
          left: 24,
          child: _buildCloseButton(),
        ),
      ],
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
          Icons.close_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCameraShutter() {
    return GestureDetector(
      onTap: () async {
        final image = await _cameraController.takePicture();
        log(image.path);
        Navigator.pushNamed(
          context,
          RouteConfig.processing,
          arguments: ResultPageArgument(imagePath: image.path),
        );
        // _cameraController.pausePreview();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildShape() {
    return Container(
      width: 230,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(600),
          bottom: Radius.elliptical(600, 1000),
        ),
        border: Border.all(
          color: Pallete.disabled.withOpacity(.7),
          width: 5,
        ),
      ),
    );
  }

  initCamera() async {
    await _cameraController.initialize();
    bool initValue = _cameraController.value.isInitialized;
    setState(() {
      _isCameraInitialized = initValue;
    });
  }
}
