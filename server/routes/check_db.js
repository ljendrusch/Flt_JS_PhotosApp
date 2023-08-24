const express = require('express');
const checkDBRouter = express.Router();

const Place = require('../models/place');
const PlaceImages = require('../models/place_image');

checkDBRouter.get('/checkDB', async (req, res) => {
    console.log('checkdb get attempt');
    try {
        let places = await Place.find({}, {lat: 1, lon: 1});
        let images = await PlaceImages.find({}, {lat: 1, lon: 1});
        let matches = 0;
        for(let i = 0; i < places.length; i++) {
            let { _id: pid, lat: plat, lon: plon } = places[i];
            pid = pid.toString();
            let { _id: iid, lat: ilat, lon: ilon } = images[i];
            if (pid == iid && plat == ilat && plon == ilon) matches++;
        }

        res.json({ 'total_p': places.length, 'total_i': images.length, 'matches': matches, 'places': places, 'images': images});
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
})
// place type options:
// amusement_park aquarium art_gallery bakery bar beauty_salon book_store
// bowling_alley cafe campground church city_hall clothing_store courthouse
// florist library mosque museum night_club park restaurant shoe_store stadium
// synagogue tourist_attraction university zoo

module.exports = checkDBRouter;
