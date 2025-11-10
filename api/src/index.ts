import express from "express";
import dotenv from "dotenv";
import ItemsRoutes from "./routes/ItemsRoutes";

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get("/", (_, res) =>
{
    res.send("Lost & Found API is running 🚀");
});

app.use("/api/items", ItemsRoutes);

app.listen(port, () =>
{
    console.log(`✅ Server running on http://localhost:${port}`);
});
