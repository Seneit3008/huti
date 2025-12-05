// src/controllers/auth.controller.js
import XLSX from "xlsx";
import Xe from "../models/xe.model.js";

export const themXe = async (req, res) => {
  try {
    const { bien_so, hang_xe, tong_so_ghe, loai_nhien_lieu, tinh_trang } = req.body;

    if (!bien_so) {
      return res.status(400).json({ message: "Biển số xe không được bỏ trống" });
    }

    // Kiểm tra trùng biển số
    const existed = await Xe.findOne({ bien_so });
    if (existed) {
      return res.status(400).json({ message: "Biển số xe đã tồn tại" });
    }

    const xe = await Xe.create({
      bien_so,
      hang_xe,
      tong_so_ghe,
      loai_nhien_lieu,
      tinh_trang,
    });

    res.status(201).json({ message: "Thêm xe thành công", data: xe });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};


export const themXeExcel = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: "Không có file tải lên" });
    }

    // Đọc file Excel từ buffer
    const workbook = XLSX.read(req.file.buffer, { type: "buffer" });
    const sheet = workbook.Sheets[workbook.SheetNames[0]]; // sheet đầu tiên
    const data = XLSX.utils.sheet_to_json(sheet);

    /*
      Excel phải có cột:
      id | bien_so | hang_xe | tong_so_ghe | loai_nhien_lieu | tinh_trang
    */

    // Lọc biển số không trùng
    let inserted = [];
    for (const item of data) {
      const existed = await Xe.findOne({ bien_so: item.bien_so });
      if (!existed) {
        inserted.push(item);
      }
    }

    if (inserted.length === 0) {
      return res.status(400).json({ message: "Tất cả biển số đã tồn tại, không có dữ liệu mới" });
    }

    const result = await Xe.insertMany(inserted);

    res.status(201).json({
      message: "Import danh sách xe thành công",
      so_luong: result.length,
      data: result,
    });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};



export const timKiemXe = async (req, res) => {
  try {
    const { keyword } = req.query;

    if (!keyword || keyword.trim() === "") {
      return res.status(400).json({ message: "Thiếu từ khóa tìm kiếm" });
    }

    // Tạo regex không phân biệt hoa/thường
    const regex = new RegExp(keyword, "i");

    // Tìm theo nhiều trường
    const result = await Xe.find({
      $or: [
        { bien_so: regex },
        { hang_xe: regex },
        { loai_nhien_lieu: regex },
        { tinh_trang: regex }
      ]
    });

    if (result.length === 0) {
      return res.status(404).json({ message: "Không tìm thấy xe nào" });
    }

    res.status(200).json({
      message: "Tìm kiếm thành công",
      so_luong: result.length,
      data: result
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};


// =======================================================
// API Cập nhật tình trạng xe theo bien_so
// PUT /xe/tinh-trang/:bien_so
// =======================================================
export const capNhatTinhTrangXe = async (req, res) => {
  try {
    const { bien_so } = req.params; // biển số xe
    const { tinh_trang } = req.body; // trạng thái mới

    if (!tinh_trang) {
      return res.status(400).json({ message: "Thiếu trường tinh_trang" });
    }

    // Tìm và cập nhật theo bien_so
    const xe = await Xe.findOneAndUpdate(
      { bien_so: bien_so },
      { tinh_trang: tinh_trang },
      { new: true } // trả về bản ghi mới sau khi update
    );

    if (!xe) {
      return res.status(404).json({ message: `Không tìm thấy xe với biển số ${bien_so}` });
    }

    res.status(200).json({ message: "Cập nhật tình trạng xe thành công", data: xe });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
