import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
class GeoCoding extends StatefulWidget {
  const GeoCoding({Key? key}) : super(key: key);

  @override
  State<GeoCoding> createState() => _GeoCodingState();
}

class _GeoCodingState extends State<GeoCoding> {
  String stAdress ='';
  String stAdd ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GeoCoding"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAdress),
          SizedBox(height: 50),
          Text(stAdd),
          GestureDetector(
              onTap: () async {
                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

                // final coordinates = new Coordinates(34.19514342184248, 73.23560811319133);
                final query = "1600 Amphiteatre Parkway, Mountain View";

                setState(() {
                  stAdress = locations.first.longitude.toString() +
                      " " +locations.first.latitude.toString();
                  stAdd = placemarks.first.country.toString();
                });
                },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                // width:double.infinity,
                color: Colors.amber,
                child: Center(child: Text("Convert",style: TextStyle(fontSize: 25),)),
              ),
            ),
          )
        ],
      ),
    );

  }
}
