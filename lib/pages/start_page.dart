import 'package:flutter/material.dart';

import '../utils/animation_item.dart';
import '../utils/consts.dart';
import '../widgets/logo_widget.dart';
import 'first_page.dart';
import 'password_page.dart';
import 'second_page.dart';
import 'third_page.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  PageController? _pageController;
  List<AnimationItem> animationlist = [];
  Tween<double>? postionLogo;
  int _currentIndex = 0;
  int _currentIndexColor = 0;
  Tween? _animacaoColor;
  @override
  void initState() {
    super.initState();
    setState(() {});
    delayAnimatiom(
        AnimationItem(
          name: 'logo_scale',
          tween: Tween<double>(begin: 0.0, end: 0.8),
        ),
        const Duration(milliseconds: 800), (animation) {
      setState(() {
        animationlist.add(animation);
      });
    });
    _pageController = PageController(initialPage: 0);
    postionLogo = Tween(begin: 0.0, end: 0.0);
    _animacaoColor = Tween(begin: 2.3, end: 2.3);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 400),
            builder: (BuildContext context, value, Widget? child) {
              return Transform.scale(scale: value as double, child: child);
            },
            tween: _animacaoColor!,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _currentIndexColor != null
                      ? listColors[_currentIndexColor]
                      : null),
            ),
          ),
          SizedBox(
            height: height,
            width: height,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(parent: null),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  switch (index) {
                    case 0:
                      postionLogo = Tween(begin: 0.0, end: 0.0);
                      break;
                    default:
                      postionLogo = Tween(begin: 0.0, end: 0.25);
                  }
                });
              },
              scrollDirection: Axis.vertical,
              children: <Widget>[
                FirstPage(
                  pageController: _pageController,
                  buttonColor: listColors[_currentIndexColor].colors[1],
                ),
                const SecondPage(),
                const PasswordPage(),
                ThirdPage(
                  initialIndex: _currentIndexColor,
                  valueChanged: (index) {
                    setState(() {
                      _animacaoColor = Tween(begin: 4.0, end: 0.0);
                      _currentIndexColor = index;
                      _animacaoColor = Tween(begin: 0.0, end: 2.3);
                    });
                  },
                ),
              ],
            ),
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 300),
            curve: _currentIndex == null ? Curves.elasticOut : Curves.easeInOut,
            tween: postionLogo!,
            builder: (BuildContext context, animation, Widget? child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: height * 0.10,
                left: _currentIndex == 0 ? width / 2 - (100 / 2) : 15,
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  tween: findAnimation('logo_scale', 0.0, animationlist),
                  builder: (context, value, child) {
                    return Transform.scale(
                        scale: double.parse(value.toString()) - animation,
                        child: child);
                  },
                  child: LogoWidget(),
                ),
              );
            },
          ),
          AnimatedPositioned(
            top: height * 0.85,
            right: _currentIndex == 0 ? -40 : 10,
            width: 40,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.expand_less,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    _pageController?.animateToPage(_currentIndex - 1,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInCubic);
                  },
                ),
                const SizedBox(
                  height: 0,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.expand_more,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _pageController?.animateToPage(_currentIndex + 1,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInCubic);
                  },
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            top: height * 0.15,
            right: _currentIndex == 0 ? -40 : 10,
            width: 40,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            child: Column(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      color: _currentIndex == 1 ? Colors.white : Colors.white54,
                      shape: BoxShape.circle),
                ),
                const SizedBox(
                  height: 12,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 8,
                  width: 68,
                  decoration: BoxDecoration(
                      color: _currentIndex == 2 ? Colors.white : Colors.white54,
                      shape: BoxShape.circle),
                ),
                const SizedBox(
                  height: 12,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      color: _currentIndex == 3 ? Colors.white : Colors.white54,
                      shape: BoxShape.circle),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
