// src/controllers/auth.controller.js
import { dangNhapKH_SV, dangKyKH_SV, dangNhapNV_SV } from '../services/auth.service.js';

export const dangKyKH = async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const khachHang = await dangKyKH_SV(name, email, password);
    return res.status(201).json({ khachHang });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

export const dangNhapKH = async (req, res) => {
  try {
    const { email, password } = req.body;
    const khachHang = await dangNhapKH_SV(email, password);
    return res.status(200).json({ khachHang });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

export const dangNhapNV = async (req, res) => {
  try {
    const { email, password } = req.body;
    const nhanVien = await dangNhapNV_SV(email, password);
    return res.status(200).json({ nhanVien });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};
