import 'package:flutter/material.dart';
import 'contact.dart';
import 'profile_page.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KontakPageState createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final List<Contact> contacts = [
    Contact('Bangun Utomo Putra', '083869047439', 'bangunup777@gmail.com',
        'Desa Kebocoran', '23-09-2003'),
    Contact('Alwi Jafar Sodik', '085727608404', 'alwijafar234@gmail.com',
        'Jatilawang', '13-08-2003'),
    Contact('Innayah Nur Fauziah', '085786309409', 'innayahnur@gmail.com',
        'Jatilawang', '27-06-2003'),
  ];
  final List<Contact> favoriteContacts = [];
  final List<Contact> groupContacts = []; // Tambahkan list kontak grup
  late List<Contact> filteredContacts;
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
    searchController.addListener(() {
      filterContacts();
    });
    sortContacts();
  }

  void sortContacts() {
    contacts.sort((a, b) => a.name.compareTo(b.name));
    filterContacts();
  }

  void filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.name.toLowerCase();
        return contactName.contains(searchTerm);
      });
    }
    setState(() {
      filteredContacts = _contacts;
    });
  }

  void _addContact(String name, String phone, String email, String address,
      String birthday) {
    setState(() {
      contacts.add(Contact(name, phone, email, address, birthday));
      sortContacts();
    });
  }

  void _editContact(int index, String name, String phone, String email,
      String address, String birthday) {
    setState(() {
      contacts[index].name = name;
      contacts[index].phone = phone;
      contacts[index].email = email;
      contacts[index].address = address;
      contacts[index].birthday = birthday;
      sortContacts();
    });
  }

  void _deleteContact(int index) {
    setState(() {
      Contact contact = contacts[index];
      contacts.removeAt(index);
      favoriteContacts.remove(contact);
      groupContacts.remove(contact);
      filterContacts();
    });
  }

  void _toggleFavorite(Contact contact) {
    setState(() {
      contact.isFavorite = !contact.isFavorite;
      if (contact.isFavorite) {
        favoriteContacts.add(contact);
      } else {
        favoriteContacts.remove(contact);
      }
    });
  }

  void _toggleGroup(Contact contact) {
    setState(() {
      if (groupContacts.contains(contact)) {
        groupContacts.remove(contact);
      } else {
        groupContacts.add(contact);
      }
    });
  }

  void _showAddEditDialog({int? index}) {
    String title = index == null ? 'Tambah Kontak' : 'Edit Kontak';
    String initialName = index == null ? '' : contacts[index].name;
    String initialPhone = index == null ? '' : contacts[index].phone;
    String initialEmail = index == null ? '' : contacts[index].email;
    String initialAddress = index == null ? '' : contacts[index].address;
    String initialBirthday = index == null ? '' : contacts[index].birthday;
    TextEditingController nameController =
        TextEditingController(text: initialName);
    TextEditingController phoneController =
        TextEditingController(text: initialPhone);
    TextEditingController emailController =
        TextEditingController(text: initialEmail);
    TextEditingController addressController =
        TextEditingController(text: initialAddress);
    TextEditingController birthdayController =
        TextEditingController(text: initialBirthday);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
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
                if (index == null) {
                  _addContact(
                      nameController.text,
                      phoneController.text,
                      emailController.text,
                      addressController.text,
                      birthdayController.text);
                } else {
                  _editContact(
                      index,
                      nameController.text,
                      phoneController.text,
                      emailController.text,
                      addressController.text,
                      birthdayController.text);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showProfilePage(int index) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfilePage(
        contact: contacts[index],
        onEdit: (name, phone, email, address, birthday) {
          _editContact(index, name, phone, email, address, birthday);
        },
        onDelete: () {
          _deleteContact(index);
          Navigator.of(context).pop();
        },
        onToggleFavorite: () {
          _toggleFavorite(contacts[index]);
        },
        onToggleGroup: () {
          _toggleGroup(contacts[index]);
        },
      ),
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Contact> getCurrentList() {
    switch (_selectedIndex) {
      case 1:
        return favoriteContacts;
      case 2:
        return groupContacts; // Tampilkan kontak grup ketika tab grup dipilih
      default:
        return filteredContacts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak Simple'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Cari Kontak',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getCurrentList().length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                  title: Text(getCurrentList()[index].name),
                  onTap: () {
                    _showProfilePage(contacts.indexOf(getCurrentList()[index]));
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Kontak',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            // Tambahkan tab grup
            icon: Icon(Icons.group),
            label: 'Grup',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
        backgroundColor: Colors.orange.shade100,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditDialog();
        },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
