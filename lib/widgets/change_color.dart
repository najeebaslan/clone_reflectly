import 'package:flutter/material.dart';

class ChangeColor extends StatelessWidget {
  final LinearGradient? linearGradient;
  final BoxBorder? border;
  final int? index;
  final double? offset;
  final VoidCallback? onTap;

  const ChangeColor(
      {Key? key,
      this.border,
      this.offset,
      this.index,
      this.onTap,
      this.linearGradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        top: index! > offset!.round()
            ? (height * 0.20)
            : index == offset?.round()
                ? (height * 0.25)
                : (height * 0.30),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 200),
              builder: (BuildContext context, value, Widget? child) {
                return Transform.scale(scale: value, child: child);
              },
              tween:
                  Tween(begin: 0.8, end: index == offset?.round() ? 1.0 : 0.8),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    border: border ?? Border.all(width: 4, color: Colors.white),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 10),
                          blurRadius: 10)
                    ],
                    gradient: linearGradient),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
