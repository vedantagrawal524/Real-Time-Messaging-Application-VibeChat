import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/common/utils/colors.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp/models/chat_contact.dart';
import 'package:whatsapp/models/group.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<Group>>(
              stream: ref.watch(chatControllerProvider).chatGroups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                } else if (snapshot.hasError) {
                  return const Center(child: Text(''));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text(''));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var groupData = snapshot.data![index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MobileChatScreen.routeName,
                              arguments: {
                                'name': groupData.name,
                                'uid': groupData.groupId,
                                'profilePic': groupData.groupPic,
                                'isGroupChat': true,
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: ListTile(
                              title: Text(
                                groupData.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  groupData.lastMessage,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                  groupData.groupPic,
                                ),
                              ),
                              trailing: Text(
                                DateFormat.Hm()
                                    .format(groupData.lastMsgtimeSent),
                                style: const TextStyle(
                                    fontSize: 12, color: greyColor),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: dividerColor,
                          indent: 85,
                          height: 9.5,
                          thickness: 0.8,
                        )
                      ],
                    );
                  },
                );
              },
            ),
            StreamBuilder<List<ChatContact>>(
              stream: ref.watch(chatControllerProvider).chatContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Try again Later!'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No contacts found.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var chatContact = snapshot.data![index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MobileChatScreen.routeName,
                              arguments: {
                                'name': chatContact.name,
                                'uid': chatContact.contactId,
                                'profilePic': chatContact.profilePic,
                                'isGroupChat': false,
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: ListTile(
                              title: Text(
                                chatContact.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  chatContact.lastMessage,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                  chatContact.profilePic,
                                ),
                              ),
                              trailing: Text(
                                DateFormat.Hm().format(chatContact.timeSent),
                                style: const TextStyle(
                                    fontSize: 12, color: greyColor),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: dividerColor,
                          indent: 85,
                          height: 9.5,
                          thickness: 0.8,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
