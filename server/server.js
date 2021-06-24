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
        date: req.get("data")
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

// http://172.24.4.40:8081/create
var server = app.listen(8081, "172.24.4.40", () => {
    console.log("Server is running!")
})

// FETCH ALL NOTES  
// GET request
app.get('fetch', (req, res) => {

})

// DELATE A NOTE
// POST request

// UPDATE A NOTE
// POST request
