// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:expense_tracker_mobile/core/di/di_module.dart' as _i696;
import 'package:expense_tracker_mobile/data/datasources/remote/api_service.dart'
    as _i240;
import 'package:expense_tracker_mobile/data/repositories/auth_repository_impl.dart'
    as _i975;
import 'package:expense_tracker_mobile/domain/repositories/auth_repository.dart'
    as _i900;
import 'package:expense_tracker_mobile/domain/usecases/login_usecase.dart'
    as _i72;
import 'package:expense_tracker_mobile/presentation/pages/auth/login/bloc/login_bloc.dart'
    as _i754;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    gh.lazySingleton<_i361.Dio>(() => diModule.dio());
    gh.factory<String>(() => diModule.baseUrl(), instanceName: 'baseUrl');
    gh.lazySingleton<_i240.ApiService>(
      () => _i240.ApiService.new(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ),
    );
    gh.lazySingleton<_i900.AuthRepository>(
      () => _i975.AuthRepositoryImpl(gh<_i240.ApiService>()),
    );
    gh.factory<_i72.LoginUsecase>(
      () => _i72.LoginUsecase(gh<_i900.AuthRepository>()),
    );
    gh.factory<_i754.LoginBloc>(
      () => _i754.LoginBloc(loginUsecase: gh<_i72.LoginUsecase>()),
    );
    return this;
  }
}

class _$DiModule extends _i696.DiModule {}
