import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/tiket_bloc.dart';
import 'package:pariwisata/model/hargatiket.dart';
import 'package:pariwisata/ui/hargatiket_form.dart';
import 'package:pariwisata/ui/hargatiket_page.dart';
import 'package:pariwisata/widget/warning_dialog.dart';
import 'dart:ui'; // Untuk BackdropFilter

class HargaTiketDetail extends StatefulWidget {
  final HargaTiket? hargaTiket;

  const HargaTiketDetail({Key? key, this.hargaTiket}) : super(key: key);

  @override
  _HargaTiketDetailState createState() => _HargaTiketDetailState();
}

class _HargaTiketDetailState extends State<HargaTiketDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Latar belakang abu gelap
      appBar: AppBar(
        title: const Text(
          'Detail Tiket',
          style: TextStyle(fontFamily: 'Georgia'), // Font Georgia
        ),
        backgroundColor: Colors.grey[850], // AppBar abu gelap
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ID : ${widget.hargaTiket?.id ?? 'N/A'}", // Tampilkan ID
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'Georgia',
                ),
              ),
              Text(
                "Event : ${widget.hargaTiket?.event ?? 'N/A'}", // Tampilkan nama event
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: 'Georgia',
                ),
              ),
              Text(
                "Harga : Rp. ${widget.hargaTiket?.price.toString() ?? '0'}", // Tampilkan harga
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: 'Georgia',
                ),
              ),
              Text(
                "Seat : ${widget.hargaTiket?.seat ?? 'N/A'}", // Tampilkan seat
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: 'Georgia',
                ),
              ),
              const SizedBox(height: 20.0), // Spasi antar elemen
              _buildEditDeleteButtons(), // Panggil widget tombol edit/hapus
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditDeleteButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey[850], // Warna tombol abu gelap
            side: const BorderSide(color: Colors.white), // Warna border putih
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Georgia'), // Font dan warna
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HargaTiketForm(
                  hargaTiket: widget.hargaTiket!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8.0), // Spasi antar tombol
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey[850], // Warna tombol abu gelap
            side: const BorderSide(color: Colors.white), // Warna border putih
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Georgia'), // Font dan warna
          ),
          onPressed: confirmDelete,
        ),
      ],
    );
  }

  void confirmDelete() {
    showDialog(
      context: context,
      barrierDismissible: false, // Jangan biarkan dialog tertutup di luar area
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Efek blur
          child: AlertDialog(
            backgroundColor:
                Colors.grey[800], // Warna latar belakang dialog abu
            content: const Text(
              "Yakin ingin menghapus data ini?", // Pesan konfirmasi
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Georgia'), // Font dan warna
            ),
            actions: [
              // Tombol Konfirmasi Hapus
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[850], // Warna tombol abu
                  side: const BorderSide(color: Colors.white), // Border putih
                ),
                child: const Text(
                  "Ya",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia'), // Font dan warna
                ),
                onPressed: () {
                  final id = widget.hargaTiket?.id;
                  if (id != null) {
                    HargaTiketBloc.deleteHargaTiket(id: id).then(
                      (value) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HargaTiketPage(),
                          ),
                        );
                      },
                      onError: (error) {
                        showDialog(
                          context: context,
                          builder: (context) => const WarningDialog(
                            description: "Hapus gagal, silahkan coba lagi",
                          ),
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => const WarningDialog(
                        description: "ID tidak valid.",
                      ),
                    );
                  }
                },
              ),
              // Tombol Batal
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[850], // Warna tombol abu
                  side: const BorderSide(color: Colors.white), // Border putih
                ),
                child: const Text(
                  "Batal",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia'), // Font dan warna
                ),
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman detail
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
