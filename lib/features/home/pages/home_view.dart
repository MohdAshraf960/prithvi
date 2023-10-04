// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';

import 'package:prithvi/config/config.dart';

import 'package:prithvi/core/core.dart';

class Home extends StatefulWidget {
  static const id = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController =
      PageController(); // Define _pageController here
  int _currentPage = 0;

  final List<Map<String, String>> data = [
    {
      'image': Assets.first,
      'text': 'We are thrilled to welcome \nyou to the Prithivi community',
    },
    {
      'image': Assets.second,
      'text':
          'Conveniently track the environmental \nimpact of your daily activities such as food,\ndaily commute,travel and consumption',
    },
    {
      'image': Assets.third,
      'text': 'Get easy suggetion to reduce your impact',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return buildPageItem(data[index]);
              },
            ),
          ),
          DotsIndicator(
            dotsCount: data.length,
            position: _currentPage,
            decorator: DotsDecorator(
              color: Colors.grey, // Inactive dot color
              activeColor: primaryGreen, // Active dot color
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget buildPageItem(Map<String, String> item) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.st,
        children: [
          // Padding(
          //   padding: EdgeInsets.all(16),
          //   child: Row(
          //     children: [
          //       TextButton(
          //         onPressed: () {},
          //         child: Text(
          //           "SKIP",
          //           style: TextStyle(
          //             color: grey,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Spacer(),

          Spacer(),
          Center(
            child: Image.asset(
              item['image'].toString(),
              // width: 200.0,
              // height: 200.0,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            item['text'].toString(),
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          Spacer(),
        ],
      ),
    );
  }
}

/*
class Home extends ConsumerStatefulWidget {
  static const id = "/home";
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  // final List<ChartData> _chartData = [
  //   ChartData('Category 1', 30),
  //   ChartData('Category 2', 0),
  //   ChartData('Category 3', 0),
  //   ChartData('Category 4', 0),
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(questionNotifierProvider(''));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: primaryGreen,
      ),
      body: Column(
        children: [
          Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                height: 300,
                width: 300,
                child: Column(
                  children: [
                    SfCircularChart(
                      series: <CircularSeries>[
                        // Create a pie series
                        PieSeries<ChartData, String>(
                          dataSource: notifier.chartList,
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
                    // TextButton(
                    //     onPressed: () async {
                    //       print("hvghv");
                    //       await FirebaseAnalytics.instance.logEvent(
                    //           name: "rafiq",
                    //           parameters: {"note": "ashrafkhankondhwa"});
                    //     },
                    //     child: Text("jfcxvbvnm,")),
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

/*
class ChartData {
  final String category;
  double value;

  ChartData(this.category, this.value);

  @override
  String toString() => 'ChartData(category: $category, value: $value)';
}
*/
