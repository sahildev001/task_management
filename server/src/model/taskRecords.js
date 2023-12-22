import { Schema, model } from 'mongoose';
const assignedBoardSchema = Schema({
    board: {
        type: Schema.Types.ObjectId,
        ref: 'Boards',
        required: true
    }
}, {timestamp: true});

const taskRecordsSchema = Schema({
    taskId: {
        type: Schema.Types.ObjectId,
        ref: 'Task',
        required: true
    },
    boardIds:[assignedBoardSchema]
},{timestamp: true});

export default model('taskRecords',taskRecordsSchema)