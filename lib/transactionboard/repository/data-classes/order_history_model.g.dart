// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) => OrderHistory(
      createdAt: OrderHistory._dateTimeFromJson(json['createdAt']),
      orderId: json['orderId'] as String? ?? '',
      orderStatus: json['orderStatus'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      payerUsername: json['payerUsername'] as String? ?? '',
      receipientUsername: json['receipientUsername'] as String? ?? '',
      actualPrice: (json['actualPrice'] as num?)?.toDouble() ?? 0.0,
      chargePrice: (json['chargePrice'] as num?)?.toDouble() ?? 0.0,
      payingCurrency: json['payingCurrency'] as String? ?? '',
      receiveCurrency: json['receiveCurrency'] as String? ?? '',
      deliveryStatus: (json['deliveryStatus'] as num?)?.toInt() ?? 0,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      payingTransaction: (json['payingTransaction'] as num?)?.toDouble() ?? 0.0,
      updatedAt: OrderHistory._dateTimeFromJson(json['updatedAt']),
    );

Map<String, dynamic> _$OrderHistoryToJson(OrderHistory instance) =>
    <String, dynamic>{
      'createdAt': OrderHistory._dateTimeToJson(instance.createdAt),
      'orderId': instance.orderId,
      'orderStatus': instance.orderStatus,
      'productName': instance.productName,
      'description': instance.description,
      'payerUsername': instance.payerUsername,
      'receipientUsername': instance.receipientUsername,
      'actualPrice': instance.actualPrice,
      'chargePrice': instance.chargePrice,
      'payingCurrency': instance.payingCurrency,
      'receiveCurrency': instance.receiveCurrency,
      'deliveryStatus': instance.deliveryStatus,
      'children': instance.children,
      'payingTransaction': instance.payingTransaction,
      'updatedAt': OrderHistory._dateTimeToJson(instance.updatedAt),
    };
