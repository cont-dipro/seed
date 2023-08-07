import { usersRepo } from "../repos";
import { NextFunction, Request, Response } from 'express';
import { accessToken, decodeToken, refreshToken } from "../utils/tokenUtils";
import { STATUS, messages } from "../commons";
import { combineMiddleware, handleMiddleware } from "../helpers";
import { User } from "@prisma/client";
import { usersValidation } from "../middlewares";


export const authController = {
  login: combineMiddleware(
    handleMiddleware(async (req: Request, res: Response) => {
      const user = await usersRepo.findOne(1);
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
  refreshToken: combineMiddleware(
    handleMiddleware(async (req: Request, res: Response) => {
      const decode = decodeToken(req.body.refreshToken);
      if (!decode) {
        return res.status(STATUS.NOT_FOUND).json({ error: messages.errors.users.notFound })
      }
      const user = await usersRepo.findOne(decode.id);
      const { password, ...newUser } = user;
      const token = await accessToken(newUser as User);

      return res.status(STATUS.OK).json({
        data: {
          token: token,
        }
      });
    })
  ),
}