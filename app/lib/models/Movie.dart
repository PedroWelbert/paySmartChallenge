import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/style.dart' as style;

class Movie {
  late final bool adult;
  late final String backdropPath;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final int voteCount;

  Movie(
    {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteCount});

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'] ?? '';
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'] ?? 'Nenhuma sinopse encontrada!';
    popularity = json['popularity'];
    posterPath = json['poster_path'] ?? '';
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_count'] = this.voteCount;
    return data;
  }

  Widget getGenres () {
    List<Widget> genres = [];
    if (this.genreIds.length > 2) {
      this.genreIds.removeRange(2, this.genreIds.length);
    }
    for (var genre in this.genreIds) {
      genres.add(
        Container(
          margin: EdgeInsets.only(left: 6, right: 2),
          child: Icon(
            Icons.local_movies ,
            color: style.highlightColor,
            size: 15,
          ),
        ),

      );
      genres.add(
        Text(
          this.getGenreName(genre),
          style: style.smallText,
        ),
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: genres
    );
  }

  String getGenreName(int id) {
    switch(id) {
      case 28: //Action
        return 'Ação';
        break;

      case 12: //Adventure
        return 'Aventura';
        break;

      case 16: //Animation
        return 'Animação';
        break;

      case 35: //Comedy
        return 'Comédia';
        break;

      case 80: //Crime
        return 'Crime';
        break;

      case 99: //Documentary
        return 'Documentário';
        break;

      case 18: //Drama
        return 'Drama';
        break;

      case 10751: //Family
        return 'Família';
        break;

      case 14: //Fantasy
        return 'Fantasia';
        break;

      case 36: //History
        return 'Histórico';
        break;

      case 27: //Horror
        return 'Terror';
        break;

      case 10402: //Music
        return 'Musical';
        break;

      case 9648: //Mystery
        return 'Mistério';
        break;

      case 10749: //Romance
        return 'Romance';
        break;

      case 878: //Sci-Fi
        return 'Ficção Científica';
        break;

      case 53: //Thriller
        return 'Suspense';
        break;

      case 10770: //Tv Movie
        return 'Televisão';
        break;

      case 10752: //War
        return 'Guerra';
        break;

      case 53: //Western
        return 'Faroeste';
        break;

      default: //Default
        return 'Padrão';
    }
  }
}



