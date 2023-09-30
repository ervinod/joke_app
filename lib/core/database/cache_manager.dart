import 'package:hive/hive.dart';
import 'package:joke_app/core/utils/app_log.dart';
import 'package:joke_app/features/joke/data/models/joke_model.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  CacheManager.internal();

  static final CacheManager instance = CacheManager.internal();

  factory CacheManager() => instance;
  late final Box<Joke> box;

  initialise() async {
    /// initializing database
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(JokeAdapter());
    box = await Hive.openBox<Joke>('joke_box');
  }

  Future<List<Joke>> cacheData(
    Joke data,
  ) async {
    /// store data in vide database
    try {
      if (!box.isOpen) {
        initialise();
        AppLog().debug("Hive box could not be opened. reinitialized");
        return [];
      }

      if (box.values.length >= 10) {
        box.deleteAt(0);
      }
      await box.add(data);

      return box.values.map((e) => e).toList();
    } catch (e) {
      AppLog().debug("Error while saving cached data");
      return [];
    }
  }

  Future<List<Joke>> getCachedData() async {
    /// get saved data
    try {
      if (!box.isOpen) {
        initialise();
        AppLog().debug("Hive box could not be opened. reinitialized");
        return [];
      }

      if (box.isEmpty) {
        AppLog().debug("Cached data not found");
        return [];
      }

      return box.values.map((e) => e).toList();
    } catch (e) {
      AppLog().debug("Error while parsing cached data");
      return [];
    }
  }

  clear() async {
    /// clear database
    await box.clear();
  }
}
