import 'package:code_resto/models/detail_menu.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/fonts.dart';
import 'package:code_resto/models/box_shadow.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:code_resto/widgets/circle_container_widget.dart';
import 'package:code_resto/widgets/radio_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailMenuWidget extends StatefulWidget {
  final String titre;
  final List<String> itemName, itemId;
  final List<String>? fromPanierNameList;

  final int numItem, qteMax;
  final List<bool> boolList;
  final bool isOblig, fromPanier;
  final List prix;
  final List? qte;

  final Function(List<bool> list, List<String> itemList, dynamic prix,
      String id, dynamic qte, bool, String item) onChoice;
  final Function(
    List<bool> list,
    String taille,
    dynamic prix,
    String id,
    int index,
  )? onTailleChoice;

  const DetailMenuWidget({
    Key? key,
    required this.titre,
    required this.numItem,
    required this.itemName,
    required this.qteMax,
    required this.boolList,
    required this.onChoice,
    this.isOblig = false,
    required this.prix,
    this.onTailleChoice,
    required this.itemId,
    this.qte,
    this.fromPanierNameList,
    this.fromPanier = false,
  }) : super(key: key);

  @override
  State<DetailMenuWidget> createState() => _DetailMenuWidgetState();
}

class _DetailMenuWidgetState extends State<DetailMenuWidget> {
  bool hide = false;

  List<bool> boolList = [];
  List<String> itemList = [];
  String firsTaille = '';
  @override
  void initState() {
    iPrint('HELLO');
    if (widget.fromPanier) {
      itemList = widget.fromPanierNameList ?? [];
      boolList = widget.boolList;
    } else {
      for (int i = 0; i < widget.itemName.length; i += 1) {
        boolList.add(false);
      }
    }

    super.initState();
    iPrint(
        'itemList : $itemList \n boolList $boolList \n qteMaw ${widget.qteMax}  ');

    iPrint(boolList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40.h,
          width: getWidth(context),
          decoration: BoxDecoration(
            color: const Color(0xffBBBBBB).withOpacity(0.32),
            border: hide
                ? Border(
                    bottom: BorderSide(
                      width: 1.5,
                      color: const Color(0xffBBBBBB).withOpacity(0.50),
                    ),
                  )
                : const Border(),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 50.w, right: 41.8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: 190.w,
                          child: Text(
                            widget.titre,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: semiBoldFont,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: 150.w,
                          child: Text(
                            widget.isOblig ? '' : '(max : ${widget.qteMax})',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: lightFont,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: CircularContainerWidget(
                    height: 25,
                    width: 25,
                    boxShadow: MyBoxShadow(),
                    onTap: () => setState(() {
                      hide = !hide;
                    }),
                    color: myWhite,
                    myWidget: Center(
                      child: hide
                          ? const Icon(Icons.arrow_drop_down_sharp)
                          : const Icon(Icons.arrow_drop_up_sharp),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        !hide
            ? SizedBox(
                height: widget.numItem * 55.h,
                width: getWidth(context),
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 50.h),
                  itemCount: widget.numItem,
                  itemBuilder: (conext, index) {
                    String prix = widget.prix[index] == 0
                        ? ''
                        : '(${widget.prix[index]}€)';
                    return Row(
                      children: [
                        RadioButtonWidget(
                          prix: widget.prix[index],
                          qteMax: widget.qteMax,
                          clicked: widget.boolList[index],
                          title: '${widget.itemName[index]}      $prix',
                          onChoice: (
                            item,
                            prix,
                          ) {
                            iPrint(item);
                            iPrint('Prix: $prix');
                            iPrint(widget.boolList[index]);
                            if (!widget.isOblig) {
                              if (itemList.length < widget.qteMax &&
                                  !widget.boolList[index]) {
                                iPrint('T3ADINA');
                                boolList[index] = !boolList[index];
                                itemList.add(item);
                                iPrint(widget.itemId[index]);
                                widget.onChoice(
                                    boolList,
                                    itemList,
                                    prix,
                                    widget.itemId[index],
                                    widget.qteMax,
                                    true,
                                    item);
                              } else if (itemList.length <= widget.qteMax &&
                                  widget.boolList[index]) {
                                iPrint(
                                    'itemList : $itemList \n boolList $boolList \n qteMaw ${widget.qteMax}  ');
                                boolList[index] = false;
                                iPrint(item);
                                itemList.remove(item);
                                iPrint(itemList);
                                widget.qteMax ==
                                    widget.onChoice(
                                        boolList,
                                        itemList,
                                        -prix,
                                        widget.itemId[index],
                                        widget.qteMax,
                                        false,
                                        item);
                              }
                            } else {
                              for (int i = 0; i < boolList.length; i += 1) {
                                if (index == i) {
                                  boolList[index] = true;
                                } else {
                                  boolList[i] = false;
                                }
                              }
                              print('ITEEEM');
                              print(index);
                              print(widget.itemId[index]);
                              widget.onTailleChoice!(boolList, item, prix,
                                  widget.itemId[index], index);
                            }
                          },
                        ),
                      ],
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
