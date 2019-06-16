import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      key: _scaffold,
      drawer: _buildDrawer(),
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
                onPressed: () =>
                  _scaffold.currentState.openDrawer(),
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

  _buildDrawerHeader() =>
    Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF545454),
          )
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // photo
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Colors.white,
                      width: 0.5,
                    ),
                    image: DecorationImage(
                      image: NetworkImage('http://interfacetreinamentos.com.br/wp-content/uploads/2016/04/img-profile-default.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // name and rating
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Gildson Bezerra',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Text(
                            '5.00',
                            style: TextStyle(
                              color: const Color(0xFFA3A3A3),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 14,
                          color: const Color(0xFFA3A3A3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  Widget _buildDrawerAds() =>
    Container(
      color: Colors.black,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // ads header
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                'Do more with your account',
                style: TextStyle(
                  color: const Color(0xFFA3A3A3),
                ),
              ),
            ),
            // TODO: create link button widget to assign a method/animation (every ad have that to have a link to another resource/tool)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                'Get food delivery',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Make money driving',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

  Widget _buildDrawerItems() =>
    Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              DrawerItem(
                text: 'Your Trips',
                onPressed: () {},
              ),
              DrawerItem(
                text: 'Help',
                onPressed: () {},
              ),
              DrawerItem(
                text: 'Payment',
                positiveText: 'Get up to 5% off',
                onPressed: () {},
              ),
              DrawerItem(
                text: 'Free Rides',
                onPressed: () {},
              ),
              DrawerItem(
                text: 'Settings',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );

  Widget _buildDrawerVersion() =>
    Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color(0xFFCCCCCC),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // ?tag?
          Expanded(
            child: Text('Legal'),
          ),
          // version
          Text(
            'v4.266.10003',
            style: TextStyle(color: const Color(0xFFCCCCCC)),
          ),
        ],
      ),
    );

  Widget _buildDrawer() =>
    Container(
      color: Colors.white,
      width: 300,
      child: Column(
        children: <Widget>[
          // header
          _buildDrawerHeader(),
          // ads
          _buildDrawerAds(),
          // items
          _buildDrawerItems(),
          // app info/version
          _buildDrawerVersion(),
        ],
      ),
    );
}
