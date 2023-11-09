class Report {
  int? id;
  int? skewersNumber;
  String? skewersDiameter;
  String? skewersLength;
  String? payloadWeight;
  String? company;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? inOrOut;
  int? statue;

  Report(
      {this.id,
      this.skewersNumber,
      this.skewersDiameter,
      this.skewersLength,
      this.payloadWeight,
      this.company,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.inOrOut,
      this.statue});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skewersNumber = json['skewers_number'];
    skewersDiameter = json['skewers_diameter'];
    skewersLength = json['skewers_length'];
    payloadWeight = json['payload_weight'];
    company = json['company'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    inOrOut = json['in_or_out'];
    statue = json['statue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['skewers_number'] = this.skewersNumber;
    data['skewers_diameter'] = this.skewersDiameter;
    data['skewers_length'] = this.skewersLength;
    data['payload_weight'] = this.payloadWeight;
    data['company'] = this.company;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['in_or_out'] = this.inOrOut;
    data['statue'] = this.statue;
    return data;
  }
}
