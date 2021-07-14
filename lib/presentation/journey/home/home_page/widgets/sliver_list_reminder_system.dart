import 'package:flutter/material.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/wrap_widget.dart';

import '../home_page_constants.dart';
import 'edit_home_page.dart';
class SliverReminderWidget extends StatelessWidget {
  final InitHomePageState state;

  const SliverReminderWidget({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(HomePageConstants.paddingWidth20, 0,
          HomePageConstants.paddingWidth20, 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Stack(
              children: [
                WrapWidget(
                  state: state,
                ),
                EditWidget(
                  state: state,
                ),
              ],
            ),
            SizedBox(
              height: HomePageConstants.paddingHeight10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: HomePageConstants.paddingHeight10,
                  left: HomePageConstants.paddingWidth10),
              child: Text(
                HomePageConstants.myListTxt,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: HomePageConstants.screenUtileSp20),
              ),
            ),
            SizedBox(
              height: HomePageConstants.paddingHeight10,
            ),
          ],
        ),
      ),
    );
  }
}
