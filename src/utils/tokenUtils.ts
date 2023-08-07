import { User } from '@prisma/client';
import { decode, JwtPayload, sign, verify } from 'jsonwebtoken';


export const refreshToken = async (
  id: number,
) => {
  const payload = { id: id };
  return sign(payload,
    process.env.TOKEN_SECRET_JWT as string,
    {
      algorithm: 'HS256',
      expiresIn: process.env.REFRESH_TOKEN_TIME
    });
};

export const accessToken = async (
  user: User,
) => {
  const payload = { user: user };
  return sign(payload,
    process.env.TOKEN_SECRET_JWT as string,
    {
      algorithm: 'HS256',
      expiresIn: process.env.ACCESS_TOKEN_TIME
    });
};

export const decodeToken = (token: string) => {
  try {
    if (token.startsWith('Bearer ')) {
      token = token.replace('Bearer ', '');
    }
    verify(token, process.env.TOKEN_SECRET_JWT as string);
    const result = decode(token);

    return result as JwtPayload;
  }
  catch (error) {
    return null;
  }
};
