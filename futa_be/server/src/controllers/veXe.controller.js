// src/controllers/auth.controller.js
import XLSX from "xlsx";
import veXe from "../models/veXe.model.js";
import chuyenXe from "../models/chuyenXe.model.js";

export const themVeXe = async (req, res) => {
  try {
    const { ma_khach_hang, ma_chuyen_xe, vi_tri_ghe, thoi_gian_dat_ve } = req.body;

    if (!ma_khach_hang || !ma_chuyen_xe || !vi_tri_ghe || vi_tri_ghe.length === 0) {
      return res.status(400).json({ message: "Thiếu thông tin bắt buộc!" });
    }

    // Lấy giá vé từ chuyến xe
    const chuyen = await chuyenXe.findOne({ ma_chuyen_xe });
    if (!chuyen) {
      return res.status(404).json({ message: "Không tìm thấy chuyến xe!" });
    }

    const so_ghe = vi_tri_ghe.length;
    const tong_tien = chuyen.gia_ve * so_ghe;

    const ma_ve = "VE" + Date.now() ; // tự sinh mã vé

    const ve = new veXe({
      ma_ve,
      ma_khach_hang,
      ma_chuyen_xe,
      vi_tri_ghe,
      so_ghe,
      tong_tien,
      thoi_gian_dat_ve: thoi_gian_dat_ve ? new Date(thoi_gian_dat_ve) : new Date()
    });

    await ve.save();

    res.status(201).json({
      message: "Tạo vé thành công!",
      data: ve
    });
  } catch (error) {
    res.status(500).json({ message: "Lỗi server", error: error.message });
  }
};


export const danhSachVeXe = async (req, res) => {
  try {
    const {
      ma_ve,
      ma_khach_hang,
      ma_chuyen_xe,
      trang_thai_thanh_toan,
      startDate,
      endDate,
      page = 1,
      limit = 20
    } = req.query;

    const filter = {};

    if (ma_ve) filter.ma_ve = ma_ve;
    if (ma_khach_hang) filter.ma_khach_hang = ma_khach_hang;
    if (ma_chuyen_xe) filter.ma_chuyen_xe = ma_chuyen_xe;
    if (trang_thai_thanh_toan) filter.trang_thai_thanh_toan = trang_thai_thanh_toan;

    // Lọc theo khoảng thời gian đặt vé
    if (startDate || endDate) {
      filter.thoi_gian_dat_ve = {};
      if (startDate) filter.thoi_gian_dat_ve.$gte = new Date(startDate);
      if (endDate) filter.thoi_gian_dat_ve.$lte = new Date(endDate);
    }

    const skip = (parseInt(page) - 1) * parseInt(limit);

    const dsVeXe = await veXe.find(filter)
      .sort({ thoi_gian_dat_ve: -1 }) // mới nhất lên đầu
      .skip(skip)
      .limit(parseInt(limit));

    const total = await veXe.countDocuments(filter);

    res.status(200).json({
      page: parseInt(page),
      limit: parseInt(limit),
      total,
      data: dsVeXe
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

