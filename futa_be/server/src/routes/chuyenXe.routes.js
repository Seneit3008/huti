// src/routes/auth.routes.js
import express from 'express';
import { upload } from "../middleware/upload.js";
import { danhSachChuyenXe, themChuyenXe, themChuyenXeExcel, capNhatChuyenXe } from '../controllers/chuyenXe.controller.js';

const router = express.Router();

router.get('/danhSachChuyenXe',danhSachChuyenXe);
router.post('/themChuyenXe',themChuyenXe);
router.post("/themChuyenXeExcel", upload.single("file"), themChuyenXeExcel);
router.put("/capNhatChuyenXe/:ma_chuyen_xe", capNhatChuyenXe);

export default router;
