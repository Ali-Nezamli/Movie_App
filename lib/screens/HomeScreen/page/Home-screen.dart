import 'package:flutter/material.dart';
import 'package:movieapp/screens/HomeScreen/Movies/movies-screen.dart';
import 'package:movieapp/screens/HomeScreen/TvSeries/series.dart';
import 'package:movieapp/screens/SearchScreen/page/search-screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode focusNode = FocusNode();
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  bool showButton = false;
  String? name;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            alignment: Alignment.centerRight,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchScreen();
              }));
            },
            icon: Icon(
              Icons.search,
              size: 35,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Movies',
            icon: Icon(
              Icons.movie,
            ),
          ),
          BottomNavigationBarItem(
            label: 'TV Series',
            icon: Icon(
              Icons.tv,
            ),
          ),
        ],
        currentIndex: selectedIndex,
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              selectedIndex = page;
            });
          },
          children: <Widget>[
            MoviesScreen(),
            TvSeries(),
          ],
        ),
      ),
    );
  }
}
