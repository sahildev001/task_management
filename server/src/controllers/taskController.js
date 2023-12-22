import { findOne, create, findOneAndUpdate } from "../model/task";
import taskRecordsModel from '../model/taskRecords';

const createTask = async (req, res) => {
  const { taskName, taskDescription, boardId } = req.body;

  const userId = req.userId;
  try {
    //validate body

    if (!taskName || taskName == "") {
      return res.status(400).json({
        message: "task name should not be empty",
      });
    } else if (!taskDescription || taskDescription == "") {
      return res.status(400).json({
        message: "task Description should not be empty",
      });
    } else if (!boardId || boardId == "") {
      return res.status(400).json({
        message: "boardId should not be empty",
      });
    }

    // check task already created in board;
    const validateTasks = await findOne({
      taskName: taskName,
      userId: userId,
      boardId: boardId,
    });

    if (validateTasks) {
      return res.status(400).json({
        message: "Tasks already created",
      });
    }

    const result = await create({
      taskName: taskName,
      taskDescription: taskDescription,
      userId: userId,
      boardId: boardId,
    });

    return res.status(200).json({
      data: result,
    });
  } catch (error) {
    return res.status(500).json({
      message: "Internal server error",
    });
  }
};


const updateTask = async (req, res) => {
    const { taskId, newBoardId } = req.body;
    const userId = req.userId;

    // Validate tasks body
    if (!taskId || taskId === "") {
        return res.status(400).json({
            message: 'Task id should not be empty',
        });
    } else if (!newBoardId || newBoardId === "") {
        return res.status(400).json({
            message: 'New board id should not be empty',
        });
    }

    try {
        // Find task that needs to be updated
        const task = await findOne({ _id: taskId });
        if (!task) {
            return res.status(404).json({
                message: 'Task not found',
            });
        }

        // Call findOneAndUpdate to update task
        const updateTaskData = await findOneAndUpdate(
            { _id: taskId },
            { boardId: newBoardId },
            { new: true } // Return the modified document
        );

        // Check if the task was successfully updated
        if (!updateTaskData) {
            return res.status(500).json({
                message: 'Failed to update task',
            });
        }

        // Update task record with new boardId
        const updatedTaskRecord = await taskRecordsModel.findOneAndUpdate(
            { _id: taskId },
            { $push: { boardIds: newBoardId } },
            { new: true } // Return the modified document
        );

        return res.status(200).json({
            data: updateTaskData,
        });
    } catch (error) {
        return res.status(500).json({
            message: 'Internal Server Error',
        });
    }
};

export default {createTask,updateTask};