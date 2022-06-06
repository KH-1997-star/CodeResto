import 'dart:io';

import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/image_repo.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetImagePickerWidget extends StatelessWidget {
  final VoidCallback onCameraClick, onGalerryClick;
  const BottomSheetImagePickerWidget(
      {Key? key, required this.onCameraClick, required this.onGalerryClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            'changer votre photo',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    onCameraClick();
                    /*   var file = await classicImagePicker
                        .pickImageFromGallery(ImageSource.camera);
                    Navigator.pop(context);
                    if (file != null) {
                      print('heelo');
                      Response response = await futureMethod(
                          ImageRepo().uploadImage(File(file.path)), context);
                      response.result
                          ? setState(() {
                              futureMethod(getDetailProfile(), context);
                            })
                          : showToast(response.message, context);
                    } */
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              TextButton.icon(
                  onPressed: () {
                    onGalerryClick();
                    /*  var file = await classicImagePicker
                        .pickImageFromGallery(ImageSource.gallery);
                    Navigator.pop(context);
                    if (file != null) {
                      Response response = await futureMethod(
                          ImageRepo().uploadImage(File(file.path)), context);
                      response.result
                          ? setState(() {
                              futureMethod(getDetailProfile(), context);
                            })
                          : showToast(response.message, context);
                    } */
                  },
                  icon: Icon(Icons.image),
                  label: Text('Galerie'))
            ],
          )
        ],
      ),
    );
  }
}
