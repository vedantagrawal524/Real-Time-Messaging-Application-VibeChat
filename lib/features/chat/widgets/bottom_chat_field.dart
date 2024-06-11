import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';

class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField({
    super.key,
    required this.recieverUserId,
  });
  final String recieverUserId;

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text,
            widget.recieverUserId,
          );
      setState(() {
        _messageController.text = '';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _messageController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isShowSendButton = true;
                });
              } else {
                setState(() {
                  isShowSendButton = false;
                });
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.emoji_emotions, color: greyColor),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.gif, color: greyColor),
                      ),
                    ],
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera, color: greyColor),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file, color: greyColor),
                      ),
                    ],
                  ),
                ),
              ),
              hintText: 'Type a message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            right: 2,
            left: 2,
          ),
          child: GestureDetector(
            onTap: sendTextMessage,
            child: CircleAvatar(
              backgroundColor: sendButtonColor,
              radius: 25,
              child: Icon(
                isShowSendButton ? Icons.send : Icons.mic,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
