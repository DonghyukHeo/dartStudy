class JsonData {
  String? resultCd;
  String? resultMsg;

  JsonData(String resultCd, String resultMsg) {
    this.resultCd = resultCd;
    this.resultMsg = resultMsg;
  }

  JsonData.formJson(Map json)
      : resultCd = json['resultCd'],
        resultMsg = json['resultMsg'];

  Map toJson() {
    return {'resultCd': resultCd, 'resultMsg': resultMsg};
  }
}
