import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/models/profile.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/profile_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/utils/validators.dart';
import 'package:code_resto/widgets/costum_form_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:code_resto/widgets/my_title_widget_button.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile? profile;
  const EditProfileScreen({Key? key, this.profile}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nomTxtController = TextEditingController(),
      prenomTxtController = TextEditingController(),
      phoneTxtController = TextEditingController();
  ProfileRepo profileRepo = ProfileRepo();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nomTxtController.text = widget.profile?.nom ?? '';
    prenomTxtController.text = widget.profile?.prenom ?? '';
    phoneTxtController.text = widget.profile?.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Editer Profile'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyTitleWidgetButton(
            borderRadius: 10,
            onTap: () {
              hideKeyboard(context);
              Navigator.pop(context);
            },
            title: const Icon(
              Icons.arrow_back_ios_new,
              size: 15,
            ),
            color: Theme.of(context).primaryColor,
            boxShadow: MyBoxShadow(),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: getWidth(context),
          height: getHeight(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomInputWidget(
                      //showLabel: false,
                      //formater: maskEMpty,
                      onTap: () {},
                      // enableField: enablemail,
                      hintText: 'Nom',
                      hintColor: mygreyBg,
                      //controller: civliliteController,
                      validator: (String? v) {
                        return Validators.validateName(v!);
                      },
                      controller: nomTxtController,
                    ),
                    CustomInputWidget(
                      //showLabel: false,
                      //formater: maskEMpty,
                      onTap: () {},
                      // enableField: enablemail,
                      hintText: 'Prénom',
                      hintColor: mygreyBg,

                      //controller: civliliteController,
                      validator: (String? v) {
                        return Validators.validateName(v!);
                      },
                      controller: prenomTxtController,
                    ),
                    CustomInputWidget(
                      keyboardType: TextInputType.phone,
                      //showLabel: false,
                      //formater: maskEMpty,
                      onTap: () {},
                      // enableField: enablemail,
                      hintText: 'Numéro de téléphone',
                      hintColor: mygreyBg,
                      //controller: civliliteController,
                      validator: (String? v) {
                        return Validators.validatePhone(v!);
                      },
                      controller: phoneTxtController,
                    ),
                  ],
                ),
                MyTitleButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Response response = await futureMethod(
                          profileRepo.updateProfile(
                              nomTxtController.text,
                              prenomTxtController.text,
                              widget.profile?.ville ?? '',
                              widget.profile?.addresse ?? '',
                              widget.profile?.pays ?? '',
                              0,
                              phoneTxtController.text),
                          context);
                      if (response.result) {
                        hideKeyboard(context);
                        Navigator.pushNamed(context, '/profile_screen');
                      } else {
                        showToast(response.message);
                      }
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  boxShadow: MyBoxShadow(),
                  title: 'Enregistrer',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
