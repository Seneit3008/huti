// src/routes/auth.routes.js
import express from 'express';
import { dangKyKH, dangNhapKH, dangNhapNV  } from '../controllers/auth.controller.js';

const router = express.Router();

router.post('/dangKyKH', dangKyKH);
router.post('/dangNhapKH', dangNhapKH);
router.post('/dangNhapNV', dangNhapNV);

export default router;
