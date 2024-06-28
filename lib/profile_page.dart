import 'package:flutter/material.dart';
import 'contact.dart';

class ProfilePage extends StatefulWidget {
  final Contact contact;
  final Function(String, String, String, String, String) onEdit;
  final Function() onDelete;
  final Function() onToggleFavorite;
  final Function() onToggleGroup;

  const ProfilePage({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onToggleGroup,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Contact contact;

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
  }

  void _showEditDialog() {
    TextEditingController nameController =
        TextEditingController(text: contact.name);
    TextEditingController phoneController =
        TextEditingController(text: contact.phone);
    TextEditingController emailController =
        TextEditingController(text: contact.email);
    TextEditingController addressController =
        TextEditingController(text: contact.address);
    TextEditingController birthdayController =
        TextEditingController(text: contact.birthday);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Kontak'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                ),
                TextField(
                  controller: birthdayController,
                  decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contact.name = nameController.text;
                  contact.phone = phoneController.text;
                  contact.email = emailController.text;
                  contact.address = addressController.text;
                  contact.birthday = birthdayController.text;
                });
                widget.onEdit(
                    nameController.text,
                    phoneController.text,
                    emailController.text,
                    addressController.text,
                    birthdayController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _shareContact() {
    // Implementasikan fungsi berbagi kontak, misalnya menggunakan paket share
    // Share.share('${contact.name}, ${contact.phone}, ${contact.email}, ${contact.address}, ${contact.birthday}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Kontak'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareContact,
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: contact.isFavorite ? Colors.orange : Colors.black,
            ),
            onPressed: () {
              setState(() {
                widget.onToggleFavorite();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: widget.onToggleGroup,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.account_circle, size: 50),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.account_circle),
                  const SizedBox(width: 10),
                  Text(
                    contact.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 10),
                  Text(
                    contact.phone,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.email),
                  const SizedBox(width: 10),
                  Text(
                    contact.email,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.home),
                  const SizedBox(width: 10),
                  Text(
                    contact.address,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.cake),
                  const SizedBox(width: 10),
                  Text(
                    contact.birthday,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
