import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/common/constants/string_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/widgets/icon_widget.dart';

class SightWidget extends StatelessWidget {
  final int index;
  final IconData reminderIcon;
  final String reminderTxt;
  final int reminderLeght;
  final Color reminderColor;
  final String routeName;
  final List<GroupEntity> listGroup;
  const SightWidget(
      {Key key,
      @required this.index,
      @required this.reminderColor,
      @required this.reminderIcon,
      @required this.reminderTxt,
      @required this.reminderLeght,
      @required this.routeName,
       this.listGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (listGroup != null) {
          Navigator.pushNamed(context, routeName,
              arguments: SettingAllReminder(listGroup: listGroup));
        } else {
          Navigator.pushNamed(context, routeName);
        }
        // if (HomePageConstants.list[index]['title'] == 'Today') {
        //   Navigator.pushNamed(context, HomePageConstants.list[index]['push'],arguments: {StringConstants.keyGroup:null})
        //       .whenComplete(() {
        //     // homePageBloc.update();
        //   });
        // } else {
        //   Navigator.pushNamed(context, HomePageConstants.list[index]['push'])
        //       .whenComplete(() {
        //     // homePageBloc.update();
        //   });
        // }
      },
      child: Container(
          margin: EdgeInsets.only(top: HomePageConstants.paddingHeight20),
          width: index == 2
              ? double.infinity
              : ScreenUtil().screenWidth / 2 - HomePageConstants.widthContainer,
          height: HomePageConstants.heightContainer,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(HomePageConstants.radiusCircle15)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                HomePageConstants.paddingWidth10,
                HomePageConstants.paddingHeight10,
                HomePageConstants.paddingWidth20,
                HomePageConstants.paddingHeight10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconWidget(
                      icon: reminderIcon,
                      shadow: 0,
                      color: reminderColor,
                      colorGraient: reminderColor,
                    ),
                    Text(
                      '$reminderLeght',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(37)),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '$reminderTxt',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.w700),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
