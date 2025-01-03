import 'dart:io';

import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:blog_posting_app/core/utils/pick_image.dart';
import 'package:blog_posting_app/features/blog/presentation/components/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogView extends StatefulWidget {
  const AddNewBlogView({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogView(),
      );

  @override
  State<AddNewBlogView> createState() => _AddNewBlogViewState();
}

class _AddNewBlogViewState extends State<AddNewBlogView> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  List<String> _selectedTopics = [];
  File? _image;

  void _selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.done_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _buildSelectImageContainer(),
              const SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                    'Science',
                    'Others',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              if (_selectedTopics.contains(e)) {
                                _selectedTopics.remove(e);
                              } else {
                                _selectedTopics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              color: _selectedTopics.contains(e)
                                  ? const WidgetStatePropertyAll(
                                      AppColor.gradient1)
                                  : const WidgetStatePropertyAll(
                                      AppColor.backgroundColor),
                              label: Text(e),
                              side: _selectedTopics.contains(e)
                                  ? null
                                  : const BorderSide(
                                      color: AppColor.borderColor,
                                    ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              BlogEditor(
                controller: _titleController,
                hintText: 'Blog title',
              ),
              const SizedBox(
                height: 10.0,
              ),
              BlogEditor(
                controller: _contentController,
                hintText: 'Blog content',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectImageContainer() {
    return _image != null
        ? GestureDetector(
            onTap: _selectImage,
            child: SizedBox(
              width: double.infinity,
              height: 150.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: _selectImage,
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: AppColor.borderColor,
              dashPattern: const [
                10,
                4,
              ],
              radius: const Radius.circular(10.0),
              strokeCap: StrokeCap.round,
              child: const SizedBox(
                width: double.infinity,
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open_rounded,
                      size: 40.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Select an image',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
