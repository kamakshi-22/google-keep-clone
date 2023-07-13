import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/constants/styles.dart';
import 'package:notes_app/models/notes_operation.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String titleText = '';
    String descriptionText = '';
    return Scaffold(
      bottomSheet: addBottomSheet(context),
      backgroundColor: AppColors.backgroundColor,
      appBar: addAppBar(context, titleText, descriptionText),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Text",
                  hintStyle: AppTextStyles.headlineLarge,
                ),
                style: AppTextStyles.headlineLarge,
                onChanged: (value) {
                  titleText = value;
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Description",
                      hintStyle: AppTextStyles.bodyLarge,
                      labelStyle: AppTextStyles.bodyLarge,
                    ),
                    maxLines: null,
                    style: AppTextStyles.bodyLarge,
                    onChanged: (value) {
                      descriptionText = value;
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar addAppBar(BuildContext context, String titleText, String descriptionText) {
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Provider.of<NotesOperation>(context, listen: false)
              .addNewNote(titleText, descriptionText);
          Navigator.pop(context);
        },
        icon: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: AppColors.whiteColor,
          size: 20,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          width: MediaQuery.of(context).size.width * 0.3,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                FontAwesomeIcons.thumbtack,
                color: AppColors.whiteColor,
                size: 20,
              ),
              FaIcon(
                FontAwesomeIcons.bell,
                color: AppColors.whiteColor,
                size: 20,
              ),
              FaIcon(
                FontAwesomeIcons.boxArchive,
                color: AppColors.whiteColor,
                size: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  Container addBottomSheet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      child: Row(
        children: [
          const IconButton(
              onPressed: null,
              icon: FaIcon(
                FontAwesomeIcons.squarePlus,
                color: AppColors.whiteColor,
                size: 20,
              )),
          const IconButton(
              onPressed: null,
              icon: FaIcon(
                FontAwesomeIcons.palette,
                color: AppColors.whiteColor,
                size: 20,
              )),
          const Spacer(),
          Text(
            "Edited at + ${DateFormat('h:mm a').format(DateTime.now())}",
            style: AppTextStyles.bodySmall,
          ),
          const Spacer(),
          const IconButton(
              onPressed: null,
              icon: FaIcon(
                FontAwesomeIcons.microphone,
                color: AppColors.whiteColor,
                size: 20,
              )),
          const IconButton(
              onPressed: null,
              icon: FaIcon(
                FontAwesomeIcons.image,
                color: AppColors.whiteColor,
                size: 20,
              ))
        ],
      ),
    );
  }
}
