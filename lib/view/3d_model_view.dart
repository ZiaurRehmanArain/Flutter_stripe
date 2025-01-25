

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class My3DMdodelRender extends StatefulWidget {
  @override
  _My3DMdodelRenderState createState() => _My3DMdodelRenderState();
}

class _My3DMdodelRenderState extends State<My3DMdodelRender> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _uploadedImageUrl;

  final String cloudName = "";
  final String uploadPreset = "profile_image"; // Pre-configured on Cloudinary dashboard.

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      uploadImage(_imageFile!);
    }
  }

  // Function to upload the image to Cloudinary
  Future<void> uploadImage(File imageFile) async {
    final url = "https://api.cloudinary.com/v1_1/dziuykitb/image/upload";

    try {
      // Convert file to multipart form data
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      // Send the request
      final response = await request.send();

      // Process the response
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        setState(() {
          _uploadedImageUrl = jsonResponse['secure_url']; // Get the uploaded image URL
        });
        print("Uploaded Image URL: $_uploadedImageUrl");
      } else {
        print("Failed to upload image: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloudinary Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 200)
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pick and Upload Image'),
            ),
            SizedBox(height: 20),
            _uploadedImageUrl != null
                ? Column(
                    children: [
                      Text('Uploaded Image:'),
                      SizedBox(height: 10),
                      Image.network(_uploadedImageUrl!, height: 200),
                    ],
                  )
                : Text('No image uploaded yet.'),
          ],
        ),
      ),
    );
  }
}
