import 'package:hive/hive.dart';

part 'pair_item.g.dart';

@HiveType(typeId: 4)
class PairItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String leftItem;

  @HiveField(2)
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
