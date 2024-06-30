const express = require('express');
const router = express.Router();
const {
  createEvent,
  getEvents,
  getEventById,
  updateEvent,
  deleteEvent
} = require('../controllers/eventController');

// Create Event
router.post('/', createEvent);

// Get All Events
router.get('/', getEvents);

// Get Event by ID
router.get('/:id', getEventById);

// Update Event by ID
router.put('/:id', updateEvent);

// Delete Event by ID
router.delete('/:id', deleteEvent);



module.exports = router;
