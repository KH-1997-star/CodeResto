import 'package:code_resto/models/response.dart';
import 'package:code_resto/models/tags.dart';
import 'package:code_resto/services/plat_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchByTagsWidget extends StatefulWidget {
  final Widget? firstSearchWidget, myWidget;
  final String? title;
  final int numOfTags;
  final double iconTagsSpace, spaceBetwennTags;
  final Function(int, List<String>) onTag;
  final VoidCallback onSearch;
  const SearchByTagsWidget({
    Key? key,
    this.firstSearchWidget,
    this.myWidget,
    this.title,
    required this.numOfTags,
    this.iconTagsSpace = 0,
    this.spaceBetwennTags = 0,
    required this.onTag,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchByTagsWidget> createState() => _SearchByTagsWidgetState();
}

class _SearchByTagsWidgetState extends State<SearchByTagsWidget> {
  List<String> tagsStr = [];
  bool tagsGet = false;
  PlatRepo platRepo = PlatRepo();
  Tags tags = Tags();
  List<bool> tagsBoolList = [];
  getTags() async {
    Response response = await platRepo.getAllTags();
    if (response.result) {
      tags = response.data['tags'];
      iPrint(tags.results!.length);
      for (int i = 0; i < tags.results!.length; i += 1) {
        tagsBoolList.add(false);
      }
      iPrint(tagsBoolList);
      setState(() {
        tagsGet = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTags();
  }

  int? clickedIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => widget.onSearch(),
          child: widget.firstSearchWidget ?? const SizedBox(),
        ),
        SizedBox(
          width: widget.iconTagsSpace,
        ),
        SizedBox(
          height: 100,
          width: getWidth(context) - 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => !tagsGet
                ? SizedBox(
                    width: 50.w,
                    height: 50.w,
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SizedBox(),
                    ))
                : Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            tagsBoolList[index] = !tagsBoolList[index];
                          });
                          tagsBoolList[index]
                              ? tagsStr.add(
                                  '&tags[in]=${tags.results?[index].identifiant}')
                              : tagsStr.remove(
                                  '&tags[in]=${tags.results?[index].identifiant}');

                          widget.onTag(index, tagsStr);
                        },
                        child: widget.myWidget ??
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17.r),
                                color: tagsBoolList[index]
                                    ? Theme.of(context).primaryColor
                                    : myTransparent,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11.5.w, vertical: 7.h),
                                child: Text(
                                  tags.results?[index].libelle ?? 'inconnu',
                                  style: TextStyle(
                                    color:
                                        tagsBoolList[index] ? myWhite : myBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                      ),
                      SizedBox(
                        width: widget.spaceBetwennTags,
                      ),
                    ],
                  ),
            itemCount: tagsGet ? tags.results!.length : 5,
          ),
        )
      ],
    );
  }
}
