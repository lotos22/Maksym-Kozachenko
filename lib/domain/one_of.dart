import 'package:equatable/equatable.dart';
import 'package:toptal_test/domain/repository/failure.dart';

abstract class OneOf<E extends Failure, S> extends Equatable{
  dynamic oneOf(void Function(E) onError, void Function(S) onSuccess) {
    if (this is Error) {
      onError((this as Error).error as E);
    } else if (this is Success) {
      onSuccess((this as Success).data);
    }
  }

  OneOf();
  factory OneOf.success(S val) = Success<E, S>;
  factory OneOf.error(E val) = Error<E, S>;

  bool get isError => this is Error;
  bool get isSuccess => this is Success;
}

class Error<E extends Failure, S> extends OneOf<E, S> {
  final E error;
  Error(this.error);

  @override
  List<Object?> get props => [E];
}

class Success<E extends Failure, S> extends OneOf<E, S> {
  final S data;
  Success(this.data);

  @override
  List<Object?> get props => [S];
}
