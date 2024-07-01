const Announcement = require('../models/Announcement');

// Create Announcement
exports.createAnnouncement = async (req, res) => {
  const { topic, description, image } = req.body;

  try {
    const newAnnouncement = new Announcement({
      topic,
      description,
      image // Base64 encoded image string
    });

    await newAnnouncement.save();
    res.status(201).json(newAnnouncement);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get All Announcements
exports.getAnnouncements = async (req, res) => {
  try {
    const announcements = await Announcement.find();
    res.status(200).json(announcements);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get Announcement by ID
exports.getAnnouncementById = async (req, res) => {
  try {
    const announcement = await Announcement.findById(req.params.id);
    if (!announcement) {
      return res.status(404).json({ error: 'Announcement not found' });
    }
    res.status(200).json(announcement);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Update Announcement by ID
exports.updateAnnouncement = async (req, res) => {
  const { topic, description, image } = req.body;
  const updateFields = { topic, description };
  if (image) {
    updateFields.image = image; // Base64 encoded image string
  }

  try {
    const announcement = await Announcement.findByIdAndUpdate(req.params.id, updateFields, { new: true, runValidators: true });
    if (!announcement) {
      return res.status(404).json({ error: 'Announcement not found' });
    }
    res.status(200).json(announcement);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Delete Announcement by ID
exports.deleteAnnouncement = async (req, res) => {
  try {
    const announcement = await Announcement.findByIdAndDelete(req.params.id);
    if (!announcement) {
      return res.status(404).json({ error: 'Announcement not found' });
    }
    res.status(200).json({ message: 'Announcement deleted successfully' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};
