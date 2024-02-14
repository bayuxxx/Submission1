import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:ubay_restaurant/models/restaurant.dart';
import 'package:ubay_restaurant/models/theme.dart';
import 'package:ubay_restaurant/screen/details_screen.dart';

class RestaurantSearch extends SearchDelegate<List<Restaurant>> {
  final Future<List<Restaurant>> restaurants;

  RestaurantSearch({required this.restaurants});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: switchValue ? Colors.white : Colors.black,
      child: FutureBuilder(
        future: _search(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Restaurant> searchResults = snapshot.data as List<Restaurant>;

            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = searchResults[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailsPage(restaurant: restaurant),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Hero(
                        tag: 'restaurant_image_${restaurant.id}',
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, right: 10, bottom: 10),
                          width: 100.sp,
                          height: 90.sp,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: switchValue ? MyColor.c : MyColor.d),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                  (restaurant.pictureId),
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Text(
                                restaurant.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15.sp,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                restaurant.city,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15.sp,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${restaurant.rating}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: switchValue ? Colors.black : Colors.white,
      child: FutureBuilder(
        future: _search(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Restaurant> suggestions = snapshot.data as List<Restaurant>;

            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = suggestions[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailsPage(restaurant: restaurant),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Hero(
                        tag: 'restaurant_image_${restaurant.id}',
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, right: 10, bottom: 10),
                          width: 100.sp,
                          height: 90.sp,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: switchValue ? MyColor.d : MyColor.c),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                  (restaurant.pictureId),
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Text(
                                restaurant.name,
                                style: GoogleFonts.poppins(
                                  color: switchValue
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15.sp,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                restaurant.city,
                                style: GoogleFonts.poppins(
                                  color: switchValue
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15.sp,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${restaurant.rating}",
                                style: GoogleFonts.poppins(
                                  color: switchValue
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Restaurant>> _search(String query) async {
    List<Restaurant> results = (await restaurants)
        .where((restaurant) =>
            restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
            restaurant.city.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return results;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, List<Restaurant>.empty());
      },
    );
  }
}
