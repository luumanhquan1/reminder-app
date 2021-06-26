import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
class DiaLogWidget extends StatelessWidget {
final String name;
  const DiaLogWidget({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(17)))),

        height: ScreenUtil().setHeight(168),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: Text(
                'Xóa "$name"?',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: Text(
                'Việc này sẽ xóa tất cả lời nhắc trong danh sách này',
                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height:  ScreenUtil().setHeight(45),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              top: BorderSide(width: 0.2),
                              right: BorderSide(width: 0.2))),
                      alignment: Alignment.center,
                      child: Text('Hủy',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(20)),),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context,'Oki');
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(45),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(top: BorderSide(width: 0.2))),
                      alignment: Alignment.center,
                      child: Text('Xóa',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(20)),),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
