import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/screens/HomeScreen/Movies/bloc/Movie_bloc.dart';
import 'package:movieapp/screens/HomeScreen/Movies/movies-screen.dart';
import 'package:movieapp/screens/HomeScreen/TvSeries/bloc/series_bloc.dart';
import 'package:movieapp/screens/HomeScreen/TvSeries/series.dart';
import 'package:movieapp/screens/SearchScreen/page/search-screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  FocusNode focusNode = FocusNode();
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  bool showButton = false;
  String? name;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(GetMovies(1));
    BlocProvider.of<SeriesBloc>(context).add(GetSeries(1));
  }

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
