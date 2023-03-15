import 'dart:io';

class AdProductEntity {
  final int? id;
  final String name;
  final File? image;
  final double? price;
  final int unitType;
  final double unitWeight;
  final int unitCount;
  final int minimumRequest;
  final String note;
  bool isDone;
  // final File voiceRecord;

  AdProductEntity({
    this.id,
    required this.name,
    this.image,
    required this.price,
    required this.unitType,
    required this.unitWeight,
    required this.unitCount,
    required this.minimumRequest,
    required this.note,
    this.isDone = false,
    // required this.voiceRecord,
  });
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // List<int> imageBytes = image.readAsBytesSync();
    // // print(imageBytes);
    // String base64Image = base64Encode(imageBytes);
    result.addAll({'ad_unit_type_id': unitType});
    result.addAll({'details': note});
    result.addAll({'min_order_quantity': minimumRequest});
    result.addAll({'product_id': id});
    result.addAll({'unit_weight': unitWeight});
    result.addAll({'quantity': unitCount});
    result.addAll({'unit_price': price});
    result.addAll({'ad_image': image});
    // result.addAll({'voice_record': voiceRecord});

    return result;
  }
}

Future<File> getFile(String path) async {
  return File(path);
}
