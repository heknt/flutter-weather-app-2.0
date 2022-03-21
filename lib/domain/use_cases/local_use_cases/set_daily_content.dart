import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/i_use_case.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';

class SetDailyContent with IUseCase<bool, List<Day>> {
  const SetDailyContent({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required List<Day> params}) async {
    final bool deletingResult = await _localRepository.deleteDailyContent();
    final bool settingResult = await _localRepository.setDailyContent(content: params);
    return deletingResult && settingResult;
  }
}
