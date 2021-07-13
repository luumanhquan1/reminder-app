import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/stickey_reminder_widget.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';
class SliverReminderSearchWidget extends StatelessWidget {
  final InitHomePageState state;

  const SliverReminderSearchWidget({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SliverVisibility(
        visible: state.isSearchTxtEmty,
        sliver: BlocBuilder<ManageReminderBloc,ManageReminderState>(
          builder: (context,stateReminder){
           if(stateReminder is InitManagerReminderState){
             return SliverList(
               delegate: SliverChildListDelegate(
                   List.generate(stateReminder.listReminder.keys.length, (index){
                    String group=stateReminder.listReminder.keys.elementAt(index);
                     return StickyReminderSearch(
                       state: stateReminder,

                       listGroup: state.keyMyList,

                       indexGroup: index,
                       listReminder: stateReminder.listReminder[group],
                       header: group,
                       color: Colors.blue.value.toString(),
                     );
                   })),
             );
           }
           return SizedBox();
          },
        ));
  }
}

