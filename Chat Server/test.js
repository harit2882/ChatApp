const express = require('express');
const app = express();
const http = require('http');
const port = process.env.PORT || 5000;
const server = http.createServer(app);
const io = require("socket.io")(server,{
  pingTimeout: 1000, // time in milliseconds to wait for a ping response from the client
  pingInterval: 250 // time in milliseconds between sending ping messages to the client
});
const mongoose = require('mongoose');

const uri = "mongodb+srv://harit2882:harit2882@cluster0.awjyajj.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// Create a MongoClient with a MongoClientOptions object to set the Stable API version

mongoose.connect(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => {
  console.log("Connected successfully to MongoDB with Mongoose!");
}).catch(err => {
  console.error("Error connecting to MongoDB with Mongoose", err);
});

const messageSchema = new mongoose.Schema({
  senderId: String,
  receiverId: String,
  text: String,
  type: String,
  timeSent: String,
  columnId: String,
  isSeen: Boolean,
  msgStatus: String
});

const Message = mongoose.model('Message', messageSchema);

startServer().catch(console.dir);


// middleware
app.use(express.json());


const clients={};


 io.on("connection",(socket) => {


  console.log("connected");
  console.log(socket.id,"has joined");


  socket.on("signin",async (id) => {
    console.log(id);
    clients[id]=socket;
    // console.log("Hello My clients ==> "+clients);

    const messages = await Message.find({receiverId: id},{_id:0});

    messages.forEach(async (message) => {
      socket.emit("message",message);
      await Message.deleteOne({ columnId: message.columnId });
    });

  });

  socket.on("message", async (msg) => {

    let receiverId = msg.receiverId;

    console.log("Client Socket ====> ");

    if (clients[receiverId]) {
        
        clients[receiverId].emit("message",msg);
          
    } else {

        console.log("Client offline ==>");
        await Message.collection.insertOne(msg);

        console.log("on message => " + msg);          
    }

  });

  socket.on("disconnect", () => {
    // Remove the socket from the list of connected sockets
    for (let id in clients) {
      if (clients[id].id === socket.id) {
        delete clients[id];
        console.log(socket.id, "has left");
        break;
      }
    }
  });

});

async function startServer() {
  server.listen(port,"0.0.0.0",() => {
    console.log("server started");
  });

}