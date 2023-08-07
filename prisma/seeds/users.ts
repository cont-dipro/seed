import { Prisma } from "@prisma/client";

export const users: Prisma.UserCreateInput[] = [
  {
    email: "aaa@gmail.com",
    password: "123456Aa",
    name: "aaa",
  },
  {
    email: "bbb@gmail.com",
    password: "123456Aa",
    name: "bbb",
  },
  {
    email: "ccc@gmail.com",
    password: "123456Aa",
    name: "ccc",
  }
]
