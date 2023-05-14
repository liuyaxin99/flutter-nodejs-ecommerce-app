const express = require("express");
const mongoose = require("mongoose");

const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

const PORT = process.env.PORT || 3000;
const app = express();
const DB =
  "mongodb+srv://liuyaxin:liuyaxin@cluster0.yvspyru.mongodb.net/amazonDB?retryWrites=true&w=majority";

// middleware clients(flutter)-> middleware -> server -> clients
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });


//0.0.0.0 for android simulator debug
//()=>{}  ==== function(){}
app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`); // using ``
});