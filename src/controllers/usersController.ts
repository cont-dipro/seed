import { usersRepo } from "../repos";
import { NextFunction, Request, Response } from 'express';
import { accessToken, refreshToken } from "../utils/tokenUtils";
import { STATUS, messages } from "../commons";
import { combineMiddleware, handleMiddleware } from "../helpers";
import { User } from "@prisma/client";
import { usersValidation } from "../middlewares";


export const usersController = {
  getOne: combineMiddleware(
    ...usersValidation.getOne,
    handleMiddleware(async (req: Request, res: Response) => {
      const userId = +req.params.id;
      console.log(req.user);

      const user = await usersRepo.findOne(userId);
      if (!user) {
        return res.status(STATUS.NOT_FOUND).json({ error: messages.errors.users.notFound })
      }
      const { password, ...newUser } = user;
      const token = await accessToken(newUser as User);
      const refresh = await refreshToken(user.id);

      return res.status(200).json({
        data: {
          token: token,
          refresh: refresh
        }
      });
    })
  ),
}