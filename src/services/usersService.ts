import { usersRepo } from "../repos"


export const usersService = {
  getOne: async (id: number) => {
    return await usersRepo.findOne(id);
  }
}
