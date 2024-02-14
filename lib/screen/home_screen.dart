// ignore_for_file: unused_field
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:ubay_restaurant/models/restaurant.dart';
import 'package:ubay_restaurant/models/theme.dart';
import 'package:ubay_restaurant/screen/details_screen.dart';
import 'package:ubay_restaurant/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Restaurant>>? _restaurantsFuture;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture ??= _loadRestaurants();
    _searchController = TextEditingController();
  }

  Future<List<Restaurant>> _loadRestaurants() async {
    String jsonString = await loadJsonData();
    List<Restaurant> restaurants = parseRestaurants(jsonString);
    return restaurants;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: switchValue ? Colors.black : Colors.white,
      body: FutureBuilder(
        future: _restaurantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data: ${snapshot.error}'));
          } else {
            List<Restaurant> restaurants = snapshot.data as List<Restaurant>;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: switchValue ? MyColor.d : MyColor.c,
                  title: Text(
                    "Welcome",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  floating: true,
                  pinned: false,
                  actions: [
                    Row(
                      children: [
                        CupertinoSwitch(
                          thumbColor: Colors.yellow,
                          onLabelColor: Colors.green,
                          activeColor: Colors.black,
                          trackColor: Colors.white,
                          focusColor: Colors.black,
                          value: switchValue,
                          onChanged: (value) {
                            setState(() {
                              switchValue = value;
                            });
                          },
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          color: Colors.white,
                          icon: const Icon(
                            CupertinoIcons.search,
                            size: 30,
                          ),
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: RestaurantSearch(
                                  restaurants: _restaurantsFuture!),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      "Recommendation restaurant for you",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: switchValue ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      Restaurant restaurant = restaurants[index];
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
                                      color: switchValue
                                          ? MyColor.d
                                          : MyColor.c),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(restaurant.pictureId),
                                    fit: BoxFit.cover,
                                  ),
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
                    childCount: restaurants.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
