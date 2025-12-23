import 'package:chat_hub/data/models/chat_room_model.dart';
import 'package:chat_hub/data/repositories/chat_repository.dart';
import 'package:chat_hub/data/services/service_locator.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final ChatRoomModel chat;
  final String currentUserId;
  final VoidCallback onTap;
  const ChatListTile({
    super.key,
    required this.chat,
    required this.currentUserId,
    required this.onTap,
  });

  String _getOtherUsername() {
    try {
      final otherUserId = chat.participants.firstWhere(
        (id) => id != currentUserId,
        orElse: () => 'Unknown User',
      );
      return chat.participantsName?[otherUserId] ?? "Unknown User";
    } catch (e) {
      return "Unknown User";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      tileColor: theme.colorScheme.surface,
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.05),
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Color(0xff692960).withOpacity(0.5),
        child: Text(_getOtherUsername()[0].toUpperCase()),
      ),
      title: Text(
        _getOtherUsername(),
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chat.lastMessage ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
        ],
      ),
      trailing: StreamBuilder<int>(
        stream: getit<ChatRepository>().getUnreadCount(chat.id, currentUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == 0) {
            return const SizedBox();
          }
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              snapshot.data.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
