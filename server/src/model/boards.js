        const mongoose = require('mongoose');

        const BoardSchema = mongoose.Schema({
        boardName:{
            type: String,
            required : true,
        },
        boardDescription:{
            type: String,
            required : true,
            },
        userId:  {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true
        },
        roomId:{
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Rooms',
            required: true
        }

        }, {timestamps: true});


        module.exports = mongoose.model('Boards', BoardSchema);