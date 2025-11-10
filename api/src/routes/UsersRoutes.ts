import express, { Request, Response } from "express";
import { UsersDA } from "../DA/UsersDA";
import { User } from "../models/User";

const router = express.Router();

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: API for managing users
 */

/**
 * @swagger
 * /users:
 *   post:
 *     summary: Create a new user
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       201:
 *         description: User created successfully
 *       500:
 *         description: Internal server error
 */
router.post("/", async (req: Request, res: Response) =>
{
    try
    {
        const user: User = req.body;
        const newId = await UsersDA.create(user);
        res.status(201).json({ message: "User created", userId: newId });
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to create user" });
    }
});

/**
 * @swagger
 * /users:
 *   get:
 *     summary: Get all users
 *     tags: [Users]
 *     responses:
 *       200:
 *         description: List of all users
 *       500:
 *         description: Internal server error
 */
router.get("/", async (_req: Request, res: Response) =>
{
    try
    {
        const users = await UsersDA.getAll();
        res.json(users);
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to fetch users" });
    }
});

/**
 * @swagger
 * /users/{id}:
 *   get:
 *     summary: Get a user by ID
 *     tags: [Users]
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         description: ID of the user
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: User data
 *       404:
 *         description: User not found
 *       500:
 *         description: Internal server error
 */
router.get("/:id", async (req: Request, res: Response) =>
{
    try
    {
        const id = Number(req.params.id);
        const user = await UsersDA.read(id);
        if (!user) return res.status(404).json({ message: "User not found" });
        res.json(user);
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to fetch user" });
    }
});

/**
 * @swagger
 * /users:
 *   put:
 *     summary: Update a user
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       200:
 *         description: User updated successfully
 *       400:
 *         description: UserId is required
 *       500:
 *         description: Internal server error
 */
router.put("/", async (req: Request, res: Response) =>
{
    try
    {
        const user: User = req.body;
        if (!user.userid)
            return res.status(400).json({ message: "UserId is required" });

        await UsersDA.update(user);
        res.json({ message: "User updated successfully" });
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to update user" });
    }
});

/**
 * @swagger
 * /users/{id}:
 *   delete:
 *     summary: Delete a user by ID
 *     tags: [Users]
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         description: ID of the user to delete
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: User deleted successfully
 *       500:
 *         description: Internal server error
 */
router.delete("/:id", async (req: Request, res: Response) =>
{
    try
    {
        const id = Number(req.params.id);
        await UsersDA.delete(id);
        res.json({ message: "User deleted successfully" });
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to delete user" });
    }
});

export default router;
