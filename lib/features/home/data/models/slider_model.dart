class SliderResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  SliderResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return SliderResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      error: json['error'],
      status: json['status'],
    );
  }
}

class Data {
  List<SliderModel>? sliders;

  Data({this.sliders});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sliders: json['sliders'] != null
          ? List<SliderModel>.from(
        json['sliders'].map((x) => SliderModel.fromJson(x)),
      )
          : [],
    );
  }
}

class SliderModel {
  String? image;

  SliderModel({this.image});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      image: json['image'],
    );
  }
}