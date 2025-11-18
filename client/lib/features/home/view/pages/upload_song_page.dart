import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/theme/size_config.dart';
import 'package:spotify_clone/core/widgets/custom_textfield.dart';
import 'package:spotify_clone/core/widgets/loading.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/home/view/widgets/audio_wave.dart';
import 'package:spotify_clone/features/home/viewmodel/home_viewmodel.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    songNameController.dispose();
    artistController.dispose();
    super.dispose();
  }

  void selectAudio() async {
    final pickedAudio = await pickAudio();

    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeViewModelProvider.select((val) => val?.isLoading == true));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [
          IconButton(
            onPressed: () async {
              if(formKey.currentState!.validate() && selectedAudio != null && selectedImage != null) 
              {ref
                  .read(homeViewModelProvider.notifier)
                  .uploadSong(
                    selectedAudio: selectedAudio!,
                    selectedThumbnail: selectedImage!,
                    songName: songNameController.text,
                    artist: artistController.text,
                    selectedColor: selectedColor,
                  );}else {
                    showSnackBar(context, "Missing Fields");
                  }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: isLoading ? const Loader() :SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.screenHeight * 0.04),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: selectImage,
                  child: selectedImage != null
                      ? SizedBox(
                          height: SizeConfig.screenHeight * 0.15,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(selectedImage!, fit: BoxFit.cover),
                          ),
                        )
                      : DottedBorder(
                          options: RectDottedBorderOptions(
                            color: Pallete.borderColor,
                            dashPattern: [10, 4],
                            strokeCap: StrokeCap.round,
                          ),
                          child: SizedBox(
                            height: SizeConfig.screenHeight * 0.15,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.folder_open, size: 40),
                                SizedBox(height: SizeConfig.screenHeight * 0.015),
                                Text("Select The Thumbnail for your song!", style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                selectedAudio != null
                    ? AudioWave(path: selectedAudio!.path)
                    : CustomTextfield(
                        hintname: "Pick A Song",
                        controller: null,
                        isObs: false,
                        readOnly: true,
                        onTap: selectAudio,
                      ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                CustomTextfield(hintname: "Song Name", controller: songNameController, isObs: false),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                CustomTextfield(hintname: "Artist", controller: artistController, isObs: false),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                ColorPicker(
                  pickersEnabled: {ColorPickerType.wheel: true},
                  color: selectedColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  heading: Text("Select Color"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
