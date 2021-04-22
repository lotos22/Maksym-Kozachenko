// Mocks generated by Mockito 5.0.4 from annotations
// in toptal_test/test/domain/interactor/mocks/utils.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i2;
import 'package:toptal_test/domain/entities/pendingReply.dart' as _i10;
import 'package:toptal_test/domain/entities/restaurant.dart' as _i8;
import 'package:toptal_test/domain/entities/review.dart' as _i11;
import 'package:toptal_test/domain/entities/user.dart' as _i13;
import 'package:toptal_test/domain/one_of.dart' as _i3;
import 'package:toptal_test/domain/repository/params.dart' as _i6;
import 'package:toptal_test/domain/repository/failure.dart' as _i1;
import 'package:toptal_test/domain/repository/i_login_repository.dart' as _i4;
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart'
    as _i7;
import 'package:toptal_test/domain/repository/i_review_repository.dart' as _i9;
import 'package:toptal_test/domain/repository/i_user_repository.dart' as _i12;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeOneOf<E extends _i1.Failure, S> extends _i2.Fake
    implements _i3.OneOf<E, S> {}

/// A class which mocks [ILoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockILoginRepository extends _i2.Mock implements _i4.ILoginRepository {
  MockILoginRepository() {
    _i2.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> signIn(
          _i6.LoginSignInParams? params) =>
      (super.noSuchMethod(Invocation.method(#signIn, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> signUp(
          _i6.LoginSignUpParams? params) =>
      (super.noSuchMethod(Invocation.method(#signUp, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
}

/// A class which mocks [IRestaurantRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIRestaurantRepository extends _i2.Mock
    implements _i7.IRestaurantRepository {
  MockIRestaurantRepository() {
    _i2.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.OneOf<_i1.Failure, List<_i8.Restaurant>>> getRestaurants(
          _i6.GetRestaurantsParams? params) =>
      (super.noSuchMethod(Invocation.method(#getRestaurants, [params]),
              returnValue:
                  Future<_i3.OneOf<_i1.Failure, List<_i8.Restaurant>>>.value(
                      _FakeOneOf<_i1.Failure, List<_i8.Restaurant>>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, List<_i8.Restaurant>>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> addRestaurant(
          _i6.AddRestaurantParams? params) =>
      (super.noSuchMethod(Invocation.method(#addRestaurant, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> updateRestaurant(
          _i6.UpdateRestaurantParams? params) =>
      (super.noSuchMethod(Invocation.method(#updateRestaurant, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> deleteRestaurant(
          _i6.DeleteRestaurantParams? params) =>
      (super.noSuchMethod(Invocation.method(#deleteRestaurant, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
}

/// A class which mocks [IReviewRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIReviewRepository extends _i2.Mock implements _i9.IReviewRepository {
  MockIReviewRepository() {
    _i2.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> addRestaurantReview(
          _i6.AddRestaurantReviewParams? params) =>
      (super.noSuchMethod(Invocation.method(#addRestaurantReview, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, List<_i10.PendingReply>>>
      getPendingReplies() => (super.noSuchMethod(
              Invocation.method(#getPendingReplies, []),
              returnValue:
                  Future<_i3.OneOf<_i1.Failure, List<_i10.PendingReply>>>.value(
                      _FakeOneOf<_i1.Failure, List<_i10.PendingReply>>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, List<_i10.PendingReply>>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> addReply(
          _i6.AddReplyParams? params) =>
      (super.noSuchMethod(Invocation.method(#addReply, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> updateReview(
          _i6.UpdateReviewParams? params) =>
      (super.noSuchMethod(Invocation.method(#updateReview, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> deleteReview(
          _i6.DeleteReviewParams? params) =>
      (super.noSuchMethod(Invocation.method(#deleteReview, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, List<_i11.Review>>> getReviews(
          _i6.GetRestaurantReviewsParams? params) =>
      (super.noSuchMethod(Invocation.method(#getReviews, [params]),
          returnValue: Future<_i3.OneOf<_i1.Failure, List<_i11.Review>>>.value(
              _FakeOneOf<_i1.Failure, List<_i11.Review>>())) as _i5
          .Future<_i3.OneOf<_i1.Failure, List<_i11.Review>>>);
}

/// A class which mocks [IUserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUserRepository extends _i2.Mock implements _i12.IUserRepository {
  MockIUserRepository() {
    _i2.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.OneOf<_i1.Failure, List<_i13.AppUser>>> getUsers() =>
      (super.noSuchMethod(Invocation.method(#getUsers, []),
          returnValue: Future<_i3.OneOf<_i1.Failure, List<_i13.AppUser>>>.value(
              _FakeOneOf<_i1.Failure, List<_i13.AppUser>>())) as _i5
          .Future<_i3.OneOf<_i1.Failure, List<_i13.AppUser>>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> deleteUser(
          _i6.DeleteUserParams? params) =>
      (super.noSuchMethod(Invocation.method(#deleteUser, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
  @override
  _i5.Future<_i3.OneOf<_i1.Failure, Null?>> updateUser(
          _i6.UpdateUserParams? params) =>
      (super.noSuchMethod(Invocation.method(#updateUser, [params]),
              returnValue: Future<_i3.OneOf<_i1.Failure, Null?>>.value(
                  _FakeOneOf<_i1.Failure, Null?>()))
          as _i5.Future<_i3.OneOf<_i1.Failure, Null?>>);
}
