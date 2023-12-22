const mongoose = require("mongoose");

const TaskSchema = mongoose.Schema(
  {
    taskName: {
      type: String,
      required: true,
    },
    taskDescription: {
      type: String,
      required: true,
    },
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },

    boardId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Boards",
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Task", TaskSchema);
