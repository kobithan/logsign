import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_firebase/Model/restarantModal.dart';
import 'package:flutter_firebase/Model/restaurantData.dart';
import 'package:flutter_firebase/Screens/homeScreen/bookingScreen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Swiper(
    //   onTap: (index) {
    //     _showBottomSheet(context, index);
    //   },
    //   itemBuilder: (context, index) {
    //     return Center(
    //       child: Padding(
    //         padding: const EdgeInsets.all(40.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               height: 500,
    //               width: 500,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(15),
    //                 image: DecorationImage(
    //                   image: NetworkImage(restaurants[index]['image']),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //             Text(
    //               restaurants[index]['name'],
    //               style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    //             ),
    //             Text(restaurants[index]['location']),
    //             Text(restaurants[index]['price'])
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    //   autoplay: true,
    //   itemCount: restaurants.length,
    //   scrollDirection: Axis.horizontal,
    //   // pagination: const SwiperPagination(alignment: Alignment.centerRight),
    //   control: const SwiperControl(),
    // ));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello!'),
            Text('Find and book'),
            Text(
              'The best restaurants',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Featured',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              height: 500,
              child: Swiper(
                onTap: (index) {
                  _showBottomSheet(context, index);
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 300,
                            width: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image:
                                    NetworkImage(restaurants[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            restaurants[index]['name'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(restaurants[index]['location']),
                          Text(restaurants[index]['price'])
                        ],
                      ),
                    ),
                  );
                },
                autoplay: false,
                itemCount: restaurants.length,
                scrollDirection: Axis.horizontal,
                // pagination: const SwiperPagination(alignment: Alignment.centerRight),
                control: const SwiperControl(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, int index) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints.loose(Size.fromHeight(750)),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(restaurants[index]['image']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurants[index]['name'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    restaurants[index]['location'],
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Contact number: ${restaurants[index]['number']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  RatingBar.builder(
                    initialRating: restaurants[index]['initialRating'],
                    ignoreGestures: true,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 36.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final Restaurant selectedRestaurant = Restaurant(
                            restaurantId: restaurants[index]['restaurantId'],
                            name: restaurants[index]['name'],
                            location: restaurants[index]['location'],
                            price: restaurants[index]['price'],
                            image: restaurants[index]['image'],
                            number: restaurants[index]['number'],
                            initialRating: restaurants[index]['initialRating'],
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingScreen(
                                    selectedRestaurant: selectedRestaurant)),
                          );

                          // Navigator.pushNamed(context, "/home");
                        },
                        child: Text('Reserve it'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
