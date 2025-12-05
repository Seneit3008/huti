// server/src/controllers/momo.controller.js
import { taoThanhToanMomo } from "../services/momo.service.js";

export const taoDonMomo = async (req, res) => {
  try {
    const { orderId, amount, orderInfo } = req.body;

    if (!orderId || !amount) {
      return res.status(400).json({
        message: "orderId và amount là bắt buộc",
      });
    }

    const momoRes = await taoThanhToanMomo({
      orderId,
      amount,
      orderInfo: orderInfo || `Thanh toán đơn #${orderId}`,
    });

    console.log("🔥 [MOMO] response from MoMo:", momoRes);

    // trả nguyên response, Flutter sẽ đọc payUrl / qrCode ở đây
    res.status(200).json(momoRes);
  } catch (err) {
    console.error("🔥 [MOMO] error:", err.response?.data || err.message || err);

    res.status(400).json({
      message: "Lỗi tạo mã QR MoMo",
      error: err.response?.data || err.message || err,
    });
  }
};

// ✅ PHẢI export đúng tên momoIpn như router đang import
export const momoIpn = async (req, res) => {
  try {
    console.log("🔥 [MOMO] IPN:", req.body);
    // TODO: update trạng thái đơn hàng trong DB nếu cần
    res.status(200).json({ message: "IPN received" });
  } catch (err) {
    console.error("🔥 [MOMO] IPN error:", err);
    // vẫn trả 200 để MoMo không spam retry
    res.status(200).json({ message: "error" });
  }
};
