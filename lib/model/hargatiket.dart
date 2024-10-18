class HargaTiket {
  int? id; // Mengubah id menjadi int?
  String? event; // Mengganti kodeProduk dengan event
  int? price; // Menentukan tipe data price sebagai int
  String? seat; // Mengganti nama atribut sesuai konteks

  HargaTiket({this.id, this.event, this.price, this.seat});

  factory HargaTiket.fromJson(Map<String, dynamic> obj) {
    return HargaTiket(
      id: obj['id'], // id langsung diambil sebagai int
      event: obj['event'], // Mengganti nama atribut dari kode_produk ke event
      price: obj['price'] is int
          ? obj['price']
          : (obj['price'] as num).toInt(), // Mengambil price sebagai int
      seat: obj['seat'], // Mengganti nama atribut sesuai konteks
    );
  }
}
