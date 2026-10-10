// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_quote_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubmitQuoteRequest _$SubmitQuoteRequestFromJson(Map<String, dynamic> json) =>
    _SubmitQuoteRequest(
      items: (json['items'] as List<dynamic>)
          .map((e) => QuoteItemRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      evidencePhotoUrls:
          (json['evidencePhotoUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$SubmitQuoteRequestToJson(_SubmitQuoteRequest instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'evidencePhotoUrls': instance.evidencePhotoUrls,
    };
