var mongoose = require("mongoose")
var Schema = mongoose.Schema

var note = new Schema({
    title: String,
    date: String,
    note: String
})

// 建模
const Data = mongoose.model("Data", note)

// 把文件暴露出来,供 server.js 使用
module.exports = Data