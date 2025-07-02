import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:seatbuddy/api/endpoint.dart';
import 'package:seatbuddy/model/menu/menu_model.dart';
import 'package:seatbuddy/screen/home.dart';
import 'package:seatbuddy/services/preference.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key, this.menu});
  static const String id = '/Add';
  final MenuModel? menu;

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  String? base64Image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.menu != null) {
      namaController.text = widget.menu!.name;
      hargaController.text = widget.menu!.price.toString();
      deskripsiController.text = widget.menu!.description;
      if (widget.menu!.imageUrl.isNotEmpty) {
        base64Image = null;
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        base64Image =
            'data:image/${pickedImage.path.split('.').last};base64,${base64Encode(bytes)}';
      });
    }
  }

  Future<void> _submit() async {
    final isEdit = widget.menu != null;

    if (!_formkey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Form tidak valid.")));
      return;
    }

    if (!isEdit && base64Image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gambar wajib dipilih.")));
      return;
    }

    setState(() => isLoading = true);

    try {
      final token = await SharedPreference.getAuthToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'name': namaController.text,
        'description': deskripsiController.text,
        'price': int.parse(hargaController.text),
        if (base64Image != null) 'image': base64Image,
      });

      http.Response response;
      if (isEdit) {
        print('PUT update menu...');
        response = await http.put(
          Uri.parse('${Endpoint.menus}/${widget.menu!.id}'),
          headers: headers,
          body: body,
        );
      } else {
        print('POST add menu...');
        response = await http.post(
          Uri.parse(Endpoint.menus),
          headers: headers,
          body: body,
        );
      }

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEdit ? "Menu berhasil diupdate." : "Menu berhasil ditambahkan.",
            ),
          ),
        );
        // Navigator.pop(context, true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(indent: 15, endIndent: 15, color: Colors.black),
        ),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: base64Image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.memory(
                              base64Decode(base64Image!.split(',').last),
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          )
                        : (widget.menu != null &&
                              widget.menu!.imageUrl.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              widget.menu!.imageUrl,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: CustomFormTextField(
                  controller: namaController,
                  title: 'Nama Makanan',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: CustomFormTextField(
                  controller: hargaController,
                  title: 'Harga',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: CustomFormTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi wajib diisi';
                    }
                    return null;
                  },
                  controller: deskripsiController,
                  title: 'Deskripsi',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, top: 10),
                child: CustomElevatedButton(
                  text: widget.menu != null ? 'Update' : 'Simpan',
                  onPressed: isLoading ? null : _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
