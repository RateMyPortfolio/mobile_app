class GetProfileResponse {
  int? status;
  String? msg;
  Payload? payload;

  GetProfileResponse({this.status, this.msg, this.payload});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class Payload {
  Data? data;
  bool? status;
  String? message;
  String? errorcode;

  Payload({this.data, this.status, this.message, this.errorcode});

  Payload.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorcode'] = this.errorcode;
    return data;
  }
}

class Data {
  List<Holdings>? holdings;
  Totalholding? totalholding;

  Data({this.holdings, this.totalholding});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['holdings'] != null) {
      holdings = <Holdings>[];
      json['holdings'].forEach((v) {
        holdings!.add(new Holdings.fromJson(v));
      });
    }
    totalholding = json['totalholding'] != null
        ? new Totalholding.fromJson(json['totalholding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holdings != null) {
      data['holdings'] = this.holdings!.map((v) => v.toJson()).toList();
    }
    if (this.totalholding != null) {
      data['totalholding'] = this.totalholding!.toJson();
    }
    return data;
  }
}

class Holdings {
  String? ltp;
  String? isin;
  String? close;
  String? haircut;
  String? product;
  String? exchange;
  String? quantity;
  String? t1quantity;
  String? symboltoken;
  String? averageprice;
  String? pnlpercentage;
  String? profitandloss;
  String? tradingsymbol;
  String? collateraltype;
  String? realisedquantity;
  String? authorisedquantity;
  String? collateralquantity;

  Holdings(
      {this.ltp,
        this.isin,
        this.close,
        this.haircut,
        this.product,
        this.exchange,
        this.quantity,
        this.t1quantity,
        this.symboltoken,
        this.averageprice,
        this.pnlpercentage,
        this.profitandloss,
        this.tradingsymbol,
        this.collateraltype,
        this.realisedquantity,
        this.authorisedquantity,
        this.collateralquantity});

  Holdings.fromJson(Map<String, dynamic> json) {
    ltp = json['ltp'].toString();
    isin = json['isin'].toString();
    close = json['close'].toString();
    haircut = json['haircut'].toString();
    product = json['product'].toString();
    exchange = json['exchange'].toString();
    quantity = json['quantity'].toString();
    t1quantity = json['t1quantity'].toString();
    symboltoken = json['symboltoken'].toString();
    averageprice = json['averageprice'].toString();
    pnlpercentage = json['pnlpercentage'].toString();
    profitandloss = json['profitandloss'].toString();
    tradingsymbol = json['tradingsymbol'].toString();
    collateraltype = json['collateraltype'].toString();
    realisedquantity = json['realisedquantity'].toString();
    authorisedquantity = json['authorisedquantity'].toString();
    collateralquantity = json['collateralquantity'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ltp'] = this.ltp;
    data['isin'] = this.isin;
    data['close'] = this.close;
    data['haircut'] = this.haircut;
    data['product'] = this.product;
    data['exchange'] = this.exchange;
    data['quantity'] = this.quantity;
    data['t1quantity'] = this.t1quantity;
    data['symboltoken'] = this.symboltoken;
    data['averageprice'] = this.averageprice;
    data['pnlpercentage'] = this.pnlpercentage;
    data['profitandloss'] = this.profitandloss;
    data['tradingsymbol'] = this.tradingsymbol;
    data['collateraltype'] = this.collateraltype;
    data['realisedquantity'] = this.realisedquantity;
    data['authorisedquantity'] = this.authorisedquantity;
    data['collateralquantity'] = this.collateralquantity;
    return data;
  }
}

class Totalholding {
  int? totalinvvalue;
  int? totalholdingvalue;
  double? totalpnlpercentage;
  double? totalprofitandloss;

  Totalholding(
      {this.totalinvvalue,
        this.totalholdingvalue,
        this.totalpnlpercentage,
        this.totalprofitandloss});

  Totalholding.fromJson(Map<String, dynamic> json) {
    totalinvvalue = json['totalinvvalue'];
    totalholdingvalue = json['totalholdingvalue'];
    totalpnlpercentage = json['totalpnlpercentage'];
    totalprofitandloss = json['totalprofitandloss'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalinvvalue'] = this.totalinvvalue;
    data['totalholdingvalue'] = this.totalholdingvalue;
    data['totalpnlpercentage'] = this.totalpnlpercentage;
    data['totalprofitandloss'] = this.totalprofitandloss;
    return data;
  }
}