import { User } from "@prisma/client";
import prisma from "../utils/db";


export const usersRepo = {
  findOne: async (id: number) => {
    const user = await prisma.user.findUnique({
      where: {
        id: id,
      }
    })

    return user as User;
  },

}
