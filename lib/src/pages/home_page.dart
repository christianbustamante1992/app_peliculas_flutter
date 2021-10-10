import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/pelicula_providers.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/scroll_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final providersPeliculas = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _renderCarrousel(context),
            _renderScrollHorizontal(context)
          ],
        ),
      ),
    );
  }

  _renderCarrousel(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: providersPeliculas.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(data: snapshot.data);
        } else {
          return Container(
            height: _screenSize.height * 0.5,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  _renderScrollHorizontal(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 5.0),
          FutureBuilder(
            future: providersPeliculas.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return ScrollHorizontal(data: snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
