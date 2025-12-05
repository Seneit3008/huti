import ChuyenXe from "../models/chuyenXe.model.js";
import XLSX from "xlsx";
export const danhSachChuyenXe = async (req, res) => {
  try {
    const {
      ben_di,
      ben_den,
      bien_so,
      ma_chuyen_xe,
      startDate,
      endDate,
      page = 1,
      limit = 20
    } = req.query;

    const filter = {};
    if (ben_di) filter.ben_di = ben_di;
    if (ben_den) filter.ben_den = ben_den;
    if (bien_so) filter.bien_so = bien_so;
    if (ma_chuyen_xe) filter.ma_chuyen_xe = ma_chuyen_xe;

    // Lọc theo khoảng ngày đi
    if (startDate || endDate) {
      filter.ngay_di = {};
      if (startDate) filter.ngay_di.$gte = new Date(startDate);
      if (endDate) filter.ngay_di.$lte = new Date(endDate);
    }

    const skip = (parseInt(page) - 1) * parseInt(limit);

    const dsChuyenXe = await ChuyenXe.find(filter)
      .sort({ ngay_di: 1, gio_di: 1 })
      .skip(skip)
      .limit(parseInt(limit));

    const total = await ChuyenXe.countDocuments(filter);

    res.status(200).json({
      page: parseInt(page),
      limit: parseInt(limit),
      total,
      data: dsChuyenXe
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};



export const themChuyenXe = async (req, res) => {
  try {
    const {
      bien_so,
      ben_di,
      ben_den,
      ngay_di,
      gio_di,
      so_cho_trong,
      so_cho_dat,
      gia_ve,
      ghi_chu
    } = req.body;

    // Validate các trường bắt buộc
    if (!bien_so || !ben_di || !ben_den || !ngay_di || !gio_di || !gia_ve) {
      return res.status(400).json({ message: "Thiếu thông tin bắt buộc" });
    }

    // Lấy chuyến xe cuối cùng để tạo mã tự động
    const lastChuyen = await ChuyenXe.findOne().sort({ createdAt: -1 });
    let ma_chuyen_xe;
    if (lastChuyen && lastChuyen.ma_chuyen_xe) {
      // Lấy số cuối cùng và tăng lên 1
      const lastNumber = parseInt(lastChuyen.ma_chuyen_xe.replace("CX", ""), 10);
      ma_chuyen_xe = `CX${String(lastNumber + 1).padStart(3, "0")}`;
    } else {
      ma_chuyen_xe = "CX001";
    }

    // Tạo mới chuyến xe
    const chuyenXeMoi = new ChuyenXe({
      ma_chuyen_xe,
      bien_so,
      ben_di,
      ben_den,
      ngay_di,
      gio_di,
      so_cho_trong: so_cho_trong || 0,
      so_cho_dat: so_cho_dat || 0,
      gia_ve,
      ghi_chu: ghi_chu || ""
    });

    await chuyenXeMoi.save();

    res.status(201).json({ message: "Thêm chuyến xe thành công", data: chuyenXeMoi });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};


// API thêm nhiều chuyến xe từ file Excel
export const themChuyenXeExcel = async (req, res) => {
  try {
    if (!req.file) return res.status(400).json({ message: "Chưa chọn file" });

    const workbook = XLSX.readFile(req.file.path);
    const sheetName = workbook.SheetNames[0];
    const data = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName]);

    const chuyenXeMoi = [];

    // Sinh ma_chuyen_xe tự động dựa trên số lượng hiện có
    const lastChuyen = await ChuyenXe.findOne().sort({ createdAt: -1 });
    let lastNumber = lastChuyen && lastChuyen.ma_chuyen_xe 
                     ? parseInt(lastChuyen.ma_chuyen_xe.replace("CX", ""), 10)
                     : 0;

    for (const item of data) {
      lastNumber++;
      const ma_chuyen_xe = `CX${String(lastNumber).padStart(3, "0")}`;

      chuyenXeMoi.push({
        ma_chuyen_xe,
        bien_so: item.bien_so,
        ben_di: item.ben_di,
        ben_den: item.ben_den,
        ngay_di: new Date(item.ngay_di),
        gio_di: item.gio_di,
        gia_ve: item.gia_ve,
        ghi_chu: item.ghi_chu || "",
        tinh_trang: item.tinh_trang
      });
    }

    // Lưu tất cả vào database
    const result = await ChuyenXe.insertMany(chuyenXeMoi);

    res.status(201).json({ message: "Thêm chuyến xe thành công", total: result.length });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err.message });
  }
};


export const capNhatChuyenXe = async (req, res) => {
  try {
    const { ma_chuyen_xe } = req.params;
    const payload = req.body;

    // 1️⃣ Tìm chuyến xe
    const chuyen = await ChuyenXe.findOne({ ma_chuyen_xe });

    if (!chuyen) {
      return res.status(404).json({ message: "Không tìm thấy chuyến xe!" });
    }

    // 2️⃣ Kiểm tra đã có vé đặt chưa
    if (chuyen.so_cho_dat > 0) {
      return res.status(400).json({
        message: "Không thể cập nhật. Chuyến xe đã có vé được đặt!",
      });
    }

    // 3️⃣ Cập nhật các trường hợp lệ
    const fields = [
      "bien_so",
      "ben_di",
      "ben_den",
      "ngay_di",
      "gio_di",
      "gia_ve",
      "ghi_chu"
    ];

    fields.forEach(field => {
      if (payload[field] !== undefined) {
        chuyen[field] = payload[field];
      }
    });

    await chuyen.save();

    return res.status(200).json({
      message: "Cập nhật chuyến xe thành công!",
      data: chuyen
    });

  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};