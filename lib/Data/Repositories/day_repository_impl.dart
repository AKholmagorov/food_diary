import 'package:food_diary/Data/DataSources/day_data_source.dart';
import 'package:food_diary/Data/Models/day_model.dart';
import 'package:food_diary/Domain/Repositories/day_repository.dart';

class DayRepositoryImpl extends DayRepository {
  final DayDataSource dayDataSource;

  DayRepositoryImpl({required this.dayDataSource});

  @override
  Future<void> addDay(DayModel dayModel) async {
    await dayDataSource.addDay(dayModel);
  }

  @override
  Future<DayModel> getDay(DateTime date) async {
    return await dayDataSource.getDay(date);
  }

  @override
  Future<void> editDay(DateTime date) async {
    // TODO: implement editDay
    throw UnimplementedError();
  }
}