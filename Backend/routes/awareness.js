const express = require('express');
const router = express.Router();
const {
    createAwareness,
    getAwarenessEntries,
    getAwarenessById,
    updateAwareness,
    deleteAwareness,
  } = require('../controllers/awarenessController');

// Route to create awareness entry
router.post('/', createAwareness);

// Route to get all awareness entries
router.get('/', getAwarenessEntries);

// Route to get awareness entry by ID
router.get('/:id', getAwarenessById);

// Route to update awareness entry by ID
router.put('/:id', updateAwareness);

// Route to delete awareness entry by ID
router.delete('/:id', deleteAwareness);

module.exports = router;
