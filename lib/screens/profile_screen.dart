import 'dart:io';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/models/profile.dart';
import 'package:code_resto/models/response.dart';
import 'package:code_resto/models/specefic_abonnement.dart';
import 'package:code_resto/screens/edit_profile_screen.dart';
import 'package:code_resto/screens/home_screen.dart';
import 'package:code_resto/services/abonnement_repo.dart';
import 'package:code_resto/services/google_sign_in.dart';
import 'package:code_resto/services/image_repo.dart';
import 'package:code_resto/services/profile_repo.dart';
import 'package:code_resto/utils/classic_image_picker.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/bottom_sheet_image_widget.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_title_button_widget.dart';
import 'package:code_resto/widgets/my_title_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileRepo profileRepo = ProfileRepo();
  GoogleSgnIn googleSgnIn = GoogleSgnIn();
  final AbonnnementRepo _abonnnementRepo = AbonnnementRepo();
  SpeceficAbonnement speceficAbonnement = SpeceficAbonnement();
  ClassicImagePicker classicImagePicker = ClassicImagePicker();
  bool done = false;
  bool? isSubscribed;
  Profile profile = Profile();
  getProfile() async {
    Response response = await profileRepo.getProfileData();
    if (response.result) {
      profile = response.data['profile'];
      var resp = await _abonnnementRepo.getMyAbonnement();
      iPrint(resp.data['abonnement']);
      resp.result
          ? speceficAbonnement = resp.data['abonnement']
          : Navigator.pushNamed(context, '/oops_404');
      print(speceficAbonnement.results?.isEmpty);
    } else {
      Navigator.pushNamed(context, '/oops_404');
    }
    if (mounted) {
      setState(() {
        done = true;
      });
      if (done) {
        setState(() {
          isSubscribed = speceficAbonnement.results!.isNotEmpty;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
    final p = Provider.of<ProfileRepo>(context, listen: false);
    iPrint('NAME');

    iPrint(p.getProfileData().then((value) => iPrint(p.profile.email)));
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ProfileRepo>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                showLoader(context);
                await disconnect();
                p.profile = Profile();
                await googleSgnIn.googleOut();
                // await clearStorage();
                hideLoader(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/first_screen', (route) => false);
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).primaryColor,
              ))
        ],
        title: const Text('Profile'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyTitleWidgetButton(
            borderRadius: 10,
            onTap: () => Navigator.popUntil(
              context,
              ModalRoute.withName('/home_screen'),
            ),
            title: const Icon(
              Icons.arrow_back_ios_new,
              size: 15,
            ),
            boxShadow: MyBoxShadow(),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          const FullScreenWidget(),
          Padding(
            padding: EdgeInsets.only(top: 46.h),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 150.h,
                    width: 150.w,
                    child: !p.done
                        ? const CircularProgressIndicator()
                        : Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 130.h,
                                  width: 130.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'images/profile_image.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              p.profile.photoProfil == ''
                                  ? const SizedBox()
                                  : Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 130.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                p.profile.photoProfil ?? ''),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) =>
                                            BottomSheetImagePickerWidget(
                                                onCameraClick: () async {
                                              var file =
                                                  await classicImagePicker
                                                      .pickImageFromGallery(
                                                          ImageSource.camera);
                                              Navigator.pop(context);
                                              if (file != null) {
                                                Response response =
                                                    await futureMethod(
                                                        ImageRepo().uploadImage(
                                                            File(file.path)),
                                                        context);
                                                response.result
                                                    ? setState(() {
                                                        futureMethod(
                                                            getProfile(),
                                                            context);
                                                      })
                                                    : showToast(
                                                        response.message,
                                                      );
                                              }
                                            }, onGalerryClick: () async {
                                              var file =
                                                  await classicImagePicker
                                                      .pickImageFromGallery(
                                                          ImageSource.gallery);
                                              Navigator.pop(context);
                                              if (file != null) {
                                                Response response =
                                                    await futureMethod(
                                                        ImageRepo().uploadImage(
                                                            File(file.path)),
                                                        context);
                                                response.result
                                                    ? setState(() {
                                                        futureMethod(
                                                            getProfile(),
                                                            context);
                                                      })
                                                    : showToast(
                                                        response.message,
                                                      );
                                              }
                                            })));
                                  },
                                  icon: Icon(
                                    profile.photoProfil != ''
                                        ? Icons.camera_alt_rounded
                                        : Icons.add_a_photo,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).secondaryHeaderColor,
                          width: 2.2.w),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 250.w,
                    child: Text(
                      '${p.profile.nom ?? ''} ${p.profile.prenom ?? ''}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: semiBoldFont,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: getWidth(context) / 2.2,
                          child: Text(
                            p.profile.email ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff707070)),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: getWidth(context) / 5,
                          child: Text(
                            p.profile.phone ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff707070)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  isSubscribed == null
                      ? const CircularProgressIndicator()
                      : !isSubscribed!
                          ? MyTitleButton(
                              width: 150.w,
                              onTap: () => Navigator.pushNamed(
                                  context, '/abonnement_screen'),
                              color: Theme.of(context).secondaryHeaderColor,
                              border: true,
                              titleColor: myBlack,
                              boxShadow: MyBoxShadow(),
                              title: 'S\'abonner',
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: ListTile(
                                  title: Text(
                                      '${speceficAbonnement.results?[0].linkedOptionAbonnements?[0].titre}'),
                                  subtitle: Row(
                                    children: [
                                      const Flexible(
                                          flex: 2,
                                          child: Text(
                                            'expire le ',
                                            style: TextStyle(color: Colors.red),
                                          )),
                                      Flexible(
                                        flex: 3,
                                        child: Text(
                                          '${speceficAbonnement.results?[0].expidation?.date.toString().split(' ')[0]}',
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading:
                                      const Icon(Icons.card_membership_rounded),
                                  /*  trailing: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/abonnement_screen');
                                },
                                icon: const Icon(Icons.edit),
                              ), */
                                ),
                              ),
                            )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MyTitleButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      profile: profile,
                    ),
                  ),
                ),
                boxShadow: MyBoxShadow(),
                title: 'Editer Profile',
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
