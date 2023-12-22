        const mongoose = require('mongoose');

        const RoomSchema = mongoose.Schema({
            roomName:{
                type: String,
                required : true
            },
        userId: {
                type: mongoose.Schema.Types.ObjectId,
                ref: 'User',
                required: true
            }
            
        },{timestamps: true});

        module.exports = mongoose.model('Rooms',RoomSchema);