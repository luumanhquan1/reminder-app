import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_state.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/list_group_constants.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/widgets/list_group_widget.dart';

import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';


// ignore: must_be_immutable
class ListGroupScreen extends StatefulWidget {
  final SettingListGroup settingListGroup;
  const ListGroupScreen({Key key, this.settingListGroup}) : super(key: key);
  @override
  _ListReminderpageState createState() => _ListReminderpageState();
}

class _ListReminderpageState extends State<ListGroupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarReminderWidget(
          leading: () {
            Navigator.pop(context);
          },
          textLeft: ListGroupConstants.appBarLeadingTxt,
          title: ListGroupConstants.titleTxt,
          textRight: Text(''),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<ListGroupBloc, ListGroupState>(
              builder: (context, state) {
            return Column(
              children: List.generate(widget.settingListGroup.listGroup.length,
                  (index) {
                return ListGroupWidget(
                  onTap: () {
                    BlocProvider.of<ListGroupBloc>(context)
                        .add(SelectGroupEvent(index));
                    Navigator.pop(
                        context, widget.settingListGroup.listGroup[index]);
                  },
                  isIcon: true,
                  listGroupState: state,
                  title: widget.settingListGroup.listGroup[index].name,
                  color: widget.settingListGroup.listGroup[index].color,
                  index: index,
                );
              }),
            );
          }),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
