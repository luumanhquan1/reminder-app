

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ghichu/common/constants/layout_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/common/untils/priority_untils.dart';
import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/bloc/priority_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/bloc/priority_state.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/widgets/list_group_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';


import 'bloc/priority_event.dart';

class PrioritiesScreen extends StatefulWidget {
  @override
  _PrioritiesScreenState createState() => _PrioritiesScreenState();
}

class _PrioritiesScreenState extends State<PrioritiesScreen> {
  String priority='Không có';
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarReminderWidget(
        leading: () {
          Navigator.pop(context, SettingPriority(priority: priority,indexSelect: index));
        },
        textLeft: 'Chi tiết',
        isIconEdit: false,
        title: 'Mức ưu tiên',
        textRight: SizedBox(),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingHorizontalApp),
        child: BlocBuilder<PriorityBloc, PriorityState>(
          builder: (context, state) {
            return Column(
              children: List.generate(
                  ModelListReminder.reminderApp['priorities'].length,
                  (index) {
                String title= ModelListReminder.reminderApp['priorities'][index ]['name'];
                return ListGroupWidget(
                  onTap: () {
                    BlocProvider.of<PriorityBloc>(context)
                        .add(SelectPriortyEvent(indexSelect: index));
                    priority = getPriorty(index);
                    this.index=index;
                  },
                  priorityState: state,
                  isIcon: false,
                  index: index,
                  title: title,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
