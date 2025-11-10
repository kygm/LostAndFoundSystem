import express from "express";
import dotenv from "dotenv";
import ItemsRoutes from "./routes/ItemsRoutes";
import LocationsRoutes from "./routes/LocationsRoutes";
import QrCodesRoutes from "./routes/QrCodesRoutes";
import swaggerJsdoc from "swagger-jsdoc";
import swaggerUi from "swagger-ui-express";

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

// Swagger setup
const swaggerOptions = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "Lost & Found API",
            version: "1.0.0",
            description: "API for managing lost and found items",
        },
    },
    apis: ["./src/routes/*.ts"], // <-- look for JSDoc comments in routes
};

const swaggerSpec = swaggerJsdoc(swaggerOptions);
app.use("/api/docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// Base route
app.get("/", (_, res) =>
{
    res.send("Lost & Found API is running 🚀");
});

// Items routes
app.use("/api/items", ItemsRoutes);
app.use("/api/locations", LocationsRoutes);
app.use("/api/qrcodes", QrCodesRoutes);



app.listen(port, () =>
{
    console.log(`✅ Server running on http://localhost:${port}`);
    console.log(`📄 Swagger UI available at http://localhost:${port}/api/docs`);
});
