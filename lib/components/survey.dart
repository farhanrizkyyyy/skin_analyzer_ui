// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';

class Survey extends StatefulWidget {
  String title;
  int currentIndex;
  List<String> chipText;
  List<bool> isSelected;
  Survey({
    required this.title,
    required this.chipText,
    required this.isSelected,
    required this.currentIndex,
    super.key,
  });

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  final TextEditingController _controller = TextEditingController();
  // int _selectedIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.wb_sunny,
      Icons.water_drop,
      Icons.cloud
    ];
    final List<String> texts = ['UV Index 15', 'Humidity 20%', 'Pollution 20'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 16),
        Builder(builder: (context) {
          if (widget.currentIndex == 3) {
            return Column(
              children: [
                TextField(
                  controller: _controller,
                  style: TextStyle(fontSize: 12),
                  cursorColor: Pallete.primary,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: 'Bandung, Jawa Barat',
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    hintStyle: TextStyle(fontSize: 12),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Pallete.primary),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(icons.length, (index) {
                    return Column(
                      children: [
                        Icon(
                          icons[index],
                          size: 30,
                          color: Pallete.yellow,
                        ),
                        SizedBox(height: 4),
                        Text(
                          texts[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ],
            );
          } else {
            return Wrap(
              spacing: 8,
              children: List.generate(widget.chipText.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < widget.chipText.length; i++) {
                        widget.isSelected[i] = false;
                      }
                      widget.isSelected[index] = true;
                    });
                  },
                  child: Chip(
                    label: Text(widget.chipText[index]),
                    backgroundColor: widget.isSelected[index]
                        ? Pallete.primary
                        : Colors.white,
                    elevation: 0,
                    side: BorderSide(color: Pallete.primary),
                    labelStyle: TextStyle(
                      fontSize: 10,
                      color: !widget.isSelected[index]
                          ? Pallete.primary
                          : Colors.white,
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                );
              }),
            );
          }
        }),
      ],
    );
  }
}
