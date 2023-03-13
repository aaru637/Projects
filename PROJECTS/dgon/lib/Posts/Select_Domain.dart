import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/Domain_Database.dart' as domain;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as p;
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Interests/Domain_Auth.dart';
import 'package:dgon/Posts/Add_Post.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Select_Domain extends StatefulWidget {
  const Select_Domain({Key? key}) : super(key: key);

  @override
  State<Select_Domain> createState() => _Select_DomainState();
}

class _Select_DomainState extends State<Select_Domain> {
  Uint8List? _file;

  pickImage(ImageSource camera) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: camera);
    if (_file != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: _file.path,
          aspectRatio: const CropAspectRatio(ratioX: 12, ratioY: 16));
      var file = await compressImage(croppedFile!.path, 35);
      return await file.readAsBytes();
    }
    snackBar(context, "No Image Selected");
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result!;
  }

  String GroupName = "";
  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a Photo"),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from Gallery"),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  List<String> groupNames = [];

  List<String> groupProfile = [];

  String Sub_Group = "";

  getDetails() async {
    setState(() {
      isLoading = true;
    });
    UserDatabase userDatabase = await GetUser.getUserDetails();

    String Sub_Group = userDatabase.Sub_Group!;

    for (int i = 0; i < userDatabase.Groups!.length; i++) {
      groupNames.add(userDatabase.Groups![i]);

      domain.DomainDatabase data = await Domain_Auth.getGroupData(
          Group: userDatabase.Groups![i], Sub_category: Sub_Group);

      groupProfile.add(data.ProfileImage!);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    final UserDatabase user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Home()));
                    },
                  ),
                  title: const Text(
                    "Select Domain",
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: false,
                ),
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: groupNames.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              child: Card(
                                  elevation: 15.0,
                                  clipBehavior: Clip.hardEdge,
                                  color:
                                      const Color.fromARGB(255, 212, 212, 212),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(groupProfile[index]),
                                    ),
                                    title: Text(groupNames[index]),
                                    subtitle: Text(Sub_Group),
                                    trailing: Container(
                                      padding: const EdgeInsets.all(5),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () {
                                          selectImage(context);
                                          setState(() {
                                            GroupName = groupNames[index];
                                          });
                                        },
                                        child: const Text("Select"),
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    ),
                  ],
                ),
              )
        : AddPost(GroupName: GroupName, file: _file!);
  }
}
