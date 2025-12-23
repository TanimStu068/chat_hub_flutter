const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendMessageNotification = functions.firestore
  .document("chatRooms/{chatRoomId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {
    const message = snapshot.data();
    if (!message) return null;

    const { senderId, receiverId, content } = message;

    // 1️⃣ Get receiver
    const receiverDoc = await admin
      .firestore()
      .collection("users")
      .doc(receiverId)
      .get();

    if (!receiverDoc.exists) return null;

    const receiverData = receiverDoc.data();
    const fcmToken = receiverData.fcmToken;

    if (!fcmToken) return null;

    // 2️⃣ Get sender name
    const senderDoc = await admin
      .firestore()
      .collection("users")
      .doc(senderId)
      .get();

    const senderName = senderDoc.exists
      ? senderDoc.data().fullName ?? "New Message"
      : "New Message";

    // 3️⃣ Notification payload
    const payload = {
      token: fcmToken,
      notification: {
        title: senderName,
        body: content,
      },
      data: {
        chatRoomId: context.params.chatRoomId,
        senderId: senderId,
        type: "chat",
      },
      android: {
        priority: "high",
      },
    };

    // 4️⃣ Send notification
    await admin.messaging().send(payload);

    return null;
  });
