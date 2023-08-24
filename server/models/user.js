const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (v) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return v.match(re);
            },
            message: 'Please enter a valid email address'
        }
    },
    password: {
        required: true,
        type: String,
        trim: true
    },
    zip: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (v) => {
                const re = /^\d{5}([-]|\s*)?(\d{4})?$/i;
                return v.match(re);
            },
            message: 'Please enter a valid ZIP code'
        }
    },
    fav_images: {
        required: false,
        type: [String],
        trim: true
    }
});

const User = mongoose.model('User', userSchema);
module.exports = User;
