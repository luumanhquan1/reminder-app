import 'package:get_it/get_it.dart';
import 'package:ghichu/common/configs/local_db_setup.dart';
import 'package:ghichu/data/data_sources/local/group_hive.dart';
import 'package:ghichu/data/data_sources/local/reminder_hive.dart';
import 'package:ghichu/data/repositories/group_repository_impl.dart';
import 'package:ghichu/data/repositories/reminder_repository_impl.dart';
import 'package:ghichu/domain/repositories/group_repository.dart';
import 'package:ghichu/domain/repositories/reminder_repository.dart';
import 'package:ghichu/domain/usecase/group_usecase.dart';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/bloc/new_reminder_bloc.dart';

GetIt locator = GetIt.instance;
void setup() {
  /// Bloc
  locator.registerFactory<DetailsBloc>(
      () => DetailsBloc(reminderUseCase: locator<ReminderUseCase>()));
  locator.registerFactory<HomePageBloc>(() => HomePageBloc(
      groupUs: locator<GroupUseCase>(),
      reminderUs: locator<ReminderUseCase>()));
  locator.registerFactory<AddListBloc>(
      () => AddListBloc(groupUseCase: locator<GroupUseCase>()));
  locator.registerFactory<NewReminderBloc>(
      () => NewReminderBloc(reminderUseCase: locator<ReminderUseCase>()));

  /// UseCases
  locator.registerFactory<GroupUseCase>(
      () => GroupUseCase(groupRepository: locator<GroupRepository>()));
  locator.registerFactory<ReminderUseCase>(
      () => ReminderUseCase(reminderRepository: locator<ReminderRepository>()));

  /// Repositories
  locator.registerFactory<GroupRepository>(
      () => GroupRepositoryImpl(groupLds: locator<GroupLocalDataSource>()));
  locator.registerFactory<ReminderRepository>(() =>
      ReminderRepositoryImpl(reminderLDs: locator<ReminderLocalDataSource>()));

  /// DataSource
  locator.registerLazySingleton<GroupLocalDataSource>(
      () => GroupLocalDataSource(localDbSetup: locator<LocalDbSetup>()));
  locator.registerLazySingleton<ReminderLocalDataSource>(
      () => ReminderLocalDataSource(localDbSetup: locator<LocalDbSetup>()));
  /// Untils
  locator.registerLazySingleton<LocalDbSetup>(() => LocalDbSetup());
}
