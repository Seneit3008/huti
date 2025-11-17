// server/src/controllers/momo.controller.js
import { taoThanhToanMomo } from "../services/momo.service.js";

export const taoDonMomo = async (req, res) => {
  try {
    const { orderId, amount, orderInfo } = req.body;

    const momoRes = await taoThanhToanMomo({
      orderId,
      amount,
      orderInfo: orderInfo || `Thanh toán đơn #${orderId}`,
    });

    // log cho dễ debug
    console.log("🔥 [MOMO] response from MoMo:", momoRes);

    res.status(200).json(momoRes);
  } catch (err) {
    console.error("🔥 [MOMO] error:", err);
    res
      .status(400)
      .json({ message: "Lỗi tạo thanh toán MoMo", error: err.message });
  }
};

export const momoIpn = async (req, res) => {
  try {
    console.log("🔥 [MOMO] IPN:", req.body);
    // TODO: cập nhật trạng thái đơn hàng trong DB
    res.status(200).json({ message: "IPN received" });
  } catch (err) {
    console.error("🔥 [MOMO] IPN error:", err);
    // vẫn trả 200 để MoMo không spam retry
    res.status(200).json({ message: "error" });
  }
};