const Awareness = require('../models/awareness');

// Create Awareness
exports.createAwareness = async (req, res) => {
  const {id, title, description, createdDate,image } = req.body;

  try {
    const newAwareness = new Awareness({
      id,
      title,
      description,
      createdDate,
      image // Base64 encoded image string
    });

    await newAwareness.save();
    res.status(201).json(newAwareness);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get All Awareness Entries
exports.getAwarenessEntries = async (req, res) => {
  try {
    const awarenessEntries = await Awareness.find();
    res.status(200).json(awarenessEntries);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get Awareness by ID
exports.getAwarenessById = async (req, res) => {
  try {
    const awareness = await Awareness.findById(req.params.id);
    if (!awareness) {
      return res.status(404).json({ error: 'Awareness entry not found' });
    }
    res.status(200).json(awareness);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Update Awareness by ID
exports.updateAwareness = async (req, res) => {
  const {id, title, description,createdDate, image } = req.body;
  const updateFields = { title, description, createdDate };
  if (image) {
    updateFields.image = image; // Base64 encoded image string
  }

  try {
    const awareness = await Awareness.findByIdAndUpdate(req.params.id, updateFields, { new: true, runValidators: true });
    if (!awareness) {
      return res.status(404).json({ error: 'Awareness entry not found' });
    }
    res.status(200).json(awareness);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Delete Awareness by ID
exports.deleteAwareness = async (req, res) => {
  try {
    const awareness = await Awareness.findByIdAndDelete(req.params.id);
    if (!awareness) {
      return res.status(404).json({ error: 'Awareness entry not found' });
    }
    res.status(200).json({ message: 'Awareness entry deleted successfully' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};
