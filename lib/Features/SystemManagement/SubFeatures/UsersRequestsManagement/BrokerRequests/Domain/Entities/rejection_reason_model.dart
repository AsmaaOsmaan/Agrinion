class RejectionReasonModel {
  String rejectionReason;

  RejectionReasonModel({required this.rejectionReason});
}

class RejectionReasonModelMapper {
  static RejectionReasonModel fromJson(Map<String, dynamic> json) {
    return RejectionReasonModel(
      rejectionReason: json['rejection_reason'],
    );
  }

  static Map<String, dynamic> toJson(RejectionReasonModel reasonModel) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rejection_reason'] = reasonModel.rejectionReason;

    return {
      "request": data
    };
  }
}
