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
import 'package:expense_tracker_mobile/core/services/session_service.dart'
    as _i125;
import 'package:expense_tracker_mobile/data/datasources/remote/api_service.dart'
    as _i240;
import 'package:expense_tracker_mobile/data/repositories/auth_repository_impl.dart'
    as _i975;
import 'package:expense_tracker_mobile/data/repositories/main_repository_impl.dart'
    as _i650;
import 'package:expense_tracker_mobile/domain/repositories/auth_repository.dart'
    as _i900;
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart'
    as _i162;
import 'package:expense_tracker_mobile/domain/usecases/create_transaction_usecase.dart'
    as _i886;
import 'package:expense_tracker_mobile/domain/usecases/delete_transaction_usecase.dart'
    as _i826;
import 'package:expense_tracker_mobile/domain/usecases/get_category_usecase.dart'
    as _i662;
import 'package:expense_tracker_mobile/domain/usecases/get_transaction_usecase.dart'
    as _i58;
import 'package:expense_tracker_mobile/domain/usecases/login_usecase.dart'
    as _i72;
import 'package:expense_tracker_mobile/domain/usecases/register_usecase.dart'
    as _i720;
import 'package:expense_tracker_mobile/presentation/pages/auth/login/bloc/login_bloc.dart'
    as _i754;
import 'package:expense_tracker_mobile/presentation/pages/auth/register/bloc/register_bloc.dart'
    as _i1001;
import 'package:expense_tracker_mobile/presentation/pages/home/bloc/home_bloc.dart'
    as _i387;
import 'package:expense_tracker_mobile/presentation/pages/transactions/bloc/transaction_bloc.dart'
    as _i187;
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    gh.factory<_i387.HomeBloc>(() => _i387.HomeBloc());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => diModule.sharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i125.SessionService>(
      () => _i125.SessionService(gh<_i460.SharedPreferences>()),
    );
    gh.factory<String>(() => diModule.baseUrl(), instanceName: 'baseUrl');
    gh.lazySingleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => diModule.navigatorKey(),
      instanceName: 'navigatorKey',
    );
    gh.lazySingleton<_i361.Dio>(
      () => diModule.dio(
        gh<_i125.SessionService>(),
        gh<_i409.GlobalKey<_i409.NavigatorState>>(instanceName: 'navigatorKey'),
      ),
    );
    gh.lazySingleton<_i240.ApiService>(
      () => _i240.ApiService.new(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ),
    );
    gh.lazySingleton<_i900.AuthRepository>(
      () => _i975.AuthRepositoryImpl(gh<_i240.ApiService>()),
    );
    gh.lazySingleton<_i162.MainRepository>(
      () => _i650.MainRepositoryImpl(gh<_i240.ApiService>()),
    );
    gh.factory<_i720.RegisterUsecase>(
      () => _i720.RegisterUsecase(gh<_i900.AuthRepository>()),
    );
    gh.factory<_i72.LoginUsecase>(
      () => _i72.LoginUsecase(gh<_i900.AuthRepository>()),
    );
    gh.factory<_i886.CreateTransactionUsecase>(
      () => _i886.CreateTransactionUsecase(gh<_i162.MainRepository>()),
    );
    gh.factory<_i662.GetCategoryUsecase>(
      () => _i662.GetCategoryUsecase(gh<_i162.MainRepository>()),
    );
    gh.factory<_i58.GetTransactionUsecase>(
      () => _i58.GetTransactionUsecase(gh<_i162.MainRepository>()),
    );
    gh.factory<_i826.DeleteTransactionUsecase>(
      () => _i826.DeleteTransactionUsecase(gh<_i162.MainRepository>()),
    );
    gh.factory<_i1001.RegisterBloc>(
      () => _i1001.RegisterBloc(gh<_i720.RegisterUsecase>()),
    );
    gh.factory<_i187.TransactionBloc>(
      () => _i187.TransactionBloc(
        gh<_i886.CreateTransactionUsecase>(),
        gh<_i662.GetCategoryUsecase>(),
        gh<_i58.GetTransactionUsecase>(),
        gh<_i826.DeleteTransactionUsecase>(),
      ),
    );
    gh.factory<_i754.LoginBloc>(
      () => _i754.LoginBloc(loginUsecase: gh<_i72.LoginUsecase>()),
    );
    return this;
  }
}

class _$DiModule extends _i696.DiModule {}
