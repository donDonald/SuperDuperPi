const express = require('express');
const path = require('path')
const app = express();
const PORT = 3000;

const api = {};


// Parse URL-encoded bodies (as sent by HTML forms)
app.use(express.urlencoded({ extended: true }));


// Set EJS as the view engine
// Set the directory for views (optional, 'views' is the default)
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));


app.get('/', (req, res) => {
    res.render('index', { 
        title: 'Express + EJS Example', 
        name: 'User' 
    });
});


api.leds = {};
api.leds.status = new (require('./api/leds/Status'))(app);
api.leds.set = new (require('./api/leds/Set'))(app);
api.leds.blink = new (require('./api/leds/Blink'))(app);
api.leds.toggle = new (require('./api/leds/Toggle'))(app);


api.temperature = {};
api.temperature.values = new (require('./api/temperature/Values'))(app);


api.camera = {};
api.camera.image = new (require('./api/camera/Image'))(app);


// Start the server and listen on the specified port
app.listen(PORT, () => {
    console.log(`Example app listening at http://localhost:${PORT}`);
});
