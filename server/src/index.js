import { config } from 'dotenv';
config();

import express, { urlencoded, json } from 'express';
const app = express();
import cors from 'cors';
import { connect } from 'mongoose';

import userRouter from './routes/userRoutes';
import roomRouter from './routes/roomRoutes';
import boardRouter from './routes/boardRoutes';
import taskRouter from './routes/taskRoutes';




app.use(urlencoded({ extended: true }));
app.use(json());
app.use(cors());

//middleware for logging
app.use((req,_,next)=>{
    console.log(`HTTP Method - ${req.method} , URL - ${req.url}  request body ${JSON.stringify(req.body)} `);
    next();
});

app.use('/users', userRouter);
app.use('/rooms', roomRouter);
app.use('/board',boardRouter);
app.use('task',taskRouter);
app.get('/',(_,res)=>{
    res.send("Task Management backend");
});

const port = process.env.PORT ||3000;

connect(process.env.MONGO_URL).then(()=>{
   console.log('connected mongo');
   app.listen(port, ()=>{
    console.log("server started at "+port);
});
}).catch((e)=>{
    console.log(`error on mongo server ${e}`);
});