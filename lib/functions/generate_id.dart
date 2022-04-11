import 'dart:math';

class GenerateId {
  static String generateId(int length) {
    StringBuffer id = StringBuffer();
    String chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random random = Random();

    while (id.length < length) {
      id.write(
          String.fromCharCode(chars.codeUnitAt(random.nextInt(chars.length))));
    }

    return id.toString();
  }
}
