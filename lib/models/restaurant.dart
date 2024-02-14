import 'dart:convert';
import 'package:flutter/services.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final List<String> foods;
  final List<String> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });
}

Future<String> loadJsonData() async {
    return await rootBundle.loadString('assets/local_restaurant.json');
  }

  List<Restaurant> parseRestaurants(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    final List<dynamic> restaurantList = data['restaurants'];

    return restaurantList.map((json) {
      return Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toDouble(),
        foods: List<String>.from(
            json['menus']['foods'].map((food) => food['name'])),
        drinks: List<String>.from(
            json['menus']['drinks'].map((drink) => drink['name'])),
      );
    }).toList();
  }

