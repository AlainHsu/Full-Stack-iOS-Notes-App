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
// POST request
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
// GET request
app.get('/fetch', (req, res) => {
    Data.find({}).then((DBItems) => {
        res.send(DBItems)
    })
})

// DELATE A NOTE
// POST request
app.post('/delete', function (req, res) {
    Data.findOneAndDelete({
        _id: req.get("id")
    }, (err) => {
        console.log("Failed" + err)
    })
    res.send('Deleted ' + req.get("id") + " succeed!")
})

// UPDATE A NOTE
// POST request
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

// http://172.24.4.40:8081/create
var server = app.listen(8081, "172.24.4.40", () => {
    console.log("Server is running!")
})