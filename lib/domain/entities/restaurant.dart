import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String ownerId;
  final double avgRating;
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
        avgRating: double.tryParse(data['avgRating'].toString()) ??
            int.parse(data['avgRating'].toString()).toDouble(),
        numRatings: data['numRatings'],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ownerId': ownerId,
      'avgRating': avgRating,
      'numRatings': numRatings,
    };
  }

  @override
  List<Object?> get props => [
        name,
        ownerId,
        avgRating,
        numRatings,
      ];
}
