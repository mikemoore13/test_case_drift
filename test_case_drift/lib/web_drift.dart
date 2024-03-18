import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

import 'package:test_case_drift/database.dart';


AppDatabase constructDb() {



  return AppDatabase(
      DatabaseConnection.delayed(
        Future.sync(() async {
          final db = await WasmDatabase.open(
            databaseName: 'db',
            sqlite3Uri: Uri.parse('/sqlite3.wasm'),
            driftWorkerUri: Uri.parse('/drift_worker.js'),
          );

          if (db.missingFeatures.isNotEmpty) {
            print('Using ${db.chosenImplementation} due to unsupported '
                'browser features: ${db.missingFeatures}');
          }
          return db.resolvedExecutor;
        }),
      )
  );
}