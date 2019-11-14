
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_architecture/core/error/exceptions.dart';
import 'package:tdd_clean_architecture/core/error/failure.dart';

abstract class Entity extends Equatable{
  Model createJosnModel();
}

abstract class Model<T extends Entity>
{
  T get entity => _entity;
  T _entity;
  // factory Model.fromJson(Map<String, dynamic> json){}
  static Model fromJson(Map<String, dynamic> json){}
  Map<String, dynamic> toJson();
}

abstract class Jsonable<T>{
  fromJson(Map<String, dynamic> json);
}

abstract class Repository<T> {

}

// abstract class UseCaseM<Repository,Model,Params> {
//   Repository get repository;
//   @override
//   Future<Either<Failure, Model>> call(Params params) async {
//     return await repository.getConcreteNumberTrivia(params.number);
//   }
// }

abstract class DataSource<T extends Model>{
  // Future<T> getLastData();
  // Future<void>  cacheData(T modelToCache);
  String get CACHED_NAME;
  SharedPreferences get sharedPreferences;

  T fromJson(String string);

  Future<T> getLastData() {
    final jsonString = sharedPreferences.getString(CACHED_NAME);
    if (jsonString != null) {
      return Future.value(fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  Future<void> cacheData(T modelToCache) {
    return sharedPreferences.setString(
      CACHED_NAME,
      json.encode(modelToCache.toJson()),
    );
  }
}

