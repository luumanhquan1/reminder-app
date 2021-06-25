import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/bottom_navigationbar_widget.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/edit_home_page.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/reorderable_sliver_widget.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/search.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/wrap_widget.dart';
import 'package:ghichu/presentation/journey/widgets/app_bar.dart';

import 'bloc/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBarWidget(
              textLeft: '',
              title: '',
              textRight: state.isEdit
                  ? HomePageConstants.editTxt
                  : HomePageConstants.doneTxt,
              color: Colors.blue,
              actions: () {
                BlocProvider.of<HomePageBloc>(context)
                    .add(EditEvent(isEdit: state.isEdit));
              },
            ),
            bottomNavigationBar: BottomNavigationBarWidget(state: state),
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(HomePageConstants.paddingWidth20,
                      0, HomePageConstants.paddingWidth20, 0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SearchWidget(),
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
                ),
                ReorderableSliverWidget(
                  state: state,
                )
              ],
            ));
      },
    );
  }
}
