import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/Movie.dart';

import '../globals.dart' as globals;
import '../theme/style.dart' as style;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final f = new DateFormat('dd/MM/yyyy');
  bool showInfo = false;
  bool loading = true;
  PageController _pageController = PageController();
  List<Movie> movies = [];
  int page = 1;
  final txtSearch = TextEditingController();


  void searchMovies() async {
    List<Movie> movies = [];
    var uri = Uri.https(globals.host, '3/search/movie',
        {
          'api_key': globals.API_KEY,
          'language': 'pt-BR',
          'query': this.txtSearch.text,
          'page': this.page.toString(),
          'include_adult': false.toString()
        });
    var data = await http.get(uri);
    if (data.body.isNotEmpty) {
      var decoded = jsonDecode(data.body);
      decoded['results'].forEach((item) {
        Movie movie = new Movie.fromJson(item);
        movies.add(movie);
      });
      setState(() {
        this.movies = movies;
        this.page = 0;
      });
    }
  }

  void getMovies() async {
    List<Movie> movies = [];
    var uri = Uri.https(globals.host, '/3/movie/upcoming',
        {
          'api_key': globals.API_KEY,
          'language': 'pt-BR',
          'page': this.page.toString()
        });
    var data = await http.get(uri);
    if (data.body.isNotEmpty) {
      var decoded = jsonDecode(data.body);
      decoded['results'].forEach((item) {
        Movie movie = new Movie.fromJson(item);
        movies.add(movie);
      });
      setState(() {
        this.movies.addAll(movies);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (this.loading) {
      this.loading = false;
      this.getMovies();
    }

    return Scaffold(
      backgroundColor: style.backgroundDarkColor,
      body: Container(
        color: style.backgroundDarkColor,
        child: (this.movies.length > 0)
            ? Stack(
              children: [
                PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: (index){
                    if(index == this.movies.length - 1) {
                      setState(() {
                        this.page++;
                      });
                      this.getMovies();
                    }
                  },
                  children: [
                    for(Movie movie in this.movies)
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://image.tmdb.org/t/p/w500' + movie.posterPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                          child: SafeArea(
                            child: SingleChildScrollView(
                              child: Container(
                                height: MediaQuery.of(context).size.height * 2,
                                child: Stack(
                                    alignment: AlignmentDirectional.topCenter,
                                    children: [
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * 0.65,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.90,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: style.backgroundMediumColor.withOpacity(0.85),
                                            borderRadius: BorderRadius.circular (8),
                                          ),
                                          child: Column(
                                            children: [
                                              Container (
                                                width: MediaQuery.of(context).size.width,
                                                margin: const EdgeInsets.only(top: 30),
                                                child: Text (
                                                  movie.title,
                                                  style: style.itemTitle,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container (
                                                width: MediaQuery.of(context).size.width,
                                                margin: const EdgeInsets.only(top: 4, bottom: 8),
                                                child: movie.getGenres(),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_today_outlined,
                                                        color: style.highlightColor,
                                                        size: 24,
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(left: 8),
                                                        child: Text(
                                                            f.format(DateTime.parse(movie.releaseDate)),
                                                            style: style.defaultText
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              ),
                                              Container (
                                                  margin: const EdgeInsets.only(top: 16, bottom: 8),
                                                  child: TextButton.icon (
                                                    label: Text (
                                                      (showInfo) ? 'Menos detalhes' : 'Mais detalhes',
                                                      style: style.defaultText,
                                                    ),
                                                    icon: const Icon(
                                                      Icons.info,
                                                      size: 16,
                                                    ),
                                                    style: style.defaultStyleButton,
                                                    onPressed: () {
                                                      setState(() {
                                                        showInfo = !showInfo;
                                                      });
                                                    },
                                                  )
                                              ),
                                              if (showInfo)
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.text_snippet,
                                                        color: style.highlightColor,
                                                        size: 24,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        margin: const EdgeInsets.only(top: 4, bottom: 16),
                                                        child: Text(
                                                          movie.overview,
                                                          style: style.defaultText,
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              if (showInfo)
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage('https://image.tmdb.org/t/p/w500' + movie.backdropPath),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              this._pageController.previousPage( duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 10),
                                              padding: const EdgeInsets.all(0.1),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: style.darkBrown.withOpacity(0.75),
                                              ),
                                              child: Icon(
                                                  Icons.arrow_back,
                                                  color: style.highlightColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.65,
                                            margin: const EdgeInsets.only(top: 60),
                                            child: AspectRatio(
                                              aspectRatio: 2/3,
                                              child: Container (
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular (8),
                                                  image: DecorationImage(
                                                    image: NetworkImage('https://image.tmdb.org/t/p/w500' + movie.posterPath),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              this._pageController.nextPage( duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 10),
                                              padding: const EdgeInsets.all(0.5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: style.darkBrown.withOpacity(0.75),
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: style.highlightColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 10, left: 8, right: 8),
                  child: TextFormField(
                    controller: txtSearch,
                    decoration: InputDecoration (
                      contentPadding: const EdgeInsets.only(left: 12, right: 12),
                      filled: true,
                      fillColor: style.backgroundMediumColor.withOpacity(0.75),
                      hintText: 'Pesquisar',
                      hintStyle: TextStyle(
                          color: style.highlightColor
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: style.highlightColor,
                        ),
                        onPressed: (){
                          this.searchMovies();
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide (
                            color: style.highlightColor
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    cursorColor: style.highlightColor,
                    style: style.highlightText,
                  ),
                ),
              ],
            )
            : globals.fullLoading
      ),
    );
  }
}
