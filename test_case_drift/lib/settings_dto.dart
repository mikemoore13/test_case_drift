import 'package:drift/drift.dart';
import 'package:test_case_drift/id_generator.dart';
import 'package:fixnum/fixnum.dart';
extension Int64Extension on Int64 {
  BigInt toBigInt() => BigInt.parse(toRadixString(16), radix: 16);
}
BigInt buildId()
{
  return Int64IdGenerator.next().toBigInt();
}


@DataClassName('SETTINGS_TABLE')
class SettingsDto  extends Table {
  Int64Column get id => int64().clientDefault(() => buildId())();
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<Set<Column>> get uniqueKeys => [{key}];
}