import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'order_history_model.g.dart';

@JsonSerializable()
class OrderHistory {
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime? createdAt;

  @JsonKey(defaultValue: '')
  final String orderId;

  @JsonKey(defaultValue: '')
  final String orderStatus;

  @JsonKey(defaultValue: '')
  final String productName;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: '')
  final String payerUsername;

  @JsonKey(defaultValue: '')
  final String receipientUsername;

  @JsonKey(defaultValue: 0.0)
  final double actualPrice;

  @JsonKey(defaultValue: 0.0)
  final double chargePrice;

  @JsonKey(defaultValue: '')
  final String payingCurrency;

  @JsonKey(defaultValue: '')
  final String receiveCurrency;

  @JsonKey(defaultValue: 0)
  final int deliveryStatus;

  @JsonKey(defaultValue: [])
  final List<Map<String, dynamic>> children;

  @JsonKey(defaultValue: 0.0)
  final double payingTransaction;

  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime? updatedAt;

  OrderHistory({
    this.createdAt,
    required this.orderId,
    required this.orderStatus,
    required this.productName,
    required this.description,
    required this.payerUsername,
    required this.receipientUsername,
    required this.actualPrice,
    required this.chargePrice,
    required this.payingCurrency,
    required this.receiveCurrency,
    required this.deliveryStatus,
    this.children = const [],
    required this.payingTransaction,
    this.updatedAt,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryToJson(this);

  static DateTime? _dateTimeFromJson(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return null;
  }

  static dynamic _dateTimeToJson(DateTime? date) =>
      date?.toIso8601String();
}