
import { Router } from 'express';
import { usersController } from '../controllers';

const usersRouter = Router({ mergeParams: true });
usersRouter.get('/api/user/:id', usersController.getOne);


export default usersRouter;
