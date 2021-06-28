# Full Stack iOS Notes App

- [Full Stack iOS Notes App](#full-stack-ios-notes-app)
  - [👀Overview](#overview)
    - [Concepts](#concepts)
  - [📝Notes](#notes)
    - [Setting up Database and Web Server](#setting-up-database-and-web-server)
    - [Building the UI and displaying the data](#building-the-ui-and-displaying-the-data)
    - [Implementing CRUD in Xcode](#implementing-crud-in-xcode)
    - [Custom Cell and code organization](#custom-cell-and-code-organization)
  - [📚Reference](#reference)

## 👀Overview

![overview](/assets/overview.png)

### Concepts

<details>
  <summary>Node.js</summary>

> Both your browser JavaScript and Node.js run on the V8 JavaScript runtime engine. This engine takes your JavaScript code and converts it into a faster machine code. Machine code is low-level code which the computer can run without needing to first interpret it.

Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient.

Node.js’ package ecosystem, npm, is the largest ecosystem of open source libraries in the world.

</details>

Node.js is a **JavaScript runtime environment** which includes everything you need to execute a program written in JavaScript.


<details>
  <summary>npm</summary>
  It puts modules in place so that node can find them, and manages dependency conflicts intelligently. It is extremely configurable to support a wide variety of use cases. Most commonly, it is used to publish, discover, install, and develop node programs.
</details>

npm is the **package manager** for the Node JavaScript platform. It's like CocoaPods or Swift Package Manager in iOS development.

<details>
  <summary>Express.js</summary>

  Express.js is a framework of Node.js which means that most of the code is already written for programmers to work with. You can build a single page, multi-page, or hybrid web applications using Express.js. Express.js is lightweight and helps to organize web applications on the server-side into a more organized MVC architecture.

  It is important to learn javascript and HTML to be able to use Express.js. Express.js makes it easier to manage web applications.It is a part of a javascript based technology called MEAN software stack which stands for MongoDB, ExpressJS, AngularJS, and Node.js. Express.js is the backend part of MEAN and manages routing, sessions, HTTP requests, error handling, etc.

  The JavaScript library of Express.js helps the programmers to build efficient and fast web apps.  Express.js enhances the functionality of the node.js. In fact, if you don’t use Express.js, then you have to do a lot of complex programming to build an efficient API. It has made programming in node.js effortless and has given many additional features.

</details>

Express.js is a free and open-source **web application framework** for Node.js. It is used for designing and building web applications quickly and easily.

<details>
  <summary>Mongoose</summary>

  Object Mapping between Node and MongoDB managed via Mongoose

  ![mongoose](/assets/object_mapping_mongoose.png)

</details>

Mongoose is an Object Data Modeling (**ODM**) **library** for MongoDB and Node.js. It manages relationships between data, provides schema validation, and is used to translate between objects in code and the representation of those objects in MongoDB.

<details>
  <summary>MongoDB</summary>

  NoSQL Documents vs. Relational Tables in SQL

  ![mongo](/assets/mongo_example.png)

  ![sql](/assets/sql_example.png)

</details>

MongoDB is a schema-less **NoSQL** document **database**. It means you can store JSON documents in it, and the structure of these documents can vary as it is not enforced like SQL databases. This is one of the advantages of using NoSQL as it speeds up application development and reduces the complexity of deployments.

## 📝Notes

### Setting up Database and Web Server

**Installing MongoDB**

```
brew tap mongodb/brew
```
```
brew install mongodb-community@4.4
```

**Installing NodeJS**

```
brew install node
```

**Setup project**

```bash
# 1. create project folder and cd in

# 2. init node package manager
npm init

# 3. enter package name (e.g., "server"), version, description...
```

After that, a `package.json` is generated which allow us to keep track of what dependencies we're using and the version of it.

```bash
# 4. install dependencies
npm install express
npm install mongoose
```

**Connect Database**

In `server.js`
```js
const express = require('express')
const mongoose = require('mongoose')
const { title } = require('process')
var app = express()
var Data = require('./noteSchema')

mongoose.connect("mongodb://localhost/newDB")

mongoose.connection.once("open", () => {
    console.log("Connecte to DB!")
}).on("error", (error) => {
    console.log("Failed to connect " + error)
})
```

**Run MongoDB**

```bash
brew services start mongodb-community
```

**Create model**

```js
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
```

**Implement CRUD**

```js
// CREATE A NOTE
// POST http://172.24.4.40:8081/create
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
// GET http://172.24.4.40:8081/fetch
app.get('/fetch', (req, res) => {
    Data.find({}).then((DBItems) => {
        res.send(DBItems)
    })
})

// DELATE A NOTE
// POST http://172.24.4.40:8081/delete
app.post('/delete', function (req, res) {
    Data.findOneAndDelete({
        _id: req.get("id")
    }, (err) => {
        console.log("Failed" + err)
    })
    res.send('Deleted ' + req.get("id") + " succeed!")
})

// UPDATE A NOTE
// POST http://172.24.4.40:8081/update
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

// http://172.24.4.40:8081
var server = app.listen(8081, "172.24.4.40", () => {
    console.log("Server is running!")
})
```

**Run server app**

```bash
node server.js
```

**Test with Postman**

![postman](/assets/postman.png)

**Check result in DB**

```bash
# open mongo client
mongo

# show database
> show dbs

# switch to target database(e.g., newDB)
> use newDB

# show all models(e.g., datas)
> show collections

# show documents
> db.datas.find()
```

### Building the UI and displaying the data

### Implementing CRUD in Xcode

### Custom Cell and code organization


## 📚Reference
>https://www.youtube.com/playlist?list=PLMRqhzcHGw1YSKIO61XncxTPoFu81K1Mx
