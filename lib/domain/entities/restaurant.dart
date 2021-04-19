import 'package:intl/intl.dart';

class Restaurant {
  final String id;
  final String name;
  final String ownerId;
  final String avgRating;
  final int numRatings;

  Restaurant({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.avgRating,
    required this.numRatings,
  });
  factory Restaurant.fromMap(String id, Map<String, dynamic> data) =>
      Restaurant(
        id: id,
        name: data['name'],
        ownerId: data['ownerId'],
        avgRating: data['avgRating'] == 0
            ? ''
            : NumberFormat('0.0').format(
                double.tryParse(data['avgRating'].toString()) ??
                    int.tryParse(data['avgRating'].toString())),
        numRatings: data['numRatings'],
      );
}
