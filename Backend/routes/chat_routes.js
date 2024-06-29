const express = require('express');
const router = express.Router();
const chatController = require('../controllers/chat_controller');

router.get('/chat-history', chatController.getChatHistory);
router.post('/send-message', chatController.sendMessage);

module.exports = router;
