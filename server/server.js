const express = require('express')
const mongoose = require('mongoose')
const { title } = require('process')
var app = express()
var Data = require('./noteSchema') // 在同目录查找

mongoose.connect("mongodb://localhost/newDB")

mongoose.connection.once("open", () => {
    console.log("Connecte to DB!")
}).on("error", (error) => {
    console.log("Failed to connect " + error)
})

// CREATE A NOTE
// POST http://192.168.0.3:8081/create
app.post("/create", (req, res) => {
    var note = new Data({
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    })

    note.save().then(() => {
        if (note.isNew == false) {
            console.log("Saved data!")
            res.send("Saved data!")
        } else {
            console.log("Failed to save data")
        }
    })
})

// FETCH ALL NOTES  
// GET http://192.168.0.3:8081/fetch
app.get('/fetch', (req, res) => {
    Data.find({}).then((DBItems) => {
        res.send(DBItems)
    })
})

// DELATE A NOTE
// POST http://192.168.0.3:8081/delete
app.post('/delete', function (req, res) {
    Data.findOneAndDelete({
        _id: req.get("id")
    }, (err) => {
        console.log("Failed" + err)
    })
    res.send('Deleted succeed!')
})

// UPDATE A NOTE
// POST http://192.168.0.3:8081/update
app.post("/update", function (req, res) {
    let params = {
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    };
    for (let prop in params) if (!params[prop]) delete params[prop];

    Data.findOneAndUpdate({
        _id: req.get("id")
    }, params, (err) => {
        console.log("Failed" + err)
    })
    res.send('Update ' + req.get("id") + " succeed!")
})

// http://192.168.0.3:8081
var server = app.listen(8081, "192.168.0.3", () => {
    console.log("Server is running!")
})