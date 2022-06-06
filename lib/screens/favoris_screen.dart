import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/models/favoris.dart';
import 'package:code_resto/services/favoris_repo.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/bottom_navig_bar.dart';
import 'package:code_resto/widgets/full_screen_widget.dart';
import 'package:code_resto/widgets/my_title_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({Key? key}) : super(key: key);

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  final FavorisRepo _favorisRepo = FavorisRepo();
  Favoris favoris = Favoris();
  getFavoris() async {
    var response = await _favorisRepo.viewMyLikeList();
    if (response.result) {
      favoris = response.data['favoris'];
    } else if (!response.result && response.message == '401') {
      await disconnect();
      Navigator.pushNamed(context, '/first_screen');
    } else {
      Navigator.pushNamed(context, '/oops_404');
    }
    if (mounted) {
      setState(() {
        done = true;
      });
    }
  }

  bool done = false;

  bool? result;

  @override
  void initState() {
    super.initState();
    final favorisProvider = Provider.of<FavorisRepo>(context, listen: false);
    favorisProvider.viewMyLikeList();
    getFavoris();
  }

  @override
  Widget build(BuildContext context) {
    final favorisProvider = Provider.of<FavorisRepo>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home_screen');
        return false;
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/home_screen');
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Favoris',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTitleWidgetButton(
                  color: Theme.of(context).primaryColor,
                  borderRadius: 10,
                  onTap: () => Navigator.pushNamed(context, '/home_screen'),
                  title: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                  ),
                  boxShadow: MyBoxShadow(),
                ),
              ),
            ),
            body: !favorisProvider.done
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      const FullScreenWidget(),
                      favorisProvider.favoris.results!.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'icons/love_grey.svg',
                                    height: 51.62.h,
                                    width: 58.82.w,
                                  ),
                                  SizedBox(
                                    height: 22.4.h,
                                  ),
                                  Text(
                                    'Vous n\'avez aucun favoris',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xffAFAFAF),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(
                                  top: 30.h,
                                  left: 32.w,
                                  right: 12.w,
                                  bottom: 75.h),
                              itemCount:
                                  favorisProvider.favoris.results?.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: ListTile(
                                  trailing: IconButton(
                                    onPressed: () async {
                                      showLoader(context);
                                      var resp = await _favorisRepo.likeMenu(
                                        favorisProvider.favoris.results?[index]
                                                .menu?[0].identifiant ??
                                            '',
                                      );
                                      resp.result
                                          ? Navigator.pushNamed(
                                              context, '/favoris_screen')
                                          : showToast(resp.message);

                                      hideLoader(context);
                                    },
                                    icon: const Icon(Icons.favorite,
                                        color: Colors.red),
                                  ),
                                  subtitle: Text(
                                    '${favorisProvider.favoris.results?[index].menu?[0].description}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  title: Text(
                                    '${favorisProvider.favoris.results?[index].menu?[0].titre}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: favorisProvider
                                                .favoris
                                                .results?[index]
                                                .menu?[0]
                                                .image ==
                                            ''
                                        ? Image.asset(
                                            'icons/restaurant_icon.png')
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              favorisProvider
                                                      .favoris
                                                      .results?[index]
                                                      .menu?[0]
                                                      .image ??
                                                  '',
                                              height: 50.h,
                                              width: 50.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: const BottomNavigBar(
                            pageIndex: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
