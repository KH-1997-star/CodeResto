import 'dart:convert';
import 'dart:io';

import 'package:code_resto/models/response.dart' as resp;
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ImageRepo {
  String urlUploadImage = '${hostDynamique}upload',
      urlUpdateImage = '${hostDynamique}update/';

  Future<resp.Response> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    // var body = {'file': file};
    Dio dio = Dio();
    try {
      var response = await dio.post(
        urlUploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        resp.Response? finalResponse;
        iPrint('Uploaded');
        iPrint(response.data);
        resp.Response r = await updateImage(response.data);
        r.result
            ? finalResponse = resp.Response({
                'image': response.data,
              }, true)
            : finalResponse = resp.Response({}, false, message: r.message);
        return finalResponse;
      } else {
        iPrint(response.statusCode);
        return resp.Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('EXception $e');
      return resp.Response({}, false, message: erreurCnx);
    }
  }

  Future<resp.Response> updateImage(String idImg) async {
    String? id = await getCurrentId();
    Map body = {
      'extraPayload': {
        'photoProfil': idImg,
      }
    };
    try {
      var response = await http.post(
        Uri.parse('$urlUpdateImage$id'),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        iPrint('Doneeee');
        iPrint(response.statusCode);
        iPrint(response.body);
        return resp.Response({}, true);
      } else {
        iPrint(response.body);
        iPrint('NOOOOO');
        return resp.Response({}, false, message: erreurUlterieur);
      }
    } catch (e) {
      iPrint('Exceptioon');
      iPrint(e);
      return resp.Response({}, false, message: erreurCnx);
    }
  }
}
