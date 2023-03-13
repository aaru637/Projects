import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Profile/Update_Profile_Auth.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Storage/Upload_Post.dart';
import 'package:flutter/material.dart';
import 'package:dgon/Register/Register_Auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Edit_Profile extends StatefulWidget {
  final snap;
  final bool isYou;
  const Edit_Profile({Key? key, required this.snap, required this.isYou})
      : super(key: key);

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Uint8List? _file;

  pickImage(ImageSource camera) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file =
        await imagePicker.pickImage(source: camera, imageQuality: 50);

    if (_file != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: _file.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
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

  bool isLoading = false;

  TextEditingController FullName = TextEditingController();
  TextEditingController Bio = TextEditingController();
  TextEditingController Logged = TextEditingController();
  TextEditingController Username = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Mobile = TextEditingController();
  IconData icon = Icons.done_outline_rounded;
  var count = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FullName.text = widget.snap['FullName'];
    Bio.text = widget.snap['Bio'];
    Logged.text = widget.snap['Logged'];
    Username.text = widget.snap['Username'];
    Email.text = widget.snap['Email'];
    Mobile.text = widget.snap['Mobile'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FullName.dispose();
    Bio.dispose();
    Logged.dispose();
    Username.dispose();
    Email.dispose();
    Mobile.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.snap['Username'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          widget.isYou
              ? IconButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      bool res = false;
                      _file == null
                          ? res = await UpdateProfileAuth.UpdateWithoutProfile(
                              FullName.text, Bio.text, Username.text)
                          : res = await UpdateProfileAuth.UpdateProfile(
                              FullName.text, Bio.text, Username.text, _file!);
                      if (res) {
                        setState(() {
                          isLoading = false;
                        });
                        snackBar(context, "Updated Successfully");

                        Navigator.of(context).pop;
                      } else {
                        snackBar(context, "Try Again Later.");
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.done,
                  ),
                )
              : const Icon(
                  Icons.done,
                  color: Colors.green,
                )
        ],
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          // Container(
                          //   width: 130,
                          //   height: 130,
                          //   decoration: BoxDecoration(
                          //       border: Border.all(width: 4, color: Colors.white),
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(
                          //         fit: BoxFit.cover,
                          //         image: NetworkImage(_file == null
                          //             ? widget.snap['PhotoUrl'] == ""
                          //                 ? "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIgAAACICAMAAAALZFNgAAAAY1BMVEX///8AAADw8PDf39+Pj48fHx/s7OxERERcXFwKCgp2dnaZmZnb29vz8/PR0dHV1dWurq7Ly8s5OTl9fX3l5eW9vb1tbW1JSUkVFRWgoKDFxcVVVVWIiIhPT0+0tLQnJycxMTFNftjAAAAE5klEQVR4nO1b2YKiMBAkIIIcgoA6uKjz/1+5IuNAIElXB9h9oZ4nmSLpo9LdOs6GDeshTasqOz8eef54nLOqStP/QCLLd5erLyT418suz/4dh/0pDoQBQXzar8/CPYeFiUWHIjy7q9I4RzSJD6LzWiy83QGn0eKw89agEfn0vx7Dj5amkjHuREaULEjDu9jSaHFZ7FRii0sZwo8XoXEC3JVCcZpNIy3n02hRzgz/iTGGchDMMtp6KRotamsaqbXPqhFZXo8bLstDiNAqAVVfS/MQ4qvi8zjODB5q+Ecuj4yZ4FAcmMIpW4dGCxaT40rn0eLAuJ1qFfv4wIct1oX95V7WJ+8VHVLvVJd3dNUX6MUpGD/udSVFqLSqQS4hFtmweBreVGtv2EdECA8ov9y1YseDTgXIO8nsfaAvIXNxCuR9n9B+HuB0AWUmgA6iTQ0x99K8xYne4QKYfAqobbN6pPXplabR4kpuVJiWxzQPMBi5NBODtgesDH6jeORWBpunbzZHeThOTm520S2lc/8fnIfj/CG30wUTOraz9NWR3E4T6elbhVIE58PUVmK7TgvLL6NdJuTxcBwywCodZ0fyf3CJPMgtd4pVtExlP49ccsvDdNGZXGSMyWrQGWNa8aNN1aLcQl/3xFzpUxRKbWjGjd51fN/0zdCiagpA7o3vhpYyT4sHdPUktx3FhD1tVoVFgZ2/LaDMrhZllpRWJSOlRisicbchArwtZGcEtHtgUe5xkX2lFfTfi28bY/0GNh4uQMohBxv3Rcobw4IJLesEpf+VAHxAlp90KBYsvcr6wGEGhroPLMHagZatQtLQiLsL8cUnAlV8BgEqxUpV7CYdkMBe8HsiFbSAejdPAXY2+rgAEuFKNEBajIigVVWVwjQA8kUxDCTYXXKVAKABOvS2R6vtHzQcIg26a/86gIlw6td4Fb0nAgXANwrYXl28J9mHbJwI/vxldL96IvjVwMGE0xy1sREBPm8AxacigrpvByCaoBGkQ+++zDaRtuT0AXOUoHdFNMR/EBi9OOM2rfm5pochssFxTEEElAESauXrIrXonQ9kACaMRng2yYhLmjRoehli+HKzHFQJyvxX2id5aTnQMLR9nrt98AzLJq5vryuubnXclKHNecjhgBHjfxBEj2qSd9zqEfGPZfg6YAYSvzZUfo810/SlWMBh0ZBPvqThcJGWwgdaxJAQcGNYBciPcDRJqaOHCnBEkZMo9EhdRzzLT2qgxiSu7HJAAgTKcUWMLuZZzSrR9zMu8FOSpLCc8/Ooox6/Y4lXWWg9s7snznrihEaxy+wYzdrZdDczhx5NsUFRYdCXu+xH6n6gN1lFm0Tv9QsMgWrPRBWZdK20RYZRNUzUPWi1Uc2yU7vNlU3JQPmnFlCmVU1wUrD+Xmzmf68oQutOW9Hmseha6aDoZmmT10RDM9OtGRO31L8Yx45jUVk1YVR1NY0qjbxs4V8/jIK3MS5IuZJ8bHMhXb25jSwpNYsGjRnSG5todgwqPexCMw3G7oOBuBV+qtOrHnIgrg8mi1tIi18rAfTvJ2ezx6QRfMZ9IGXRRXqLNhGCrpWEZdJu0tCicYbg/dwHB2u7UeOVfuG2F/io8Xv4eiEZMkXEGL5ubWq2TtWh5nnBbY0ftr3hLagsNmzYsGHDhg0bNmzYsOGFv0fdPIhQdOPjAAAAAElFTkSuQmCC"
                          //                 : widget.snap['PhotoUrl']
                          //             : _file),
                          //       ),
                          //       boxShadow: [
                          //         BoxShadow(
                          //             spreadRadius: 2,
                          //             blurRadius: 10,
                          //             color: Colors.black.withOpacity(0.1),
                          //             offset: const Offset(0, 10))
                          //       ]),
                          // ),
                          _file == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: widget.snap['PhotoUrl'] == ''
                                      ? const NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSefG1ENO_CwYkPq2LPxsoQvJZS9X55A_W5jhwcF5Y&s")
                                      : NetworkImage(widget.snap['PhotoUrl']),
                                  radius: 45,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: MemoryImage(_file!),
                                  radius: 45,
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: widget.isYou
                                ? Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 4, color: Colors.white),
                                        color: Colors.green),
                                    child: InkWell(
                                      onTap: () {
                                        selectImage(context);
                                        print("Image");
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.edit,
                                    color: Colors.transparent,
                                  ),
                          )
                        ],
                      ),
                    ),

                    //FullNameField
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.width * 0.1),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: FullName,
                        readOnly: !widget.isYou,
                        style: const TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          suffixIcon: widget.isYou
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    print("Edit Profile");
                                  },
                                )
                              : const Icon(
                                  Icons.done,
                                  color: Colors.transparent,
                                ),
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                              color: const Color(0xFF978383).withOpacity(0.9)),
                        ),
                        validator: ((value) {
                          if (FullName.text.isEmpty) {
                            return "Name is Not be Empty";
                          }
                        }),
                      ),
                    ),

                    //BioField
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.width * 0.09),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: Bio,
                        style: const TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        readOnly: !widget.isYou,
                        maxLength: 100,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          suffixIcon: widget.isYou
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    print("Edit Profile");
                                  },
                                )
                              : const Icon(
                                  Icons.done,
                                  color: Colors.transparent,
                                ),
                          labelText: "Bio",
                          labelStyle: TextStyle(
                              color: const Color(0xFF978383).withOpacity(0.9)),
                        ),
                      ),
                    ),

                    //UsernameField
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.width * 0.07),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: Username,
                        style: const TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        readOnly: !widget.isYou,
                        onChanged: (value) async {
                          if (value.length > 8) {
                            if (value == widget.snap['Username']) {
                              setState(() {
                                icon = Icons.done_outline_rounded;
                                count = 0;
                              });
                            } else {
                              String result = await googleRegister_Auth
                                  .searchUsername(value);
                              if (!mounted) {
                                return;
                              }
                              setState(() {
                                icon = Icons.cancel;
                                count = 1;
                              });
                              if (result == "true") {
                                if (!mounted) {
                                  return;
                                }
                                setState(() {
                                  icon = Icons.cancel;
                                  count = 1;
                                  snackBar(context, "Username already exists");
                                });
                              } else {
                                setState(() {
                                  icon = Icons.done_outline_rounded;
                                  count = 0;
                                });
                              }
                            }
                          } else {
                            setState(() {
                              icon = Icons.cancel;
                              count = 1;
                            });
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          suffixIcon: widget.isYou
                              ? Icon(
                                  icon,
                                  color: icon == Icons.cancel
                                      ? Colors.red
                                      : Colors.green,
                                )
                              : const Icon(
                                  Icons.done,
                                  color: Colors.transparent,
                                ),
                          labelText: "Username",
                          labelStyle: TextStyle(
                              color: const Color(0xFF978383).withOpacity(0.9)),
                        ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Username not be Empty";
                          }
                        }),
                      ),
                    ),

                    //LoggedField
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.width * 0.09),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: Logged,
                        readOnly: true,
                        style: const TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Logged By",
                          labelStyle: TextStyle(
                              color: const Color(0xFF978383).withOpacity(0.9)),
                        ),
                      ),
                    ),

                    //EmailField
                    widget.snap['Logged'] == "Google"
                        ? Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.1,
                                top: MediaQuery.of(context).size.width * 0.09),
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: Email,
                              readOnly: true,
                              style: const TextStyle(
                                fontFamily: 'Cambria',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: const Color(0xFF978383)
                                        .withOpacity(0.9)),
                              ),
                            ),
                          )
                        :

                        //MobileField
                        Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.1,
                                top: MediaQuery.of(context).size.width * 0.09),
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: Mobile,
                              readOnly: true,
                              style: const TextStyle(
                                fontFamily: 'Cambria',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "Mobile",
                                labelStyle: TextStyle(
                                    color: const Color(0xFF978383)
                                        .withOpacity(0.9)),
                              ),
                            ),
                          ),
                    const Divider(),
                    // Expanded(child: Domains_View()),
                  ],
                ),
              ),
            ),
    );
  }
}
