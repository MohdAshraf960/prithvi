import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prithvi/features/home/widgets/customcard.dart';

class Home extends ConsumerStatefulWidget {
  static const id = "/home";
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Backdrop',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5.0,
                  child: Container(
                    height: 100,
                    width: 300,
                    child: Column(
                      children: [
                        Text('Journey by Air'),
                        Text('Journey by Air'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Journey by Air'),
                    Text('Journey by Air'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://c1.wallpaperflare.com/preview/790/806/402/aircraft-start-propeller-propeller-plane.jpg'),
                        mode: 'Air Travel',
                        desc: 'On average how many flights do u take per year'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://cdn.tripxoxo.com/media/catalog/product/cache/1/small_image/1200x628/9df78eab33525d08d6e5fb8d27136e95/S/M/SMALL_BUS_ONSHORE_EXPERIENCE_TRAIL_OF_MARLBOROUGH_-12-18_SEATS-0.jpg'),
                        mode: 'Bus Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://img.freepik.com/free-vector/happy-family-travelling-by-car-with-camping-equipment-top_74855-10751.jpg'),
                        mode: 'Car Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling by car'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://img.freepik.com/free-vector/happy-family-travelling-by-car-with-camping-equipment-top_74855-10751.jpg'),
                        mode: 'Car Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling by car'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://img.freepik.com/free-vector/happy-family-travelling-by-car-with-camping-equipment-top_74855-10751.jpg'),
                        mode: 'Car Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling by car')
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back),
      ),
      body: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Backdrop',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5.0,
                  child: Container(
                    height: 100,
                    width: 300,
                    child: Column(
                      children: [
                        'Journey by Air'.text.xl.make(),
                        'Time in hours'.text.make(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Journey Mode'.text.xl2.bold.make(),
                    'Select your transport do your use most frequently'
                        .text
                        .make(),
                    JourneyModeCards(
                        image: Image.network(
                            'https://c1.wallpaperflare.com/preview/790/806/402/aircraft-start-propeller-propeller-plane.jpg'),
                        mode: 'Air Travel',
                        desc: 'On average how many flights do u take per year'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://cdn.tripxoxo.com/media/catalog/product/cache/1/small_image/1200x628/9df78eab33525d08d6e5fb8d27136e95/S/M/SMALL_BUS_ONSHORE_EXPERIENCE_TRAIL_OF_MARLBOROUGH_-12-18_SEATS-0.jpg'),
                        mode: 'Bus Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://img.freepik.com/free-vector/happy-family-travelling-by-car-with-camping-equipment-top_74855-10751.jpg'),
                        mode: 'Car Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling by car'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://img.freepik.com/free-vector/happy-family-travelling-by-car-with-camping-equipment-top_74855-10751.jpg'),
                        mode: 'Car Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling by car'),
                    JourneyModeCards(
                        image: Image.network(
                            'https://img.freepik.com/free-vector/happy-family-travelling-by-car-with-camping-equipment-top_74855-10751.jpg'),
                        mode: 'Car Travel',
                        desc:
                            'On the average how many hours per day do you spend traveling by car')
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


 */
class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
