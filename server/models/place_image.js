const mongoose = require('mongoose');

const placeImagesSchema = mongoose.Schema({
    _id: {
        requred: true,
        type: String,
        trim: true
    },
    lat: {
        required: true,
        type: Number
    },
    lon: {
        required: true,
        type: Number
    },
    urls: {
        required: true,
        type: [String],
        trim: true
    }
});

const PlaceImages = mongoose.model('PlaceImages', placeImagesSchema);
module.exports = PlaceImages;
