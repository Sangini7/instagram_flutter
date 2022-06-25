import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  //cupertino icon will give index to the icon and will sent index in page
  //pagecontroller jumps to given page
  void navigationTapped(int page) {
    setState(() {
      pageController.jumpToPage(page);
      _page = page;
    });
  }

  void onPageChanged(int page) {
    _page = page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset('assets/ic_instagram.svg',
              color: primaryColor, height: 32),
          actions: [
            IconButton(
                onPressed: () => navigationTapped(0),
                icon: Icon(Icons.home,
                    color: _page == 0 ? greenColor : secondaryColor)),
            IconButton(
                onPressed: () => navigationTapped(1),
                icon: Icon(Icons.search,
                    color: _page == 1 ? greenColor : secondaryColor)),
            IconButton(
              onPressed: () => navigationTapped(2),
              icon: Icon(Icons.add_a_photo,
                  color: _page == 2 ? greenColor : secondaryColor),
            ),
            IconButton(
              onPressed: () => navigationTapped(3),
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? greenColor : secondaryColor),
            ),
            IconButton(
              onPressed: () => navigationTapped(4),
              icon: Icon(Icons.person,
                  color: _page == 4 ? greenColor : secondaryColor),
            ),
          ]),
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
