// src/routes/auth.routes.js
import express from 'express';
import { upload } from "../middleware/upload.js";
import { themVeXe, danhSachVeXe } from '../controllers/veXe.controller.js';

const router = express.Router();

router.post('/themVeXe',themVeXe);

router.get('/danhSachVeXe',danhSachVeXe);
// router.post("/themChuyenXeExcel", upload.single("file"), themChuyenXeExcel);
// router.put("/capNhatChuyenXe/:ma_chuyen_xe", capNhatChuyenXe);

export default router;
