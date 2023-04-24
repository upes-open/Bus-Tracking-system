import 'package:flutter/material.dart';

class SelectRoutesPage extends StatelessWidget {
  final String location1;
  final String location2;
  final int timeTaken;
  final String startingTime;
  final String endingTime;

  SelectRoutesPage({
    required this.location1,
    required this.location2,
    required this.timeTaken,
    required this.startingTime,
    required this.endingTime,
  });

  static List<SelectRoutesPage> Routes = [
    SelectRoutesPage(
        location1: 'Location A',
        location2: 'Location B',
        timeTaken: 20,
        startingTime: '8:00 PM',
        endingTime: '8:20 PM'),
    SelectRoutesPage(
        location1: 'Location B',
        location2: 'Location C',
        timeTaken: 30,
        startingTime: '8:20 PM',
        endingTime: '8:50 PM'),
    SelectRoutesPage(
        location1: 'Location C',
        location2: 'Location D',
        timeTaken: 25,
        startingTime: '8:50 PM',
        endingTime: '9:15 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Route'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$location1 to $location2',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Time Taken: $timeTaken mins',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Starting Time: $startingTime',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ending Time: $endingTime',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
