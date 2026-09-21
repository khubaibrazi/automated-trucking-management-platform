import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/truck_load.dart';

abstract class LoadStore {
  Future<List<TruckLoad>> getLoads();
  Future<void> saveLoad(TruckLoad load);
}

class SharedPreferencesLoadStore implements LoadStore {
  static const _storageKey = 'trucking_loads';

  @override
  Future<List<TruckLoad>> getLoads() async {
    final preferences = await SharedPreferences.getInstance();
    final encodedLoads = preferences.getStringList(_storageKey) ?? <String>[];

    final loads = encodedLoads
        .map(
          (encoded) => TruckLoad.fromJson(
            jsonDecode(encoded) as Map<String, dynamic>,
          ),
        )
        .toList();

    loads.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return loads;
  }

  @override
  Future<void> saveLoad(TruckLoad load) async {
    final preferences = await SharedPreferences.getInstance();
    final existing = preferences.getStringList(_storageKey) ?? <String>[];
    final updated = <String>[
      jsonEncode(load.toJson()),
      ...existing,
    ];

    final saved = await preferences.setStringList(_storageKey, updated);
    if (!saved) {
      throw StateError('The load could not be saved on this device.');
    }
  }
}
