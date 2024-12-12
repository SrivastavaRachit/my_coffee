import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Hexagon";
  String email = "hexagondigitalservices@gmail.com";
  String phoneNumber = "8840775386";
  String favoriteDrink = "Iced Chocolate";
  String address = "123 Coffee st, Cappuccino City";
  String bio = "Lover of Coffee and all things cozy";
  bool receiveNotification = true;
  bool isEditing = false;
  File? _profileImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _drinkController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? userName;
      email = prefs.getString('email') ?? email;
      phoneNumber = prefs.getString('phoneNumber') ?? phoneNumber;
      favoriteDrink = prefs.getString('favoriteDrink') ?? favoriteDrink;
      address = prefs.getString('address') ?? address;
      bio = prefs.getString('bio') ?? bio;
      receiveNotification = prefs.getBool('receiveNotification') ?? receiveNotification;

      _nameController.text = userName;
      _emailController.text = email;
      _phoneController.text = phoneNumber;
      _drinkController.text = favoriteDrink;
      _addressController.text = address;
      _bioController.text = bio;

      String? imagePath = prefs.getString('profileImagePath');
      if(imagePath != null && File(imagePath).existsSync()){
        _profileImage = File(imagePath);
      }
    });
  }

  Future<void> _savaProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', _nameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('phoneNumber', _phoneController.text);
    prefs.setString('favoriteDrink', _drinkController.text);
    prefs.setString('address', _addressController.text);
    prefs.setString('bio', _bioController.text);
    prefs.setBool('receiveNotification', receiveNotification);

    if(_profileImage != null){
      prefs.setString('profileImagePath', _profileImage!.path);
    }
    setState(() {
      userName = _nameController.text;
      email = _emailController.text;
      phoneNumber = _phoneController.text;
      favoriteDrink = _drinkController.text;
      address = _addressController.text;
      bio = _bioController.text;
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      File? croppedFile = await _cropImage(File(pickedFile.path));
      if(croppedFile != null) {
        setState(() {
          _profileImage = croppedFile;
        });
        _savaProfileData();
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(sourcePath: imageFile.path,
    cropStyle: CropStyle.circle,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.brown,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: false,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
    );
    if(croppedFile != null){
      return File(croppedFile.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD15454),
      appBar: AppBar(
        backgroundColor: isEditing ? Colors.green : Colors.brown.shade700,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if(isEditing){
                _savaProfileData();
              } else {
                setState(() {
                  isEditing = true;
                });
              }
            },
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Color(0xFFFFFEFE),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.black,
                ),
                CircleAvatar(
                  radius: 65,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage("assets/avatar.png") as ImageProvider,
                ),
                if (isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: _pickProfileImage,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24),
            buildEditableField("Name", _nameController),
            SizedBox(height: 16),
            buildEditableField("Email", _emailController),
            SizedBox(height: 16),
            buildEditableField("Phone Number", _phoneController),
            SizedBox(height: 16),
            buildEditableField("Favorite Drink", _drinkController),
            SizedBox(height: 16),
            buildEditableField("Address", _addressController),
            SizedBox(height: 16),
            buildEditableField("Bio", _bioController),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          TextField(
            controller: controller,
            enabled: isEditing,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black),
            ),
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _drinkController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
