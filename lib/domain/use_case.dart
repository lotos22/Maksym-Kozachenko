import 'package:flutter/material.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';

abstract class UseCase<Type, Params> {
  @protected
  Future<OneOf<Failure, Type>> run(Params params);
  Future execute(Params params, Function(OneOf<Failure, Type>) onResult) async {
    try {
      final result = await run(params);
      onResult(result);
    } on Error<Failure, Type> catch (e) {
      onResult(e);
    }
  }
}
