import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final DateTime serviceDate;
  final bool isOrdered;
  final DateTime? orderedAt;

  const Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.serviceDate,
    this.isOrdered = false,
    this.orderedAt,
  });

  Meal copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    DateTime? serviceDate,
    bool? isOrdered,
    DateTime? orderedAt,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      serviceDate: serviceDate ?? this.serviceDate,
      isOrdered: isOrdered ?? this.isOrdered,
      orderedAt: orderedAt ?? this.orderedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    price,
    serviceDate,
    isOrdered,
    orderedAt,
  ];
}
