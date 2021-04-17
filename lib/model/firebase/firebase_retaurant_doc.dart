import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';

@Injectable(as: IRestaurantRepository)
class FirebaseRestaurauntDoc extends IRestaurantRepository {
  final RESTUARANTS = 'restaurants';
  final AVG_RATING = 'avgRating';

  final FirebaseFirestore _firestore;
  FirebaseRestaurauntDoc(
    FirebaseFirestore firestore,
  ) : _firestore = firestore;

  @override
  Future<OneOf<Failure, List<Restaurant>>> getRestaurants() async {
    try {
      final docs = await _firestore
          .collection(RESTUARANTS)
          .orderBy(AVG_RATING, descending: true)
          .get();
      final list =
          docs.docs.map((e) => Restaurant.fromMap(e.id, e.data())).toList();
      return OneOf.success(list);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
