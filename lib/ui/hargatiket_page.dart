import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/logout_bloc.dart';
import 'package:pariwisata/bloc/tiket_bloc.dart';
import 'package:pariwisata/model/hargatiket.dart';
import 'package:pariwisata/ui/login_page.dart';
import 'package:pariwisata/ui/hargatiket_detail.dart';
import 'package:pariwisata/ui/hargatiket_form.dart';

class HargaTiketPage extends StatefulWidget {
  const HargaTiketPage({Key? key}) : super(key: key);

  @override
  _HargaTiketPageState createState() => _HargaTiketPageState();
}

class _HargaTiketPageState extends State<HargaTiketPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.light(
            primary: Colors.black, secondary: Colors.grey), // Use colorScheme
        scaffoldBackgroundColor: Colors.grey[850],
        fontFamily: 'Georgia',
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            // Use titleTextStyle instead of textTheme
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Georgia',
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Colors.black, fontFamily: 'Georgia'), // Update as needed
          bodyMedium: TextStyle(
              color: Colors.black, fontFamily: 'Georgia'), // Update as needed
        ),
        cardColor: Colors.white,
        dividerColor: Colors.grey, // Update to correct property
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List Tiket'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const HargaTiketForm()), // Use const
                  );
                },
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title:
                    const Text('Logout', style: TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.logout, color: Colors.black),
                onTap: () async {
                  await LogoutBloc.logout().then((value) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()), // Use const
                      (route) => false,
                    );
                  });
                },
              )
            ],
          ),
        ),
        body: FutureBuilder<List<HargaTiket>>(
          future: HargaTiketBloc.getHargaTiket(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListHargaTiket(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListHargaTiket extends StatelessWidget {
  final List<HargaTiket>? list;

  const ListHargaTiket({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemHargaTiket(
          hargaTiket: list![i],
        );
      },
    );
  }
}

class ItemHargaTiket extends StatelessWidget {
  final HargaTiket hargaTiket;

  const ItemHargaTiket({Key? key, required this.hargaTiket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HargaTiketDetail(
              hargaTiket: hargaTiket,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.grey[100],
        elevation: 2,
        child: ListTile(
          title: Text(
            hargaTiket.event!,
            style: const TextStyle(
                fontFamily: 'Georgia', fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Harga: ${hargaTiket.price.toString()}',
            style: const TextStyle(fontFamily: 'Georgia'),
          ),
        ),
      ),
    );
  }
}
