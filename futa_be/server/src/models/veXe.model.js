import mongoose from "mongoose";

const VeXeSchema = new mongoose.Schema({
  ma_ve: { type: String, unique: true, required: true }, // V0001...
  ma_khach_hang: { type: String, required: true }, // KHxxxx
  ma_chuyen_xe: { type: String, required: true }, // CXxxxx

  so_ghe: { type: Number, required: true }, // Số lượng vé khách đặt

  vi_tri_ghe: [{ type: String, required: true }], 
  // ví dụ: ["A01", "A02"] → Hỗ trợ đặt nhiều ghế trong 1 phiếu

  tong_tien: { type: Number, required: true }, // giá vé * số ghế
  trang_thai_thanh_toan: {
    type: String,
    enum: ["CHUA_THANH_TOAN", "DA_THANH_TOAN", "HOAN_TIEN"],
    default: "CHUA_THANH_TOAN"
  },

  thoi_gian_dat_ve: { type: Date, default: Date.now }
});

export default mongoose.model("VeXe", VeXeSchema, "veXe");
