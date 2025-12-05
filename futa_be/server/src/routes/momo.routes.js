// server/src/routes/momo.routes.js
import express from "express";
import { taoDonMomo, momoIpn } from "../controllers/momo.controller.js";

const router = express.Router();

// POST /api/momo/qr  -> tạo thanh toán MoMo
router.post("/qr", taoDonMomo);

// POST /api/momo/ipn -> MoMo gọi lại khi thanh toán xong
router.post("/ipn", momoIpn);

export default router;
