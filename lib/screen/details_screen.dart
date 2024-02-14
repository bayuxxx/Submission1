import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import 'package:ubay_restaurant/models/restaurant.dart';
import 'package:ubay_restaurant/models/theme.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: switchValue ? Colors.black : Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: switchValue ? Colors.white : Colors.black,
        ),
        backgroundColor: switchValue ? Colors.black : Colors.white,
        title: Text(
          restaurant.name,
          style: GoogleFonts.poppins(
            color: switchValue ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'restaurant_image_${restaurant.id}',
                  child: Container(
                    width: double.infinity,
                    height: 30.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          restaurant.pictureId,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 20.sp,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          restaurant.city,
                          style: GoogleFonts.poppins(
                              color: switchValue ? Colors.white : Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20.sp,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${restaurant.rating}',
                          style: GoogleFonts.poppins(
                              color: switchValue ? Colors.white : Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                ReadMoreText(
                  restaurant.description,
                  trimLines: 6,
                  style: GoogleFonts.poppins(
                      color: switchValue ? Colors.white : Colors.black,
                      fontSize: 13.sp),
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Read more',
                  trimExpandedText: ' show less',
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Foods :',
                      style: GoogleFonts.poppins(
                        color: switchValue ? Colors.white : Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: restaurant.foods.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                restaurant.foods[index],
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drinks:',
                      style: GoogleFonts.poppins(
                        color: switchValue ? Colors.white : Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: restaurant.drinks.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: Text(
                                restaurant.drinks[index],
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
