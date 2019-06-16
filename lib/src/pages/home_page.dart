import 'package:flutter/material.dart';
import 'package:flutter_uber_template/src/widgets/search_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/progress_bar.dart';
import '../widgets/tile_place.dart';
import '../widgets/tile_place_separator.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: Stack(
        children: <Widget>[
          // ever in background
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-5.8411396, -35.2106268),
              zoom: 16,
            ),
            mapType: MapType.terrain,
          ),
          // menu button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  size: 32,
                ),
              ),
            ),
          ),
          // bottomsheet/navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // salutation
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      'Good evening, ?Gildson?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  // progress
                  ProgressBar(),
                  // searchbox
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                    ),
                    child: SearchButton(
                      whereToButtonOnPressed: () {},
                      scheduleButtonOnPressed: () {},
                    ),
                  ),
                  // saved places
                  TilePlace(
                    title: 'Home',
                    description: 'Rua Congonhas - Natal/RN',
                    type: TilePlaceType.home,
                    onPressed: () {},
                  ),
                  TilePlaceSeparator(),
                  TilePlace(
                    title: 'Office',
                    description: 'Rua Lafayette Lamartine - Candelária - Natal/RN',
                    type: TilePlaceType.company,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
}
