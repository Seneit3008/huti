import express from "express";
import { taoDonZaloPay, zaloPayIpn } from "../controllers/zalopay.controller.js";

const router = express.Router();

// Tạo đơn ZaloPay
router.post("/create", taoDonZaloPay);

// Webhook ZP gửi trạng thái
router.post("/ipn", zaloPayIpn);

export default router;
