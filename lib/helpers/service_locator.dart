import 'package:get_it/get_it.dart';
import 'package:quraan/helpers/cache_helper.dart';


final sl = GetIt.instance;
void initServiceLocator() {
//!external
  sl.registerLazySingleton(() => CacheHelper());
}
