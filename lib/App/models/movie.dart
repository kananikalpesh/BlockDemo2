class Movie {
  int? id;
  String? title;
  String? year;
  String? imdbID;
  String? type;
  String? poster;

  Movie({this.title, this.year, this.imdbID, this.type, this.poster});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    year = json['Year'];
    imdbID = json['imdbID'];
    type = json['Type'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Title'] = title;
    data['Year'] = year;
    data['imdbID'] = imdbID;
    data['Type'] = type;
    data['Poster'] = poster;
    return data;
  }
}
