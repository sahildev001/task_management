import { findOne, create } from '../model/room';

const createRoom = async(req,res)=>{
    const {roomName}  = req.body;
    const userId = req.userId;

    try{
       if((!roomName) || roomName ==""){
        return res.status(400).json({
            message: 'roomName should not be empty' 
        });
       }

       //check room name already created for user
       const validateRoom = await findOne({
        userId : userId,
         roomName: roomName
       });
       if(validateRoom){
        return res.status(400).json({message: "room name already exists"});
       }

        const result = await create({
            roomName: roomName,
            userId : userId
        });

        return res.status(200).json({
            data: result
        })

    }catch(error){
      return res.status(500).json("Internal server Error");
    }
}


export default {createRoom};
