import 'ayat.dart';

class SoraModel {
  String? soraName;
  List<Ayat>? ayat;

  SoraModel({this.soraName, this.ayat});

  factory SoraModel.fromJson(Map<String, dynamic> json) => SoraModel(
        soraName: json['sora'] as String?,
        ayat: (json['ayat'] as List<dynamic>?)
            ?.map((e) => Ayat.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'sora': soraName,
        'ayat': ayat?.map((e) => e.toJson()).toList(),
      };
}
