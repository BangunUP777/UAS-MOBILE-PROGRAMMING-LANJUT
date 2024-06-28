class Contact {
  String name;
  String phone;
  String email;
  String address;
  String birthday;
  bool isFavorite; // Ubah ke bool untuk kemudahan

  Contact(this.name, this.phone, this.email, this.address, this.birthday,
      {this.isFavorite = false});
}
