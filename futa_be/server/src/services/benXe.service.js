// src/services/auth.service.js
import danhSachBenXe from '../models/danhSachBenXe.model.js';

export const layDSBenXe_SV = async (query) => {
  try {
    if (!query || query.trim() === '') return [];

    // Tìm bến xe tên chứa query, không phân biệt hoa/thường
    const results = await danhSachBenXe.find({
      name: { $regex: query, $options: 'i' }
    }).limit(5); // giới hạn 5 kết quả để tránh quá tải

    return results;
  } catch (error) {
    console.error('Lỗi khi lấy danh sách bến xe:', error);
    return [];
  }
};


export const layDSTinhThanh_SV = async (email, password) => {
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

