const mongoose = require('mongoose');

const userAssignmentSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    }
   
}, {timestamp: true});

const roomRecordsSchema = mongoose.Schema({
    roomId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Rooms',
        required: true
    },
    assignedUsers: [userAssignmentSchema]
    
}, {timestamp: true});

module.exports = mongoose.model('Record', roomRecordsSchema);
