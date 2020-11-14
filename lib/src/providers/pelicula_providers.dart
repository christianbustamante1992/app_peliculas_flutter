import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaProvider {
  String _apikey = 'bd96f3f722d9c3d99193589d5b8c6a53';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return procesaRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apikey, 'language': _language});

    return procesaRespuesta(url);
  }

  Future<List<Pelicula>> procesaRespuesta(Uri url) async {
    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final data = new Peliculas.fromJsonList(decodedData['results']);

    return data.items;
  }
}
