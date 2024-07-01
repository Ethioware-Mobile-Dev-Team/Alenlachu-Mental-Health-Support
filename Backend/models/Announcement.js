const mongoose = require('mongoose');

const AnnouncementSchema = new mongoose.Schema({
  topic: { type: String, required: true },
  description: { type: String, required: true },
  image: { type: String } // Base64 encoded image string
});

module.exports = mongoose.model('Announcement', AnnouncementSchema);
