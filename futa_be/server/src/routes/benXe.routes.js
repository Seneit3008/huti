// src/routes/auth.routes.js
import express from 'express';
import { layDSBenXe, layDSTinhThanh  } from '../controllers/benXe.controller.js';

const router = express.Router();

router.get('/layDSBenXe', layDSBenXe);
router.get('/layDSTinhThanh', layDSTinhThanh);

export default router;
