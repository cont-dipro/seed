import passport from 'passport';
import { Strategy as JwtStrategy, ExtractJwt } from 'passport-jwt';

export const getPassport = () => {
  const opts: any = {};
  opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
  opts.secretOrKey = process.env.SECRET_TOKEN;
  opts.ignoreExpiration = true;
  opts.jsonWebTokenOptions = {
    maxAge: '2d',
  };

  passport.use(new JwtStrategy(opts, async (req: any, next: any) => {
    try {
      return next(null, req.user);
    } catch (err) {
      return next(err);
    }
  }));

  return passport;
};
