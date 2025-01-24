import 'package:digitalis_restaurant_app/core/constants/app_color_constants.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/livreurs/livreur_addinInfo_provider.dart';
import 'package:digitalis_restaurant_app/core/model/livreurs/livreur_uploadfile_provider.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/inputs/base_input_field.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/screens/login/widgets/login_form.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

class LivreurAddingInfoPage extends StatefulWidget {
  const LivreurAddingInfoPage({super.key});

  @override
  State<LivreurAddingInfoPage> createState() => _LivreurAddingInfoPageState();
}

class _LivreurAddingInfoPageState extends State<LivreurAddingInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _documentPathController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? adresse;
  String? phone;
  String? imagePath;

  List<String> status = ["Disponible", "Occupé", "En cours de livraison"];
  String selectedStatus = '';

  String? imageUrl;
  String? documentUrl;

  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  Future<void> _openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      String imagePath = result.files.single.path!;

      print(
          "Chemin du fichier : $imagePath"); // Ajoutez cette ligne pour afficher le chemin du fichier

      var imageUrl =
          await LivreurUploadFileProvider().uploadeFiles(filePath: imagePath);

      print(
          "URL du fichier : $imageUrl"); // Ajoutez cette ligne pour afficher l'URL du fichier
      setState(() {
        _imagePathController.text = imageUrl!;
      });

      this.imageUrl = imageUrl;
    }
  }

  Future<void> _openDocumentPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      String documentPath = result.files.single.path!;
      var documentUrl = await LivreurUploadFileProvider()
          .uploadeFiles(filePath: documentPath);
      setState(() {
        _documentPathController.text = documentUrl!;
      });

      this.documentUrl = documentUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              _buildFullAddressFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              _buildPhoneNumberFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              _buildPicturePathFormField(),
              AppFilledButton(
                text: "Choisir un fichier",
                color: kPrimaryColor,
                onPressed: () async {
                  _openImagePicker();
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              _buildDocumentPathFormField(),
              AppFilledButton(
                text: "Choisir un fichier",
                color: kPrimaryColor,
                onPressed: () {
                  _openDocumentPicker();
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              _buildPositionFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              BaseInputField(
                  title: "Status",
                  inputControl: DropdownButtonFormField<String>(
                    items: status.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                    isDense: true,
                    isExpanded: true,
                    iconSize: 22,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    hint: const Text(
                      'Votre status actuel...',
                      style: TextStyle(
                          color: kcDarkGreyColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0),
                    ),
                    decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  )),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              _buildDescriptionFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              Consumer<LivreurAddingInfoProvider>(
                  builder: (context, addInfo, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (addInfo.resMessage != '') {
                    showMessage(
                      message: addInfo.resMessage,
                      context: context,
                    );
                    addInfo.clear();
                  }
                });
                return AppFilledButton(
                  text: 'Mettre à jour',
                  color: kPrimaryColor,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addInfo.addLivreurInfo(
                        name: _nameController.text.trim(),
                        description: _descriptionController.text.trim(),
                        adresse: _addressController.text.trim(),
                        phone: _phoneController.text.trim(),
                        position: _positionController.text.trim(),
                        image_url: imageUrl.toString(),
                        document_url: documentUrl.toString(),
                        status: selectedStatus,
                        context: context,
                      );
                      showMessage(
                        message:
                            "Vos informations ont été mises à jour avec succès !",
                        context: context,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }

                    else if (_nameController.text.isEmpty ||
                                _descriptionController.text.isEmpty ||
                                _addressController.text.isEmpty ||
                                _phoneController.text.isEmpty ||
                                _positionController.text.isEmpty
                               
                          
                            ) {
                          showMessage(
                            message: 'Certains champs sont obligatoires',
                            context: context,
                          );
                        }
                    

                     else {
                            showMessage(
                              message:
                                  "Quelque chose s'est mal passer veuillez vous reconnectez !",
                             
                              context: context,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginForm()),
                            );

                            
                          }
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Column _buildPositionFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Votre Position",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _positionController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            cursorColor: kPrimaryColor,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Togoudo",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPositionNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kPositionNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kPositionNullError);
              } else if (value.length > 2) {
                removeError(error: kPositionNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildDescriptionFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            maxLines: 3,
            textAlign: TextAlign.justify,
            controller: _descriptionController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: kPrimaryColor,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "(Facultatif)",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
          ),
        ),
      ],
    );
  }

  Column _buildDocumentPathFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pièces d'identité en format PDF",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _documentPathController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            cursorColor: kPrimaryColor,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Aucun fichier choisi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildPicturePathFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Photo de profile",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _imagePathController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            readOnly: true,
            cursorColor: kPrimaryColor,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Aucun fichier choisi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                imagePath = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildPhoneNumberFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Numéro de téléphone",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _phoneController,
            cursorColor: kPrimaryColor,
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phone = newValue!,
            decoration: const InputDecoration(
                hintText: "99887733",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                return "Renseignez votre numéro de téléphone";
              }

              if (value.length == 8 ||
                  value.length == 10 ||
                  value.length == 12 ||
                  value.length == 13 ||
                  value.length == 15) {
                return null; // La taille du numéro de téléphone est valide
              } else {
                return "Le numéro de téléphone n'est pas valide";
              }
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                return;
              }
            },
          ),
        ),
      ],
    );
  }

  Column _buildFullAddressFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Details Adresse",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _addressController,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.words,
            cursorColor: kPrimaryColor,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "Abomey-Calavi",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (value.length > 2) {
                removeError(error: kAddressNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildNameFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nom complet",
          style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.067,
          child: TextFormField(
            textAlign: TextAlign.justify,
            controller: _nameController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            cursorColor: kPrimaryColor,
            onSaved: (newValue) => adresse = newValue!,
            decoration: const InputDecoration(
                hintText: "jonh DOE",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Color.fromARGB(255, 206, 206, 206))),
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNameNullError);
                return "";
              } else if (value.length <= 2) {
                addError(error: kNameNullError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                adresse = value;
              });
              if (value.isNotEmpty) {
                removeError(error: kNameNullError);
              } else if (value.length > 2) {
                removeError(error: kNameNullError);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
