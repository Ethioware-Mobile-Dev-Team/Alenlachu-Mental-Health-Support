const ChatMessage = require('../models/chat_models');
const ChatService = require('../services/chat_service');

exports.getChatHistory = async (req, res) => {
  const {userId} = req.query;
  try {
    const chatHistory = await ChatMessage.find({userId}).sort({ time: 1 });
    res.status(200).json(chatHistory);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.sendMessage = async (req, res) => {
  const {message, userId}  = req.body;
  const userMessage = new ChatMessage({
    userId,
    time: new Date(),
    message: message,
    isSender: true
  });

  try {
    await userMessage.save();
    const replyMessage = await ChatService.getReply(message);
    const botMessage = new ChatMessage({
      userId,
      time: new Date(),
      message: replyMessage,
      isSender: false
    });
    await botMessage.save();
    res.status(200).json({ reply: replyMessage });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

