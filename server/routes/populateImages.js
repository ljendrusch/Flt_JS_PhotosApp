const express = require('express');
const Flickr = require('flickr-sdk');

const Place = require('../models/place');
const PlaceImages = require('../models/place_image');

const flickrRouter = express.Router();

const fr = new Flickr(Flickr.OAuth.createPlugin(
    '8fe15c2c0f8503be8efeaa59b24c6412', //FLICKR_CONSUMER_KEY
    '39045ee4ee28aa4e', //FLICKR_CONSUMER_SECRET
    '72157720867317573-c3914edfab530c0d', //FLICKR_OAUTH_TOKEN
    'de9604be600a9152')); //FLICKR_OAUTH_TOKEN_SECRET

async function imageSearch(lat, lon) {
    return await fr.photos.search({
        format: 'json',
        content_type: '1',
        lat: lat,
        lon: lon,
        radius: '0.1'
    }).then((res) =>
        res.body
    ).catch((e) =>
        console.error(e));
}

flickrRouter.get('/populateImages', async (req, res) => {
    console.log('image populate attempt');
    try {
        let places = await Place.find({}, { lat: 1, lon: 1 });
        console.log('i max: ', places.length);

        let imageUrls = [];
        for (let i = 0; i < places.length; i++) {
            const imagesReturned = await imageSearch(places[i].lat, places[i].lon);

            let urls = [];
            for (let j = 0; j < Math.min(20, imagesReturned.photos.total); j++) {
                console.log(i, j);
                let {server, id, secret} = imagesReturned.photos.photo[j];
                urls[j] = `https://live.staticflickr.com/${server}/${id}_${secret}.jpg`
            }

            let im = new PlaceImages({
                _id: places[i]._id,
                lat: places[i].lat,
                lon: places[i].lon,
                urls
            });

            im = await im.save();
            imageUrls[i] = im;
        }

        res.json(imageUrls);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

module.exports = flickrRouter;
