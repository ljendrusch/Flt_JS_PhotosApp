const mongoose = require('mongoose');

const placeSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true
    },
    address: {
        type: String,
        trim: true
    },
    icon_url: {
        type: String,
        trim: true
    },
    icon_bg_color: {
        type: String,
        trim: true
    },
    lat: {
        required: true,
        type: Number,
    },
    lon: {
        required: true,
        type: Number,
    },
});

const Place = mongoose.model('Place', placeSchema);
module.exports = Place;
