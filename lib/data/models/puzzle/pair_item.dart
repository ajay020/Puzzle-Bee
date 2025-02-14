class PairItem {
  final String id;
  final String leftItem;
  final String rightItem;

  PairItem({
    required this.id,
    required this.leftItem,
    required this.rightItem,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'leftItem': leftItem,
    'rightItem': rightItem,
  };

  factory PairItem.fromJson(Map<String, dynamic> json) {
    return PairItem(
      id: json['id'],
      leftItem: json['leftItem'],
      rightItem: json['rightItem'],
    );
  }
}