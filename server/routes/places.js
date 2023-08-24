const express = require('express');
const placesRouter = express.Router();

const Place = require('../models/place');

placesRouter.get('/places', async (req, res) => {
    console.log('places get attempt');
    try {
        let places = await Place.find();

        res.json(places);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

module.exports = placesRouter;
