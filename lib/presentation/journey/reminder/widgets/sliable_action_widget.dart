import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class SliableActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Slidable.of(context)?.close();
      },
      child: Container(
        height: 100,
        width: 400,
      ),
    );
  }
}
