import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travinia/presentation/explore_on_map/widgets/google_map_widget.dart';

class ExploreOnMap extends StatelessWidget {
  const ExploreOnMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal,
            width: double.infinity,
            height: 60,
            child: Center(child: Text('testing the map')),
          ),
          GoogleMapWidget(),
        ],
      ),
    );
  }
}
