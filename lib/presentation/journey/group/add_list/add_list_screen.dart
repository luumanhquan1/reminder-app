import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/domain/entities/group_entity.dart';

import 'package:ghichu/presentation/journey/group/add_list/add_list_constaner.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_event.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_state.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_bloc.dart';
import 'package:ghichu/presentation/journey/group/add_list/widgets/select_colors.dart';

import 'package:ghichu/presentation/journey/widgets/app_bar.dart';
import 'package:ghichu/presentation/journey/widgets/icon_widget.dart';
import 'package:ghichu/presentation/journey/widgets/show_model_button_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/presentation/journey/widgets/show_toast_error.dart';
import 'package:ghichu/presentation/view_state.dart';

class AddGroupScreen extends StatefulWidget {
  final GroupEntity groupEntity;
  final int index;
  const AddGroupScreen({Key key, this.index,this.groupEntity}) : super(key: key);
  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddGroupScreen> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    if (widget.groupEntity != null) {
      _textEditingController.text = widget.groupEntity.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddListBloc, AddListState>(
      listener: (context, state) {
        if (state is InitialAddListState) {
          if (state.viewState == ViewState.success){
            Navigator.pop(context, 'done');}
          if (state.viewState == ViewState.error) {
            showError();
          }
        }
        if (state is PopAddListGroupState) {
          if (state.isRemove) {
            showButtonModalSheet(context);
          } else {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        if (state is InitialAddListState) {
          return Scaffold(
            appBar: AppBarWidget(
              color: state.activeAddBtn ? Colors.blue : Colors.black38,
              leading: () {
                BlocProvider.of<AddListBloc>(context).add(PopAddListGroupEvent(
                    isRemove: changeScreen(
                        _textEditingController.text, state.color)));
              },
              actions: state.activeAddBtn
                  ? () {
                      if (widget.groupEntity == null) {
                        BlocProvider.of<AddListBloc>(context).add(
                            CreateListEvent(
                                name: _textEditingController.text.trim(),
                                color: state.color.value.toString(),
                                createAt: DateTime.now().toString(),
                                lastUpdate: DateTime.now().toString()));
                      } else {
                        BlocProvider.of<AddListBloc>(context).add(
                            EditGroupEvent(
                              index: widget.index,
                                groupEntity: widget.groupEntity,
                                name: _textEditingController.text,
                                color: state.color.value.toString(),
                                lastUpdate: DateTime.now().toString()));
                      }
                    }
                  : null,
              textLeft: 'Hủy',
              title: 'Danh sách mới',
              textRight: 'Xong',
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AddListConstants.screenUntilHeight30,
                    ),
                    Center(
                        child: IconWidget(
                      size: AddListConstants.sizeContainer,
                      color: Color(state.color.value),
                      colorGraient: Color(state.color.value).withOpacity(0.5),
                      icon: Icons.list,
                      shadow: 0.2,
                      sizeIcon: AddListConstants.sizeIcon,
                    )),
                    SizedBox(
                      height: AddListConstants.screenUntilHeight30,
                    ),
                    TextField(
                      controller: _textEditingController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: state.color,
                          fontWeight: FontWeight.w600,
                          fontSize: AddListConstants.screenUtilText),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(13)),
                        prefixIcon: SizedBox(),
                        prefixIconConstraints: BoxConstraints(
                            maxWidth: ScreenUtil().setWidth(20),
                            minWidth: ScreenUtil().setWidth(20)),
                        suffixIconConstraints: BoxConstraints(
                            maxWidth: ScreenUtil().setWidth(40),
                            minWidth: ScreenUtil().setWidth(32),
                            maxHeight: ScreenUtil().setHeight(55),
                            minHeight: ScreenUtil().setHeight(55)),
                        suffixIcon: Visibility(
                            visible: state.activeAddBtn,
                            child: GestureDetector(
                                onTap: () {
                                  _textEditingController.text = '';
                                  BlocProvider.of<AddListBloc>(context)
                                      .add(ActiveAddBtn(text: ''));
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: ScreenUtil().setSp(24),
                                  color: Colors.black26,
                                ))),
                        filled: true,
                        fillColor: Colors.black12.withOpacity(0.05),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.transparent),
                          borderRadius: AddListConstants.radiusCircle10,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: AddListConstants.radiusCircle10,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        BlocProvider.of<AddListBloc>(context)
                            .add(ActiveAddBtn(text: value));
                      },
                    ),
                    SizedBox(
                      height: AddListConstants.screenUntilHeight30,
                    ),
                    SelectColors(
                      addListState: state,
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // blocAddList.dispose();
    // checkButtonBloc.dispose();
  }

  bool changeScreen(String name, Color selectColor) {
    if (name.isNotEmpty || selectColor != AddListConstants.listColors[4]) {
      return true;
    } else {
      return false;
    }
  }
}
