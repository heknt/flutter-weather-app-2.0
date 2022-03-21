import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/i_use_case.dart';

class SetUserLanguage with IUseCase<int, String> {
  const SetUserLanguage({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<int> execute({required String params}) => _localRepository.setUserLanguage(params);
}