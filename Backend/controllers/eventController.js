const Event = require('../models/Event');
// Create Event
exports.createEvent = async (req, res) => {
  console.log('Creating Event...');
  const { id, title, description, date, time, image, organizer, rsvps } = req.body;

  try {
    const newEvent = new Event({
      id,
      title,
      description,
      date,
      time,
      image, // Base64 encoded image string or filename
      organizer,
      rsvps  // Initialize rsvps as an empty array
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

exports.rsvpEvent = async (req, res) => {
  console.log('RSVPing  Event...');
  try {
    const event = await Event.findById(req.params.id);
    if (!event) {
      return res.status(404).json({ error: 'Event not found' });
    }

    const userId = req.body.userId; // Get userId from request body
    console.log(userId);
    if (!userId) {
      return res.status(400).json({ error: 'User ID is required' });
    }

    console.log(`RSVP Attempt: eventId=${req.params.id}, userId=${userId}`);

    if (!event.rsvps.includes(userId)) {
      event.rsvps.push(userId);
    } else {
      return res.status(400).json({ error: 'User has already RSVP\'d' });
    }

    await event.save();
    res.status(200).json(event);
  } catch (err) {
    console.error(err);
    res.status(400).json({ error: err.message });
  }
};

exports.unRsvpEvent = async (req, res) => {
  try {
    const event = await Event.findById(req.params.id);
    if (!event) {
      return res.status(404).json({ error: 'Event not found' });
    }

    const userId = req.body.userId; 
    if (!userId) {
      return res.status(400).json({ error: 'User ID is required' });
    }

    console.log(`Un-RSVP Attempt: eventId=${req.params.id}, userId=${userId}`);

    if (event.rsvps.includes(userId)) {
      event.rsvps = event.rsvps.filter(id => id !== userId);
    } else {
      return res.status(400).json({ error: 'User has not RSVP\'d' });
    }

    await event.save();
    res.status(200).json(event);
  } catch (err) {
    console.error(err);
    res.status(400).json({ error: err.message });
  }
};
