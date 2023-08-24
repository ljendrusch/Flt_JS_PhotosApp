const express = require('express');
const imagesRouter = express.Router();

const PlaceImages = require('../models/place_image');
const User = require('../models/user');

imagesRouter.get('/images', async (req, res) => {
    console.log('images get attempt');
    try {
        let images = await PlaceImages.find();
        
        res.json(images);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

imagesRouter.post('/favImage', async (req, res) => {
    console.log('fav post attempt');
    try {
        let exists = await User.find({ _id: req.body.id, fav_images: req.body.image });

        if (exists.length == 0) {
            console.log('inserting');
            let i = await User.updateOne({ _id: req.body.id }, { $addToSet: { fav_images: req.body.image } });
            res.json({ 'method': 'insert', 'json': i });
        } else {
            console.log('deleting');
            let d = await User.updateOne({ _id: req.body.id }, { $pull: { fav_images: req.body.image } });
            res.json({ 'method': 'delete', 'json': d });
        }
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

module.exports = imagesRouter;
