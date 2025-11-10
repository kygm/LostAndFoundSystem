import express, { Request, Response } from "express";

const app = express();
const port = 3000;

app.use(express.json());

app.get("/", (_req: Request, res: Response) =>
{
    res.send("Lost & Found API is running 🚀");
});

app.listen(port, () =>
{
    console.log(`✅ Server running at http://localhost:${port}`);
});
