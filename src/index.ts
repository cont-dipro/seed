import passport from 'passport';
import express from 'express'
import { getPassport } from './helpers/passportHelpers';
import usersRouter from './routers/usersRouter';
import authRouter from './routers/authRouter';

const app = express()

app.use(passport.initialize());

const authenticate = getPassport();
app.use(express.json())

app.use(authRouter)
// app.use(authenticate.authenticate('jwt', { session: false }), usersRouter)
app.use(usersRouter)



app.get('/cow', authenticate.authenticate('jwt', { session: false }), async (req, res) => {
  res.json("oke")
})

const server = app.listen(3000, () =>
  console.log(`
🚀 Server ready at: http://localhost:3000
⭐️ See sample requests: http://pris.ly/e/ts/rest-express#3-using-the-rest-api`),
)
