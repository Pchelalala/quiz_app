import 'dart:async';
import 'package:sembast/sembast.dart';
import '../models/true_or_false_model.dart';
import 'app_database.dart';
import 'dao_api.dart';

typedef DatabaseSnapshotListTrueOrFalse
    = List<RecordSnapshot<int?, Map<String, dynamic>>>;

class HomeDaoTrueOrFalse implements DaoApi<TrueOrFalseModel?> {
  static const String homeStore = 'home_store';

  final StoreRef<int?, Map<String, Object?>> _homeStore =
      intMapStoreFactory.store(homeStore);

  Future<Database> get _db async => AppDatabase.instance.database;

  Future clearArtStore() async {}

  @override
  Future<void> delete(TrueOrFalseModel? model) async {
    final finder = Finder(filter: Filter.byKey(model!.id));
    await _homeStore.delete(await _db, finder: finder);
  }

  @override
  Future<TrueOrFalseModel?> get(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final RecordSnapshot? recordSnapshot =
        await _homeStore.findFirst(await _db, finder: finder);
    return recordSnapshot != null
        ? TrueOrFalseModel.fromJson(
            recordSnapshot.value as Map<String, dynamic>)
        : null;
  }

  @override
  Future<List<TrueOrFalseModel>> getAll() async {
    final recordSnapshots = await _homeStore.find(await _db);
    return recordSnapshots
        .map((snapshot) => TrueOrFalseModel.fromJson(snapshot.value))
        .toList();
  }

  @override
  Future<void> save(TrueOrFalseModel? model) async {
    await _homeStore.record(model!.id).put(await _db, model.toJson());
  }

  @override
  Future<void> update(TrueOrFalseModel? model) async {
    final finder = Finder(filter: Filter.byKey(model!.id));
    await _homeStore.update(await _db, model.toJson(), finder: finder);
  }

  @override
  Future<void> clearStore() async {
    await _homeStore.delete(await _db);
  }

  /// The data type in [onDataChanged] functions should match the type of the [_homeStore]
  /// In our case we [_homeStore] is [intMapStoreFactory], so one element of the resulting list
  /// should be RecordSnapshot<int?, Map<String, dynamic>>
  Future<StreamSubscription> listenToUpdates(
      Function(DatabaseSnapshotListTrueOrFalse) onDataChanged) async {
    final db = await _db;
    final query = _homeStore.query();
    final subscription = query.onSnapshots(db).listen((snapshots) {
      // snapshots always contains the list of records matching the query
      onDataChanged(snapshots);
    });

    return subscription;
  }

  static List<TrueOrFalseModel> snapshotsToItemsList(
      DatabaseSnapshotListTrueOrFalse snapshots) {
    return snapshots
        .map((snapshot) => TrueOrFalseModel.fromJson(snapshot.value))
        .toList();
  }
}
