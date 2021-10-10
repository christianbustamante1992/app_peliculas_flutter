import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class ScrollHorizontal extends StatelessWidget {
  final List<Pelicula> data;

  ScrollHorizontal({@required this.data});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        children: _renderCard(_screenSize),
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
      ),
    );
  }

  List<Widget> _renderCard(_screenSize) {
    return data.map((item) {
      return Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(item.getPosterImg()),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.16,
              ),
            ),
            Text(
              item.title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();
  }
}
