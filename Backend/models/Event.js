const mongoose = require('mongoose');

const OrganizerSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  location: {
    type: String,
    required: true
  }
});

const EventSchema = new mongoose.Schema({
  id: {
    type: String,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  date: {
    type: String, // Date type for date only
    required: true
  },
  time: {
    type: String, // String type for time only (HH:mm format)
    required: true
  },
  image: {
    type: String,
    default: null // Store filename or GridFS ID
  },
  organizer: {
    type: OrganizerSchema, // Single organizer
    required: true
  },
  rsvps: [{
    type: String, // Array of user IDs who have RSVP'd
    default: []
  }]
});

module.exports = mongoose.model('Event', EventSchema);
