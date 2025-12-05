import mongoose from "mongoose";

const XeSchema = new mongoose.Schema({
  bien_so: { type: String, unique: true },
  hang_xe: String,
  tong_so_ghe: Number,
  loai_nhien_lieu: String,
  tinh_trang: String,
});

export default mongoose.model("Xe", XeSchema, "xe");
