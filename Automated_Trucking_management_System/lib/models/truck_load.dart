class TruckLoad {
  const TruckLoad({
    required this.id,
    required this.pickup,
    required this.delivery,
    required this.cargo,
    required this.weightTons,
    required this.createdAt,
    this.status = 'Posted',
  });

  final String id;
  final String pickup;
  final String delivery;
  final String cargo;
  final double weightTons;
  final DateTime createdAt;
  final String status;

  Map<String, dynamic> toJson() => {
        'id': id,
        'pickup': pickup,
        'delivery': delivery,
        'cargo': cargo,
        'weightTons': weightTons,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
      };

  factory TruckLoad.fromJson(Map<String, dynamic> json) {
    return TruckLoad(
      id: json['id'] as String,
      pickup: json['pickup'] as String,
      delivery: json['delivery'] as String,
      cargo: json['cargo'] as String,
      weightTons: (json['weightTons'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'Posted',
    );
  }
}
