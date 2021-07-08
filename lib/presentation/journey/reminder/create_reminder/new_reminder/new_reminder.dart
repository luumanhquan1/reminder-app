
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/constants/layout_constants.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_state.dart';

import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/widgets/time_widget.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/bloc/new_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/bloc/new_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/bloc/new_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/new_reminder_constants.dart';

import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/select_container.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/text_filed_title_note.dart';
import 'package:ghichu/presentation/journey/widgets/app_bar.dart';
import 'package:ghichu/presentation/journey/widgets/show_model_button_sheet.dart';
import 'package:ghichu/presentation/view_state.dart';

class NewReminderPage extends StatefulWidget {
  final SettingNewReminder settingNewReminder;

  const NewReminderPage({Key key, this.settingNewReminder}) : super(key: key);

  @override
  _NewReminderPageState createState() => _NewReminderPageState();
}

class _NewReminderPageState extends State<NewReminderPage> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  int indexSelect = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.settingNewReminder.isEditReminder) {
        setData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewReminderBloc, NewReminderState>(
        listener: (context, state) {
      if (state is PushToDetailState) {
        Navigator.pushNamed(context, RouteList.details,
                arguments: SettingDetails(
                    group: state.group,
                    note: noteController.text,
                    title: titleController.text,
                    state: state.initDetailsState))
            .then((value) {
          SettingDetails settingDetails = value;
          if (settingDetails != null) {
            BlocProvider.of<NewReminderBloc>(context).add(
                UpDateNewReminderDetailsEvent(
                    initDetailsState: settingDetails.state,
                    isDateDetails: settingDetails.state.isDateSwitch));
          }
        });
      }
      if (state is PushToListGroupState) {
        Navigator.pushNamed(context, RouteList.listGroup,
                arguments: SettingListGroup(
                    listGroup: widget.settingNewReminder.listGroup,
                    group: state.groups))
            .then((value) {
          GroupEntity groups = value as GroupEntity;
          BlocProvider.of<NewReminderBloc>(context)
              .add(UpDateNewReminderListGroupEvent(groups: groups));
        });
      }
      if (state is InitialNewReminderState) {
        if (state.viewState == ViewState.success)
          Navigator.pop(context, 'done');
      }
    }, builder: (context, state) {
      if (state is InitialNewReminderState) {
        return Scaffold(
          backgroundColor: Colors.white.withOpacity(0.95),
          appBar: appBar(state),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.paddingHorizontalApp,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleNoteWidget(
                    onChange: (value) {
                      String result = value;
                      BlocProvider.of<NewReminderBloc>(context)
                          .add(ActiveBtn(activeBtn: result.trim().isNotEmpty));
                    },
                    titleController: titleController,
                    noteController: noteController,
                  ),
                  widget.settingNewReminder.isEditReminder
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: ReminderContants.marginTop),
                          child: BlocBuilder<DetailsBloc, DetailsState>(
                            builder: (context, state) {
                              return TimeWidget(
                                state: state,
                              );
                            },
                          ))
                      : SelectContainer(
                          title: ReminderContants.detailsTxt,
                          buttonDetails: state.isDateDetails,
                          timeDetails: state.timeDateDetails,
                          onTap: () {
                            BlocProvider.of<NewReminderBloc>(context)
                                .add(PushDetailEvent());
                          },
                        ),
                  SelectContainer(
                    title: ReminderContants.listTxt,
                    buttonDetails: false,
                    group: state.groups.name,
                    color: state.groups.color,
                    onTap: () {
                      BlocProvider.of<NewReminderBloc>(context)
                          .add(PushListGroupEvent());
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }
      return Material(
        color: Colors.transparent,
      );
    });
  }

  Widget appBar(InitialNewReminderState state) {
    return AppBarWidget(
      actions: state.activeBtn
          ? () {
              if (widget.settingNewReminder.isEditReminder == false) {
                BlocProvider.of<NewReminderBloc>(context).add(AddReminderEvent(
                    title: titleController.text,
                    note: noteController.text,
                    date: state.date,
                    group: state.groups.name,
                    priority: state.groups.name));
              } else {
                InitDetailsState detailsState =
                    BlocProvider.of<DetailsBloc>(context).state;
                BlocProvider.of<NewReminderBloc>(context).add(EditReminderEvent(
                  oldReminder: widget.settingNewReminder.reminderEntity,
                  title: titleController.text,
                  note: noteController.text,
                  date: detailsState.selectDate,
                  time: detailsState.timeOfDay,
                  group: state.groups.name,
                  isDate: detailsState.isDateSwitch,
                  isTime: detailsState.isTimeSwitch,
                ));
              }
            }
          : null,
      leading: showBttomSheet(state)
          ? () {
              showButtonModalSheet(context);
            }
          : () {
              Navigator.pop(context);
            },
      color: state.activeBtn ? Colors.blue : Colors.black38,
      textLeft: NewReminderContants.textLeading,
      textRight: widget.settingNewReminder.isEditReminder
          ? NewReminderContants.textRightEdit
          : NewReminderContants.textRight,
      title: widget.settingNewReminder.isEditReminder
          ? NewReminderContants.textTitleEdit
          : NewReminderContants.textTitle,
    );
  }

  bool showBttomSheet(InitialNewReminderState state) {
    if (state.activeBtn ||
        state.isDateDetails ||
        state.groups != widget.settingNewReminder.listGroup[0]) {
      return true;
    } else {
      return false;
    }
  }

  bool isChangeEdit() {
    ReminderEntity reminderEntity = widget.settingNewReminder.reminderEntity;
    if (reminderEntity.title != titleController.text ||
        reminderEntity.note != noteController.text) {
      return true;
    }
    return false;
  }

  void setData() {
    titleController.text = widget.settingNewReminder.reminderEntity.title;
    noteController.text = widget.settingNewReminder.reminderEntity.note;
  }
}
