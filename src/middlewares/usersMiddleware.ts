import { body, param } from "express-validator";
import { validationResultMiddleware } from "../helpers";


export const usersValidation = {
  getOne: [
    param("id").isInt(),
    validationResultMiddleware
  ]
}