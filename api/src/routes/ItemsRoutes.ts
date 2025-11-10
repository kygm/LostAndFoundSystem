import express, { Request, Response } from "express";
import { ItemsDA } from "../DA/ItemsDA";
import { Item } from "../models/Item";

const router = express.Router();

// CREATE item
router.post("/", async (req: Request, res: Response) =>
{
    try
    {
        const item: Item = req.body;
        const newId = await ItemsDA.create(item);
        res.status(201).json({ message: "Item created", itemId: newId });
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to create item" });
    }
});

// READ item by ID
router.get("/:id", async (req: Request, res: Response) =>
{
    try
    {
        const id = Number(req.params.id);
        const item = await ItemsDA.read(id);
        if (!item) return res.status(404).json({ message: "Item not found" });
        res.json(item);
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to fetch item" });
    }
});

// UPDATE item
router.put("/", async (req: Request, res: Response) =>
{
    try
    {
        const item: Item = req.body;
        if (!item.itemid) return res.status(400).json({ message: "ItemId is required" });
        await ItemsDA.update(item);
        res.json({ message: "Item updated successfully" });
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to update item" });
    }
});

// DELETE item
router.delete("/:id", async (req: Request, res: Response) =>
{
    try
    {
        const id = Number(req.params.id);
        await ItemsDA.delete(id);
        res.json({ message: "Item deleted successfully" });
    } catch (err)
    {
        console.error(err);
        res.status(500).json({ error: "Failed to delete item" });
    }
});

export default router;
