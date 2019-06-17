import 'package:redux/redux.dart';

import '../auth/middlewares.dart';
import 'model.dart';

List<Middleware<AppState>> createAllMiddlewares() =>
  [
    ...authMiddlewares,
  ];
