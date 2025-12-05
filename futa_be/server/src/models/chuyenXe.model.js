import mongoose from "mongoose";

const ChuyenXeSchema = new mongoose.Schema({
  ma_chuyen_xe: { type: String, unique: true, required: true },
  bien_so: { type: String, required: true },
  ben_di: { type: String, required: true },
  ben_den: { type: String, required: true },
  ngay_di: { type: Date, required: true },
  gio_di: { type: String, required: true },
  gia_ve: { type: Number, required: true },
  ghi_chu: { type: String },
  tinh_trang: { type: String }
});

export default mongoose.model("ChuyenXe", ChuyenXeSchema, "chuyenXe");
