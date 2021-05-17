class DataPO {
  final int noPO;
  final String date;
  final int noLine;
  final int kodeMaterial;
  final String deskripsi;
  final int qty;
  final String satuan;
  final String hargaSatuan;

  DataPO(
      {required this.noPO,
      required this.date,
      required this.noLine,
      required this.kodeMaterial,
      required this.deskripsi,
      required this.qty,
      required this.satuan,
      required this.hargaSatuan});

  DataPO.fromJson(Map<String, dynamic> json)
      : noPO = json['noPO'],
        date = json['date'],
        noLine = json['noLine'],
        kodeMaterial = json['kodeMaterial'],
        deskripsi = json['deskripsi'],
        qty = json['qty'],
        satuan = json['satuan'],
        hargaSatuan = json['hargaSatuan'];

  Map<String, dynamic> toJson() => {
        'noPO': noPO,
        'date': date,
        'noLine': noLine,
        'kodeMaterial': kodeMaterial,
        'deskripsi': deskripsi,
        'qty': qty,
        'satuan': satuan,
        'hargaSatuan': hargaSatuan
      };
}

class NoPOResponse {
  final List<DataPO> noPO;

  NoPOResponse(this.noPO);

  NoPOResponse.fromJson(Map<String, dynamic> json)
      : noPO =
            (json['noPO'] as List).map((e) => new DataPO.fromJson(e)).toList();
}
