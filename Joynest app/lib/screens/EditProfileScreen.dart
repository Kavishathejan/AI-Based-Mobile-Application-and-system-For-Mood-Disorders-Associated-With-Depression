import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Function to open the camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _pickImageFromGallery(); // Open gallery when clicking the profile image
          },
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : AssetImage("assets/images/Male.png") as ImageProvider,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: () {
              _pickImageFromCamera(); // Open camera when clicking the camera icon
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera_alt, size: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
