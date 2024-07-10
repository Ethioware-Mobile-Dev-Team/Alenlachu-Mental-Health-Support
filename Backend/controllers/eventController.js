const Event = require('../models/Event');

// Create Event
exports.createEvent = async (req, res) => {
  const { title, description, date, time, image, organizer } = req.body;

  try {
    const newEvent = new Event({
      title,
      description,
      date,
      time,
      image, // Base64 encoded image string or filename
      organizer
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
  const { title, description, date, time, image, organizer } = req.body;
  const updateFields = { title, description, date, time, organizer };

  if (image) {
    updateFields.image = image; // Base64 encoded image string or filename
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

// RSVP to Event
exports.rsvpEvent = async (req, res) => {
  try {
    const event = await Event.findById(req.params.id);
    if (!event) {
      return res.status(404).json({ error: 'Event not found' });
    }

    // Assuming req.userId contains the ID of the authenticated user
    const userId = req.userId;

    if (!event.rsvps.includes(userId)) {
      event.rsvps.push(userId);
    } else {
      return res.status(400).json({ error: 'User has already RSVP\'d' });
    }

    await event.save();
    res.status(200).json(event);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};


// Cancel RSVP to Event
exports.unRsvpEvent = async (req, res) => {
  try {
    const event = await Event.findById(req.params.id);
    if (!event) {
      return res.status(404).json({ error: 'Event not found' });
    }

    // Assuming req.body.userId contains the ID of the user making the request
    const userId = req.body.userId;

    event.rsvps = event.rsvps.filter(rsvpId => rsvpId.toString() !== userId);
    await event.save();

    res.status(200).json(event);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};
