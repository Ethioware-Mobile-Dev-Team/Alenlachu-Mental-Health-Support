// controllers/eventController.js
const Event = require('../models/Event');

// Create Event
exports.createEvent = async (req, res) => {
  const { title, description, date, image } = req.body;

  try {
    const newEvent = new Event({
      title,
      description,
      date,
      image // Base64 encoded image string
    });

    await newEvent.save();
    res.status(201).json(newEvent);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get All Events
exports.getEvents = async (req, res) => {
  try {
    const events = await Event.find();
    res.status(200).json(events);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get Event by ID
exports.getEventById = async (req, res) => {
  try {
    const event = await Event.findById(req.params.id);
    if (!event) {
      return res.status(404).json({ error: 'Event not found' });
    }
    res.status(200).json(event);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Update Event by ID
exports.updateEvent = async (req, res) => {
  const { title, description, date, image } = req.body;
  const updateFields = { title, description, date };
  if (image) {
    updateFields.image = image; // Base64 encoded image string
  }

  try {
    const event = await Event.findByIdAndUpdate(req.params.id, updateFields, { new: true, runValidators: true });
    if (!event) {
      return res.status(404).json({ error: 'Event not found' });
    }
    res.status(200).json(event);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Delete Event by ID
exports.deleteEvent = async (req, res) => {
  try {
    const event = await Event.findByIdAndDelete(req.params.id);
    if (!event) {
      return res.status(404).json({ error: 'Event not found' });
    }
    res.status(200).json({ message: 'Event deleted successfully' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};
