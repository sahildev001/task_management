import { Router } from 'express';
import auth from '../middlewares/auth';
import { createTask, updateTask } from '../controllers/taskController';

const taskRouter = Router();

taskRouter.post('/create',auth,createTask);
taskRouter.post('/update',auth,updateTask)

export default taskRouter;