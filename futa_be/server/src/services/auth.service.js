// src/services/auth.service.js
import khachHang from '../models/khachHang.model.js';
import nhanVien from '../models/nhanVien.model.js';
import { hashPassword, comparePassword } from '../utils/hash.js';

export const dangKyKH_SV = async (name, email, password) => {
  const existing = await khachHang.findOne({ email });
  if (existing) {
    throw new Error('Email đã tồn tại');
  }
  

  const hashed = await hashPassword(password);
  const KhachHang = await khachHang.create({ name, email, password: hashed });

  return {
    id: KhachHang._id,
    name: KhachHang.name,
    email: KhachHang.email,
  };
};


export const dangNhapKH_SV = async (email, password) => {
  const KhachHang = await khachHang.findOne({ email });
  if (!KhachHang) throw new Error('Email không tồn tại');

  const match = await comparePassword(password, KhachHang.password);
  if (!match) throw new Error('Sai mật khẩu');

  return {
    id: KhachHang._id,
    name: KhachHang.name,
    email: KhachHang.email,
  };
};

export const dangNhapNV_SV = async (email, password) => {
  const NhanVien = await nhanVien.findOne({ email });
  if (!NhanVien) throw new Error('Email không tồn tại');

  const match = await comparePassword(password, NhanVien.password);
  if (!match) throw new Error('Sai mật khẩu');

  return {
    id: NhanVien._id,
    name: NhanVien.name,
    email: NhanVien.email,
  };
};
