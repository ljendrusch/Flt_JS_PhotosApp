const express = require('express');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

const User = require('../models/user');

const authRouter = express.Router();

authRouter.post('/signup', async (req, res) => {
    console.log('user signup attempt');
    try {
        const { name, email, password, zip } = req.body;
        const exists = await User.findOne({ email });
        if (exists) {
            return res.status(400).json({ msg: 'That email is already in use' });
        }

        const hashedpw = await bcryptjs.hash(password, 4);
        let u = new User({
            name,
            email,
            password: hashedpw,
            zip
        })

        u = await u.save();
        res.json(u);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

authRouter.post('/signin', async (req, res) => {
    console.log('user signin attempt');
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res
                .status(400)
                .json({ msg: 'No user exists with this email' });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: 'Incorrect password' });
        }

        const token = jwt.sign({ id: user._id }, 'sign');
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.get("/", async (req, res) => {
    console.log('user get attempt');
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.status(401).json({ msg: 'No auth token, access denied' });

        const ver = jwt.verify(token, 'sign');
        if (!ver) return res.status(401).json({ msg: 'Token verification failed, authorization denied' });

        const user = await User.findById(ver.id);
        res.json({ ...user._doc, token: token });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});

module.exports = authRouter;
