const mongoose = require('mongoose');

const AwarenessSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  createdDate: { type: Date, required: true }, // Use Date type in Mongoose
  image: { type: String, default: null }, // Base64 encoded image string
});

module.exports = mongoose.model('Awareness', AwarenessSchema);
