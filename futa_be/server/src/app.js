// src/app.js
import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import benXeRoutes from './routes/benXe.routes.js';
import xeRoutes from './routes/xe.routes.js';
import veXeRoutes from './routes/veXe.routes.js';
import chuyenXeRoutes from './routes/veXe.routes.js';
import zaloPayRoutes from "./routes/zalopay.routes.js";
import momoRoutes from "./routes/momo.routes.js";
const app = express();
app.use(cors());
app.use(express.json());

app.use('/api/dangNhapDangKy', authRoutes);
app.use('/api/danhSachBenXe', benXeRoutes);
app.use('/api/xe', xeRoutes);
app.use('/api/chuyenXe', chuyenXeRoutes);
app.use('/api/veXe', veXeRoutes);
app.use("/api/zalopay", zaloPayRoutes);
app.use("/api/momo", momoRoutes);

export default app;
