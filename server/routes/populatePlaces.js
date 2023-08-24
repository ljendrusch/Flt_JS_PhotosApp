const express = require('express');
const populatePlacesRouter = express.Router();

const Place = require('../models/place');

async function getPlaces(lat, lon, type) {
    const api_key = 'AIzaSyBbkBu06VFvpWOTTugLIKO83fsZd7v8NTs';
    const URL = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${api_key}&location=${lat},${lon}&radius=20000&type=${type}`;

    return await fetch(URL)
        .then(data => data.json())
        .then(jsonData => jsonData.results)
        .catch(e => console.log(e));
}

populatePlacesRouter.get('/populatePlaces', async (req, res) => {
    console.log('places get attempt');
    try {
        const { la, ln, type } = req.query;
        la = 37.7655254;
        ln = -122.4931152;

        const places_json = await getPlaces(la, ln, type);

        let places_a = [];
        for (let i = 0; i < places_json.length; i++) {
            let { name, vicinity, icon, icon_background_color} = places_json[i];
            let { lat, lon } = places_json[i].geometry.location;

            let p = new Place({
                name,
                address: vicinity,
                icon_url: icon,
                icon_bg_color: icon_background_color,
                lat,
                lon
            });
    
            p = await p.save();
            places_a[i] = p;
        }

        res.json(places_a);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
})
// place type options:
// amusement_park aquarium art_gallery bakery bar beauty_salon book_store
// bowling_alley cafe campground church city_hall clothing_store courthouse
// florist library mosque museum night_club park restaurant shoe_store stadium
// synagogue tourist_attraction university zoo

module.exports = populatePlacesRouter;
