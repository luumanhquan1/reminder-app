import 'package:ghichu/common/constants/hive_constains.dart';
import 'package:ghichu/domain/entities/details_entity.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalDbSetup {
  Box<GroupEntity> groupBox;
  Box<ReminderEntity> reminderBox;
  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(GroupEntityAdapter());
    Hive.registerAdapter(ReminderEntityAdapter());
    Hive.registerAdapter(DetailsEntityAdapter());
    groupBox = await Hive.openBox(HiveConstains.boxGroup);
    reminderBox = await Hive.openBox(HiveConstains.reminderBox);

  }

  void dispose() {
    groupBox.compact();
    reminderBox.compact();
    Hive.close();
  }
}
