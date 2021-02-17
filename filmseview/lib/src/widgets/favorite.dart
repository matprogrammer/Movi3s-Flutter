import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Favorite extends StatefulWidget {

  final int movieId;
  Favorite({ @required this.movieId });

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  int _active = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _active = (prefs.getInt(widget.movieId.toString()) ?? 0);
      print('activeId: $_active');
    });
  }


  _save(String movieId, String action) async {
    final prefs = await SharedPreferences.getInstance();
    if (action == 'save') {
      prefs.setInt(movieId, _active);
    } else {
      prefs.remove(movieId);
    }
  }

  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.favorite), color: _active > 0 ? Colors.red : Colors.white, onPressed: (){
      if (widget.movieId == _active) {
        setState(() {
          _save(widget.movieId.toString(), 'remove');
          _active = 0;
        });
      } else {
         setState(() {
          _save(widget.movieId.toString(), 'save');
          _active = widget.movieId;
      });
      }
    });
  }

}
