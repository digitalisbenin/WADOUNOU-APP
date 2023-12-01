class DeliverPerson {
  String fullName;
  String imageUrlPath;
  bool isChecked;

  DeliverPerson(
      {required this.fullName,
      required this.imageUrlPath,
      required this.isChecked});
}

// our demo deliver person
List<DeliverPerson> demoDeliverPerson = [
  DeliverPerson(
        fullName: "Armand SEDJRO",
        imageUrlPath: 'assets/images/Profile Image.png',
        isChecked: false
      ),
  DeliverPerson(
        fullName: "John DOE",
        imageUrlPath: 'assets/images/avatar.jpg',
        isChecked: false
      ),
    DeliverPerson(
        fullName: "Jane SMITH",
        imageUrlPath: 'assets/images/img_avatar.png',
        isChecked: false
      ),
    DeliverPerson(
      fullName: "Alice JOHNSON",
      imageUrlPath: 'assets/images/img_avatar.png',
      isChecked: false
    )
];
