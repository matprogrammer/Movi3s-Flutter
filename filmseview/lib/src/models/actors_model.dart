

import 'package:flutter/material.dart';

class Cast {

  List<Actor> actors = new List();
  Cast.fromJsonList(List<dynamic> jsonListActors) {
    if (jsonListActors == null) return;

    jsonListActors.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }

}

class Actor {
  int castId;
  String character;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });


  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    gender = json['gender'];
    id = json['id'];
    name = json['original_name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getImageActor() {
    if (profilePath == null) {
      return 'https://southernplasticsurgery.com.au/wp-content/uploads/2013/10/user-placeholder.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }

}
