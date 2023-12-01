import 'dart:math';

class CommonUtils {
  int getRollingNumber(
      {required int min, required int max, required int value}) {
    var difference = (max - min).abs() + 1;

    var finalValue = value;

    if (value < min) {
      var x = min - value;
      var remainder = x % difference;
      if (remainder == 0) {
        finalValue = min;
      } else {
        finalValue = max - remainder + 1;
      }
    }

    if (value > max) {
      var y = value - max;
      var remainder = y % difference;
      if (remainder == 0) {
        finalValue = max;
      } else {
        finalValue = min + remainder - 1;
      }
    }

    return finalValue;
  }
}

List<int> getIntegerList({required int minValue, required int maxValue}) {
  var list = <int>[];
  for (var i = minValue; i <= maxValue; i++) {
    list.add(i);
  }
  return list;
}

String generatePassword({
  bool letter = true,
  bool isNumber = true,
  bool isSpecial = true,
}) {
  const length = 20;
  const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
  const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const number = '0123456789';
  const special = '@#%^*>\$@?/[]=+';

  String chars = "";
  if (letter) chars += '$letterLowerCase$letterUpperCase';
  if (isNumber) chars += number;
  if (isSpecial) chars += special;

  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
}
