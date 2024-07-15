import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaudemy/resources/storage_methods.dart';
import 'package:instaudemy/screens/profile.dart';
import 'package:instaudemy/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final captioncontroller = TextEditingController();
  Uint8List? _image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProfilePic();
  }

  // String? pocurl;
  var _userdata;
  void _getProfilePic() async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      setState(() {
        _userdata = snap.data()!;
      });
      // setState(() {
      //   //pocurl = userdata['picurl'];
      // });
    } catch (e) {
      // setState(() {
      //   pocurl =
      //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQykly5v4_YjTkrJBJxiEvG_7jGGiTWRCpNXZRogw0YdA&s';

      // });
      print(e.toString());
    }
  }

  void setImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<String> addImage() async {
    String str = 'error';
    try {
      StorageMethods obj = StorageMethods();
      FirebaseAuth _auth = FirebaseAuth.instance;
      String posturl =
          await obj.uploadImageToStorage('userposts', _image!, true);
      String userId = _auth.currentUser!.uid;
      final CollectionReference<Map<String, dynamic>> postsCollection =
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('posts');
      await postsCollection.add({'posts': posturl});
      str = 'success';
      return str;
    } catch (e) {
      print(e.toString());
      return str;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: const Text('Post to'),
        actions: [
          TextButton(
              onPressed: () {
                addImage();
              },
              child: const Text(
                'Post',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ))
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_userdata != null)
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: Expanded(
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        _userdata['photourl'],
                      ),
                    ),
                  ),
                )
              else
                CircularProgressIndicator(),
              Expanded(
                child: TextField(
                  controller: captioncontroller,
                  decoration: InputDecoration(
                      hintText: 'Enter Caption',
                      border: OutlineInputBorder(),
                      hintMaxLines: 5),
                ),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              Stack(
                children: [
                  if (_image != null)
                    CircleAvatar(
                        radius: 32, backgroundImage: MemoryImage(_image!))
                  else
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQykly5v4_YjTkrJBJxiEvG_7jGGiTWRCpNXZRogw0YdA&s'),
                    ),
                  Positioned(
                      bottom: -3,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          setImage();
                        },
                        child: const Icon(Icons.add_a_photo),
                      ))
                ],
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
          SizedBox(
            height: 60,
          ),
          if (_image != null)
            Container(
              color: Colors.white38,
              height: MediaQuery.of(context).size.height * .38,
              width: MediaQuery.of(context).size.width * .5,
              child: Image(
                image: MemoryImage(_image!),
                fit: BoxFit.fill,
              ),
            )
          else
            Container(
              height: 100,
              width: 100,
              child: Center(
                child: Text("No Image Selected"),
              ),
            )
        ],
      ),
    );
  }
}
