import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';

Future sendFileMessage(Map<String, dynamic> mapdata) async {
  FormData formData = new FormData.fromMap(mapdata);
  try {
    final response = await Dio().post(
        'https://cc.rooyatech.com/imApi/sendMessage',
        options: Options(headers: header),
        data: formData);
    print('sendFileMessage responce data is = ${response.data}');
  } catch (e) {
    print('Exception is = $e');
  }
}

Future<String> saveAudioFile(
    {String? url, String? extension, String? fileNName}) async {
  var appDocDir = await getApplicationDocumentsDirectory();
  File vfile2 = new File('${appDocDir.path}' + '/$fileNName');
  if (!vfile2.existsSync()) {
    var response = await Dio().get(
      url!,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    var raf = vfile2.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    print('Saved path is inner = ${raf.path}');
  } else {
    print('Saved path is outer = ${vfile2.path}');
  }
  return vfile2.path;
}

Future<String> uploadFile(String path) async {
  List<MultipartFile> listofFile = <MultipartFile>[];
  String fileName = path.split('/').last;
  listofFile.add(await MultipartFile.fromFile(
    path,
    filename: '$fileName',
  ));
  FormData formData = new FormData.fromMap({"file": listofFile});
  String url = '';
  try {
    final response = await Dio().post(
        'https://cc.rooyatech.com/imApi/PictureUpload',
        options: Options(headers: header),
        data: formData);
    url = response.data;
    return url;
  } catch (e) {
    print('Exception is = $e');
    return 'url';
  }
}
