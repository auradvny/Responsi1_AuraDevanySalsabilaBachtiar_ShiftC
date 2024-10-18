import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/tiket_bloc.dart';
import 'package:pariwisata/model/hargatiket.dart';
import 'package:pariwisata/ui/hargatiket_page.dart';
import 'package:pariwisata/widget/warning_dialog.dart';

class HargaTiketForm extends StatefulWidget {
  final HargaTiket? hargaTiket;

  const HargaTiketForm({Key? key, this.hargaTiket}) : super(key: key);

  @override
  _HargaTiketFormState createState() => _HargaTiketFormState();
}

class _HargaTiketFormState extends State<HargaTiketForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String judul;
  late String tombolSubmit;
  final _eventTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _seatTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.hargaTiket != null) {
      setState(() {
        judul = "UBAH HARGA TIKET";
        tombolSubmit = "UBAH";
        _eventTextboxController.text = widget.hargaTiket!.event ?? '';
        _hargaTextboxController.text =
            widget.hargaTiket!.price?.toString() ?? '';
        _seatTextboxController.text = widget.hargaTiket!.seat ?? '';
      });
    } else {
      judul = "TAMBAH HARGA TIKET";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Ikon leading berwarna putih
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          judul,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Georgia'), // Apply Georgia font
        ),
        backgroundColor:
            Colors.grey[900], // Using a vibrant color for the AppBar
      ),
      body: Container(
        // Dark background for the entire body
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align form items to the start
              children: [
                _eventTextField(),
                const SizedBox(height: 16), // Added spacing
                _hargaTextField(),
                const SizedBox(height: 16), // Added spacing
                _seatTextField(),
                const SizedBox(height: 24), // Added spacing
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _eventTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Event",
        labelStyle: TextStyle(
            color: Colors.white70,
            fontFamily: 'Georgia'), // Lighter label color
        fillColor: Colors.grey[800], // Input background color
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Increased border radius
          borderSide: BorderSide.none, // No border
        ),
      ),
      style:
          TextStyle(color: Colors.white, fontFamily: 'Georgia'), // Text color
      keyboardType: TextInputType.text,
      controller: _eventTextboxController,
      validator: (value) => value!.isEmpty ? "Event harus diisi" : null,
    );
  }

  Widget _hargaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga",
        labelStyle: TextStyle(color: Colors.white70, fontFamily: 'Georgia'),
        fillColor: Colors.grey[800],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Increased border radius
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) => value!.isEmpty ? "Harga harus diisi" : null,
    );
  }

  Widget _seatTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Seat",
        labelStyle: TextStyle(color: Colors.white70, fontFamily: 'Georgia'),
        fillColor: Colors.grey[800],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Increased border radius
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
      keyboardType: TextInputType.text,
      controller: _seatTextboxController,
      validator: (value) => value!.isEmpty ? "Seat harus diisi" : null,
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      child: Text(
        tombolSubmit,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Georgia'), // Text color for button
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Increased border radius
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 24.0), // Increased button padding
      ),
      onPressed: _isLoading ? null : _onSubmit,
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      setState(() {});

      if (widget.hargaTiket != null) {
        _ubah();
      } else {
        _simpan();
      }
    }
  }

  void _simpan() {
    final price = int.tryParse(_hargaTextboxController.text) ??
        0; // Safely parse price as int
    final createHargaTiket = HargaTiket(
      id: null,
      event: _eventTextboxController.text,
      price: price, // Make sure this is an int
      seat: _seatTextboxController.text,
    );

    HargaTiketBloc.addHargaTiket(hargaTiket: createHargaTiket).then(
      (value) {
        _navigateToHargaTiketPage();
      },
      onError: (error) {
        _showWarningDialog("Simpan gagal, silahkan coba lagi");
      },
    ).whenComplete(() {
      _isLoading = false;
      setState(() {});
    });
  }

  void _ubah() {
    final price =
        int.tryParse(_hargaTextboxController.text) ?? 0; // Parsing price safely
    final updateHargaTiket = HargaTiket(
      id: widget.hargaTiket!.id!,
      event: _eventTextboxController.text,
      price: price,
      seat: _seatTextboxController.text,
    );

    HargaTiketBloc.updateHargaTiket(hargaTiket: updateHargaTiket).then(
      (value) {
        _navigateToHargaTiketPage();
      },
      onError: (error) {
        _showWarningDialog("Permintaan ubah data gagal, silahkan coba lagi");
      },
    ).whenComplete(() {
      _isLoading = false;
      setState(() {});
    });
  }

  void _navigateToHargaTiketPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) => const HargaTiketPage()),
    );
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WarningDialog(description: message),
    );
  }
}
