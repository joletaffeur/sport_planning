
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

Future<DatabaseConnection> createConnection() async {
  final result = await WasmDatabase.open(
    databaseName: 'sport_planning',

    sqlite3Uri: Uri.parse('sqlite3.wasm'),

    driftWorkerUri: Uri.parse('drift_worker.js'),
  );

  return result.resolvedExecutor;
}