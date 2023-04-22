import 'package:flutter/material.dart';
import 'package:bus_tracking_system/screen/locations/components/map_page.dart';

class LocationsPage extends StatefulWidget {
  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final List<String> _locations = [
    'Prem Nagar UPES',
    'Clock Tower',
    'Dehradun ISBT',
    'Bidholi',
    'Kandholi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Select Route',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _locations.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _locations[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Driver: John Doe',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Phone: +91-7894521642',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to the map page for the selected location
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MapPage(location: _locations[index]),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Track in Map',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
