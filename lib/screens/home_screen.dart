import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/constants/styles.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes_operation.dart';
import 'package:notes_app/screens/add_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: HomeDrawer(),
      resizeToAvoidBottomInset: true,
      bottomSheet: homeBottomSheet(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
        },
        child: const Icon(
          Icons.add,
          color: AppColors.accentColor,
          size: 40,
          weight: 40,
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const Gap(20),
                    /* Appbar */
                    homeAppBar(),
                    const Gap(30),
                    /* Body */
                    Consumer<NotesOperation>(
                        builder: (context, NotesOperation data, child) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: data.getNotes.length,
                            itemBuilder: ((context, index) {
                              return NoteCard(
                                note: data.getNotes[index],
                              );
                            })),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container homeAppBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            _drawerKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: AppColors.whiteColor,
          ),
        ),
        title: const Text(
          "Search your notes",
          style: AppTextStyles.titleSmall,
        ),
        actions: const [
          Icon(
            Icons.dashboard_rounded,
            color: AppColors.whiteColor,
            size: 24,
          ),
          Gap(10),
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.red,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMTgwOTN8MHwxfHNlYXJjaHwxNnx8cHJvZmlsZXxlbnwwfHx8fDE2ODkyMjI0MDB8MA&ixlib=rb-4.0.3&q=80&w=1080'),
          ),
        ],
      ),
    );
  }

  Container homeBottomSheet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.squareCheck,
                      color: AppColors.whiteColor,
                      size: 20,
                    )),
                IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.paintbrush,
                      color: AppColors.whiteColor,
                      size: 20,
                    )),
                IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.microphone,
                      color: AppColors.whiteColor,
                      size: 20,
                    )),
                IconButton(
                    onPressed: null,
                    icon: FaIcon(
                      FontAwesomeIcons.image,
                      color: AppColors.whiteColor,
                      size: 20,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: ListView(
          children: [drawerHeader(), drawerBody()],
        ),
      ),
    );
  }

  Widget drawerHeader() {
    return Container(
        height: 180,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: AppColors.accentColor,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Google Keep",
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              headerItems(
                  AppColors.primaryColor,
                  "Notes",
                  const FaIcon(
                    FontAwesomeIcons.lightbulb,
                    color: AppColors.secondaryColor,
                  )),
              const Gap(10),
              headerItems(
                  Colors.transparent,
                  "Reminders",
                  const FaIcon(
                    FontAwesomeIcons.bell,
                    color: AppColors.secondaryColor,
                  ))
            ],
          ),
        ));
  }

  Container headerItems(Color color, String text, FaIcon icon) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          )),
      child: Row(
        children: [
          icon,
          const Gap(20),
          Text(
            text,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerBody() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Labels",
                style: AppTextStyles.labelLarge,
              ),
              Spacer(),
              Text(
                "Edit",
                style: AppTextStyles.labelMedium,
              ),
            ],
          ),
          Gap(20),
          labelItem("Home"),
          labelItem("Shopping"),
          labelItem("Music"),
          labelItem("Photography"),
          labelItem("Work"),
          labelItem("Gaming"),
          labelItem("Health"),
          labelItem("Travel"),
          const Gap(20),
          const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.plus,
                color: AppColors.accentColor,
                size: 20,
              ),
              Gap(16),
              Text(
                "Create New Label",
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container labelItem(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.bookmark,
            color: AppColors.whiteColor,
            size: 20,
          ),
          const Gap(16),
          Text(
            text,
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor),
          borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: AppTextStyles.titleMedium,
          ),
          Text(
            note.description,
            style: AppTextStyles.bodyLarge,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
