const express = require('express');
const mongoose = require('mongoose');
mongoose.set('strictQuery', true);

const authRouter = require('./routes/auth');
const placesRouter = require('./routes/places');
const placeImagesRouter = require('./routes/place_images');
const populateImagesRouter = require('./routes/populateImages');
// const populatePlacesRouter = require('./routes/populatePlaces');
const checkDBRouter = require('./routes/check_db');

const app = express();
const PORT = 3000;
const DB = 'mongodb+srv://logij:highrep4@cluster0.1tg2umf.mongodb.net/?retryWrites=true&w=majority';

app.use(express.json());
app.use(authRouter);
app.use(placeImagesRouter);
app.use(placesRouter);
app.use(populateImagesRouter);
// app.use(populatePlacesRouter);
app.use(checkDBRouter);

mongoose
    .connect(DB)
    .then(() => {
        console.log('connected to DB');})
    .catch(e => {
        console.error(e, e.stack);
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`connected to port ${PORT}`);
});
