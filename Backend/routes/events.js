const express = require('express');
const router = express.Router();
const {
  createEvent,
  getEvents,
  getEventById,
  updateEvent,
  deleteEvent,
  rsvpEvent,
  unRsvpEvent // Add this line
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

// RSVP to Event
router.post('/:id/rsvp', rsvpEvent);

// Un-RSVP to Event
router.post('/:id/unrsvp', unRsvpEvent); // Add this line

module.exports = router;
