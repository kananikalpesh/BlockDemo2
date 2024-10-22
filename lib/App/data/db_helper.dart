import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'movies.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE movies (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            Title TEXT,
            Year TEXT,
            imdbID TEXT,
            Type TEXT,
            Poster TEXT
          )
        ''');
      },
    );
  }

  // Insert a movie into the database
  Future<void> insertMovie(Movie movie) async {
    final db = await database;
    await db.insert('movies', movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Retrieve all movies from the database
  Future<List<Movie>> getMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');

    return List.generate(maps.length, (i) {
      return Movie.fromJson(maps[i]);
    });
  }

  // Delete all movies
  Future<void> deleteAllMovies() async {
    final db = await database;
    await db.delete('movies');
  }
}
