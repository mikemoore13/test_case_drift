import 'dart:math';
import 'package:fixnum/fixnum.dart';

extension DateTimeExtension on DateTime {
  int get secondsSinceEpoch => (millisecondsSinceEpoch / Duration.millisecondsPerSecond).round();
  static DateTime fromSecondsSinceEpoch(int secondsSinceEpoch) => DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * Duration.millisecondsPerSecond);
}
class Int64IdGenerator {
  static Int64 _counter = Int64(0);
  static Int64  _lastTimestamp = Int64(0);

  static Int64 getTimeStamp()
  {
    return Int64(DateTime.now().toUtc().secondsSinceEpoch - DateTime.utc(2023).secondsSinceEpoch );
  }
  static Int64 next()
  {
    var timestampInSeconds = getTimeStamp();
    if (timestampInSeconds - _lastTimestamp > Int64(1)) {
      _counter = Int64(0);
    }

    if(_counter >= Int64(0xFFFF))
    {
      while(timestampInSeconds - _lastTimestamp < Int64(1))
      {
        timestampInSeconds = getTimeStamp();
      }
      _counter = Int64(0);
    }

    Int64 uniqueId = ((timestampInSeconds & 0xFFFFFFFF) << 32) | ((_counter % 0x10000) << 16) | Random().nextInt(0x10000);

    _counter = (_counter + 1) % 0x10000;
    _lastTimestamp = timestampInSeconds;
    return uniqueId;
  }

}