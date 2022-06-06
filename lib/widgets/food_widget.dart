import 'dart:math';

import 'package:code_resto/models/response.dart';
import 'package:code_resto/services/favoris_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/heartAnimationWidget.dart';
import 'package:code_resto/widgets/price_tag_widget.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodWidget extends StatefulWidget {
  final String? imagePath,
      imageAbo,
      titre,
      descrip,
      price,
      discountPrice,
      id,
      offre,
      offreTitle;
  final Function(int) onAdd, onLove, onClick;
  final int index;
  final bool? hasOffre, likeIt;
  final dynamic pourcentage;
  const FoodWidget({
    Key? key,
    this.imagePath = 'plateau-repas.png',
    this.titre,
    this.descrip,
    this.price,
    required this.onAdd,
    required this.onLove,
    required this.onClick,
    required this.index,
    required this.hasOffre,
    this.pourcentage,
    this.discountPrice,
    this.id,
    this.likeIt,
    this.offre,
    this.offreTitle,
    this.imageAbo,
  }) : super(key: key);

  @override
  State<FoodWidget> createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  String price = '', discountPrice = '';
  FavorisRepo favorisRepo = FavorisRepo();
  late ConfettiController confettiController;

  bool clicked = false;
  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 20),
    );
    confettiController.play();
    iPrint('LIKEE');
    iPrint(widget.likeIt);
    setState(() {
      clicked = widget.likeIt!;
    });

    if (widget.price!.contains('.')) {
      String second;
      int length;
      second = widget.price!.split('.')[1];
      length = second.length;
      if (length <= 3) {
        price = widget.price!;
      } else {
        String afterPointString = '';
        for (int i = 0; i < 3; i += 1) {
          afterPointString += second.split('')[i];
        }
        price = widget.price!.split('.')[0] + '.' + afterPointString;
      }
    }
    if (widget.discountPrice!.contains('.')) {
      String second;
      int length;
      second = widget.discountPrice!.split('.')[1];
      length = second.length;
      if (length <= 3) {
        discountPrice = widget.discountPrice!;
      } else {
        String afterPointString = '';
        for (int i = 0; i < 3; i += 1) {
          afterPointString += second.split('')[i];
        }
        discountPrice =
            widget.discountPrice!.split('.')[0] + '.' + afterPointString;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onClick(widget.index),
      child: Container(
        width: 168.w,
        height: 189.33.h,
        child: Padding(
          padding: EdgeInsets.only(left: 14.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 120.h,
                      width: 124.w,
                      child: Hero(
                        tag: 'image_pos_kit${widget.index}',
                        child: widget.imagePath! == 'plateau-repas.png'
                            ? Image.asset('images/plateau-repas.png')
                            : Image.network(
                                widget.imagePath!,
                                fit: BoxFit.cover,
                                cacheHeight: 150,
                                cacheWidth: 150,
                                filterQuality: FilterQuality.high,
                              ),
                      ),
                    ),
                    widget.hasOffre == null || widget.imageAbo == ''
                        ? const SizedBox()
                        : widget.hasOffre!
                            ? Align(
                                alignment: Alignment.topRight,
                                child: PriceTagWidget(
                                  imageAbo: widget.imageAbo,
                                  pourcentage: widget.pourcentage,
                                ))
                            : const SizedBox(),
                  ],
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  widget.titre!,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: mediumFont,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  widget.descrip!,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xffB1B1B1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
              widget.hasOffre!
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '€$price',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 4,
                                //decorationStyle: TextDecorationStyle.wavy,
                                decorationColor: Colors.red,
                                fontSize: 16.sp,
                                fontWeight: semiBoldFont,
                              ),
                            ),
                            Text(
                              '/€$discountPrice',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: semiBoldFont,
                                //   color: myBlue,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'offre spéciale pour ' + widget.offreTitle!,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      '€$price',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: semiBoldFont,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: InkWell(
                      onTap: () {
                        widget.onAdd(widget.index);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 32.w,
                        width: 32.w,
                        child: const Icon(
                          Icons.add,
                          color: myWhite,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: HeartAnimationWidget(
                      alwaysAnimate: true,
                      isAnimating: clicked,
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            clicked = !clicked;
                          });
                          await favorisRepo.likeMenu(widget.id ?? '');
                        },
                        child: Container(
                          height: 32.w,
                          width: 32.w,
                          child: clicked
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                ),
                          decoration: const BoxDecoration(
                            color: Color(0xffDFDFDF),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /*  child: Padding(
          padding: EdgeInsets.only(left: 14.w),
          child: 
        ), */
        decoration: BoxDecoration(
          color: myWhite,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff959595).withOpacity(0.35),
              blurRadius: 50,
              offset: const Offset(0, 15), // Shadow position
            ),
          ],
        ),
      ),
    );
  }
}
