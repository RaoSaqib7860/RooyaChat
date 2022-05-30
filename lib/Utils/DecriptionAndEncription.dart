import 'package:encrypt/encrypt.dart';

String decrypString({String? encript, String? pass}){
  final key = Key.fromUtf8('$pass');
  final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
   print('dddddd ${encrypter.decrypt64('$encript', iv: IV.fromLength(16))}');
   return encrypter.decrypt64('$encript', iv: IV.fromLength(16));
}