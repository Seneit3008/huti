// server/src/routes/momo.routes.js
import express from "express";
import { taoDonMomo, momoIpn } from "../controllers/momo.controller.js";

const router = express.Router();

// POST /api/momo/create
router.post("/create", taoDonMomo);

// POST /api/momo/ipn
router.post("/ipn", momoIpn);

export default router;
