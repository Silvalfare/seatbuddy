import 'package:flutter/material.dart';
import 'package:seatbuddy/api/menu_api.dart';
import 'package:seatbuddy/model/menu/menu_model.dart';
import 'package:seatbuddy/screen/add_menu.dart';

class DetailMenuScreen extends StatefulWidget {
  const DetailMenuScreen({super.key, required this.menu});
  static const String id = '/detail';

  final MenuModel menu;

  @override
  State<DetailMenuScreen> createState() => _DetailMenuScreenState();
}

class _DetailMenuScreenState extends State<DetailMenuScreen> {
  MenuModel? _menu;

  @override
  void initState() {
    super.initState();
    _menu = widget.menu;
  }

  Future<void> _refreshMenu() async {
    final updatedMenu = await MenuApi.fetchMenuById(widget.menu.id);
    setState(() {
      _menu = updatedMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    final menu = _menu!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Hapus Menu'),
                  content: Text('Apakah Anda yakin ingin menghapus menu ini?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Batal',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final success = await MenuApi.deleteMenu(menu.id);
                        Navigator.pop(context);
                        if (success) {
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal menghapus menu')),
                          );
                        }
                      },
                      child: Text('Hapus', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddMenuScreen(menu: menu)),
              );
              if (result == true) {
                await _refreshMenu();
              }
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(menu.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              menu.name,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'segoeUI',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Rp${menu.price}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(menu.description, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
