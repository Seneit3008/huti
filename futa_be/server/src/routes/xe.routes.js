// src/routes/auth.routes.js
import express from 'express';
import { upload } from "../middleware/upload.js";
import { themXe, themXeExcel, timKiemXe, capNhatTinhTrangXe } from '../controllers/xe.controller.js';

const router = express.Router();

router.post('/themXe', themXe);
router.post("/themXeExcel", upload.single("file"), themXeExcel); // upload file excel
router.get("/timKiemXe", timKiemXe);
router.put("/capNhatTinhTrangXe/:bien_so", capNhatTinhTrangXe);

export default router;
