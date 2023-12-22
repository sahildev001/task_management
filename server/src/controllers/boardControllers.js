import { findOne, create } from '../model/boards';


const createBoard =  async (req,res)=>{
    const {boardName,boardDescription, roomId} = req.body;
    const userId = req.userId;
   try{

     //validate 
     if((!boardName) || boardName ==""){
        return res.status(400).json({
            message: 'boardName should not be empty'
        });
    }else if((!boardDescription) || boardDescription ==""){
        return res.status(400).json({
            message: 'boardDescription should not be empty'
        });
    }else if((!roomId) || roomId == ""){
        return res.status(400).json({
            message: 'roomId should not be empty'
        });
    }
  
    //  check board is already created
     const validateBoard = await findOne({
        boardName: boardName,
        userId: userId,
        roomId: roomId
     });

     if(validateBoard) {
        return res.status(400).json({
          message: "Board name already exists"
        });
     }

  // create board 
    const result = await create({
        boardName: boardName,
        boardDescription: boardDescription,
        userId: userId,
        roomId: roomId
    })

    return res.status(200).json({
      data: result
    });
   }catch(error){
     return res.status(500).json("Internal server error");
   }
    


}


export default {createBoard};