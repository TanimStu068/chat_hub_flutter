import 'dart:io';
import 'package:chat_hub/data/models/call_log.dart';
import 'package:chat_hub/data/models/chat_message.dart';
import 'package:chat_hub/data/services/call_log_service.dart';
import 'package:chat_hub/data/services/service_locator.dart';
import 'package:chat_hub/logic/cubits/chat/chat_cubit.dart';
import 'package:chat_hub/logic/cubits/chat/chat_state.dart';
import 'package:chat_hub/presentation/widgets/loading_dots.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatMessageScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  const ChatMessageScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

// Request microphone/camera permission
Future<bool> requestPermissions({bool video = false}) async {
  final micStatus = await Permission.microphone.request();
  if (video) {
    final camStatus = await Permission.camera.request();
    return micStatus.isGranted && camStatus.isGranted;
  }
  return micStatus.isGranted;
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final TextEditingController messageController = TextEditingController();
  late final ChatCubit _chatCubit;
  final _scrollController = ScrollController();
  List<ChatMessage> _previousMessages = [];
  bool _isComposing = false;
  bool _showEmoji = false;

  @override
  void initState() {
    _chatCubit = getit<ChatCubit>();
    print("recervier id ${widget.receiverId}");
    _chatCubit.enterChat(widget.receiverId);
    messageController.addListener(_onTextChanged);
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  Future<void> _handleSendMessage() async {
    final messageText = messageController.text.trim();
    messageController.clear();
    await _chatCubit.sendMessage(
      content: messageText,
      receiverId: widget.receiverId,
    );
  }

  void _onScroll() {
    //load more messages when reaching to top

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _chatCubit.loadMoreMessages();
    }
  }

  void _onTextChanged() {
    final isComposing = messageController.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
      });
      if (isComposing) {
        _chatCubit.startTyping();
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _hasNewMessages(List<ChatMessage> messages) {
    if (messages.length != _previousMessages.length) {
      _scrollToBottom();
      _previousMessages = messages;
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    _chatCubit.leaveChat();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 74, // ✅ FIXES bottom overflow

        elevation: 0.5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff692960).withOpacity(0.5),
              child: Text(widget.receiverName[0].toUpperCase()),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiverName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  BlocBuilder<ChatCubit, ChatState>(
                    bloc: _chatCubit,
                    builder: (context, state) {
                      if (state.isReceiverTyping) {
                        return Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 4),
                              child: const LoadingDots(),
                            ),
                            Text(
                              "typing",
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        );
                      }
                      if (state.isReceiverOnline) {
                        return const Text(
                          "Online",
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        );
                      }
                      if (state.receiverLastSeen != null) {
                        final lastSeen = state.receiverLastSeen!.toDate();
                        return Text(
                          "last seen at ${DateFormat('h:mm a').format(lastSeen)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.6),
                            // color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        actions: [
          //🔊 Voice Call
          SizedBox(
            width: 30,
            child: ZegoSendCallInvitationButton(
              isVideoCall: false,
              resourceID: "chat_hub_call",
              invitees: [
                ZegoUIKitUser(id: widget.receiverId, name: widget.receiverName),
              ],
              onPressed:
                  (
                    String callID,
                    String callerID,
                    List<String> inviteesIDs,
                  ) async {
                    bool granted = await requestPermissions(video: false);
                    if (!granted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Microphone permission required"),
                        ),
                      );
                      return;
                    }

                    // Log outgoing call for Hive
                    getit<CallLogService>().addCall(
                      CallLog(
                        userId: widget.receiverId,
                        userName: widget.receiverName,
                        isVideo: false,
                        isOutgoing: true,
                        time: DateTime.now(),
                        status:
                            "calling", // you can change to "missed"/"accepted" later
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ZegoUIKitPrebuiltCall(
                          appID: 496883871,
                          appSign:
                              "c0c64f194502274fbffc950f1b2912ea38612fbbde462b40de6840113fc83f3f",
                          userID: FirebaseAuth.instance.currentUser!.uid,
                          userName:
                              FirebaseAuth.instance.currentUser!.displayName ??
                              "User",
                          callID: "chat_hub_call_${widget.receiverId}",
                          config: ZegoUIKitPrebuiltCallConfig.groupVoiceCall(),
                        ),
                      ),
                    );
                  },
              icon: ButtonIcon(icon: Icon(Icons.call)),
            ),
          ),

          // 📹 Video Call
          SizedBox(
            width: 35,
            child: ZegoSendCallInvitationButton(
              isVideoCall: true,
              resourceID: "chat_hub_call",
              invitees: [
                ZegoUIKitUser(id: widget.receiverId, name: widget.receiverName),
              ],
              onPressed:
                  (
                    String callID,
                    String callerID,
                    List<String> inviteesIDs,
                  ) async {
                    bool granted = await requestPermissions(video: true);
                    if (!granted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Microphone/Camera permission required",
                          ),
                        ),
                      );
                      return;
                    }

                    // Log outgoing call for Hive
                    getit<CallLogService>().addCall(
                      CallLog(
                        userId: widget.receiverId,
                        userName: widget.receiverName,
                        isVideo: false,
                        isOutgoing: true,
                        time: DateTime.now(),
                        status:
                            "calling", // you can change to "missed"/"accepted" later
                      ),
                    );
                    // Open call screen immediately for the caller
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ZegoUIKitPrebuiltCall(
                          appID: 496883871,
                          appSign:
                              "c0c64f194502274fbffc950f1b2912ea38612fbbde462b40de6840113fc83f3f", // <-- replace with your actual appSign
                          userID: FirebaseAuth.instance.currentUser!.uid,
                          userName:
                              FirebaseAuth.instance.currentUser!.displayName ??
                              "User",
                          callID: "chat_hub_call_${widget.receiverId}",
                          config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
                        ),
                      ),
                    );
                  },
              icon: ButtonIcon(icon: Icon(Icons.videocam)),
            ),
          ),

          BlocBuilder<ChatCubit, ChatState>(
            bloc: _chatCubit,
            builder: (context, state) {
              if (state.isUserBlocked) {
                return TextButton.icon(
                  onPressed: () => _chatCubit.unBlockUser(widget.receiverId),
                  label: const Text("Unblock"),
                  icon: const Icon(Icons.block),
                );
              }
              return PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) async {
                  if (value == "block") {
                    final bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Are you sure you want to block ${widget.receiverName}",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(
                              "Block",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await _chatCubit.blockUser(widget.receiverId);
                    }
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem(
                    value: 'block',
                    child: Text("Block User"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          _hasNewMessages(state.messages);
        },
        bloc: _chatCubit,
        builder: (context, state) {
          if (state.status == ChatStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ChatStatus.error) {
            Center(child: Text(state.error ?? "Something went wrong"));
          }
          return Column(
            children: [
              if (state.amIBlocked)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red.withOpacity(0.1),
                  child: Text(
                    "You have been blocked by ${widget.receiverName}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];

                    final isMe = message.senderId == _chatCubit.currentUserId;
                    return MessageBubble(message: message, isMe: isMe);
                  },
                ),
              ),
              if (!state.amIBlocked && !state.isUserBlocked)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _showEmoji = !_showEmoji;
                                if (_showEmoji) {
                                  FocusScope.of(context).unfocus();
                                }
                              });
                            },
                            icon: Icon(
                              Icons.emoji_emotions,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onTap: () {
                                if (_showEmoji) {
                                  setState(() {
                                    _showEmoji = false;
                                  });
                                }
                              },
                              controller: messageController,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Theme.of(
                                  context,
                                ).colorScheme.tertiary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: _isComposing ? _handleSendMessage : null,
                            icon: Icon(
                              Icons.send,
                              color: _isComposing
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      if (_showEmoji)
                        SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            textEditingController: messageController,
                            onEmojiSelected: (category, emoji) {
                              messageController
                                ..text += emoji.emoji
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(
                                    offset: messageController.text.length,
                                  ),
                                );
                              setState(() {
                                _isComposing =
                                    messageController.text.isNotEmpty;
                              });
                            },
                            config: Config(
                              height: 250,
                              emojiViewConfig: EmojiViewConfig(
                                columns: 7,
                                emojiSizeMax:
                                    32.0 * (Platform.isIOS ? 1.30 : 1.0),
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                backgroundColor: Color(
                                  0xff692960,
                                ).withOpacity(0.5),
                                loadingIndicator: const SizedBox.shrink(),
                              ),
                              categoryViewConfig: const CategoryViewConfig(
                                initCategory: Category.RECENT,
                              ),
                              bottomActionBarConfig: BottomActionBarConfig(
                                enabled: true,
                                backgroundColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                buttonColor: Theme.of(context).primaryColor,
                              ),
                              skinToneConfig: SkinToneConfig(
                                enabled: true,
                                dialogBackgroundColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                indicatorColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                              searchViewConfig: SearchViewConfig(
                                backgroundColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                buttonIconColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isMe ? 64 : 8,
          right: isMe ? 8 : 64,
          bottom: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? Color(0xff692960) : Color(0xff692960).withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isDark
                    ? Colors
                          .white // both sender and me are white in dark mode
                    : (isMe
                          ? Colors.white
                          : Colors.black), // light mode: me=white, sender=black
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('h:mm a').format(message.timestamp.toDate()),
                  style: TextStyle(
                    color: isDark
                        ? Colors
                              .white // both sender and me are white in dark mode
                        : (isMe ? Colors.white : Colors.black),
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.done_all,
                    size: 14,
                    color: message.status == MessageStatus.read
                        ? Colors.red
                        : Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
