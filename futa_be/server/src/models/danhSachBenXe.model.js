// src/models/user.model.js
import mongoose from 'mongoose';

const danhSachBenXe = new mongoose.Schema({
  name: { type: String, required: true },
  lat: { type: Number, required: true, unique: true },
  lng: { type: Number, required: true },
  province_id: { type: Number, required: true },
});

export default mongoose.model('danhSachBenXe', danhSachBenXe,'benXe');
