import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/home/top_background.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController =
  TextEditingController(text: "Your Name");

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(), // ✅ Bottom Nav added
      body: Stack(
        children: [
          const TopBackground(), // ✅ Cloud background

          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 200, bottom: 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // 📸 Profile Picture
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : const AssetImage(
                            'assets/images/user_placeholder.png')
                        as ImageProvider,
                        child: _image == null
                            ? const Icon(Icons.camera_alt,
                            size: 30, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 🖊️ Editable Name
                  TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'InstrumentSerif',
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),

                  // ℹ️ Additional Info
                  const Text(
                    "Edit your profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'InstrumentSerif',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
