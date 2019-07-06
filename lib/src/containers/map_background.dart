import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uber_template/src/state/map/selectors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../state/app/app.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (_, vm) =>
        vm.cameraPosition == null
          ? Container()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: vm.cameraPosition,
                zoom: vm.zoom,
              ),
              mapType: MapType.terrain,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              rotateGesturesEnabled: false,
            )
    );
}

@immutable
class _ViewModel extends Equatable {
  final LatLng userPosition;
  final LatLng cameraPosition;
  final double zoom;

  _ViewModel({this.userPosition, this.cameraPosition, this.zoom})
    : super([userPosition, cameraPosition, zoom]);

  static _ViewModel fromStore(store) =>
    _ViewModel(
      userPosition: selectMapUserPosition(store.state),
      cameraPosition: selectMapCameraPosition(store.state),
      zoom: selectMapZoom(store.state),
    );
}
