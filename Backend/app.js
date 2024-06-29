const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const chatRoutes = require('./routes/chat_routes');
const dotenv = require('dotenv').config()


const port = process.env.PORT || 3000;
const mongoUri = process.env.MONGO_URL

const app = express();

app.use(bodyParser.json());

app.use('/api', chatRoutes);
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
  });

mongoose.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true })
.then(()=>console.log("MongoDB Connected"))
.catch((err)=>console.log(err));


app.listen(port , ()=>{
    console.log(`server running on port ${port}`);
})