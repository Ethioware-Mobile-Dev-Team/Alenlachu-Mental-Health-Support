const mongoose = require('mongoose');

const chatSchema = new mongoose.Schema({
  userId: {type:String , required:true},
  time: { type: Date, required: true },
  message: { type: String, required: true },
  isSender: { type: Boolean, required: true }
});

const ChatMessage = mongoose.model('ChatMessage', chatSchema);

module.exports = ChatMessage

