import { taoThanhToanZaloPay } from "../services/zalopay.service.js";

// Tạo đơn ZaloPay
export const taoDonZaloPay = async (req, res) => {
  try {
    const { orderId, amount, orderInfo } = req.body;

    const zaloRes = await taoThanhToanZaloPay({
      orderId,
      amount,
      orderInfo: orderInfo || `Thanh toán đơn #${orderId}`,
    });

    console.log("🔥 [ZALOPAY] response:", zaloRes);

    return res.status(200).json(zaloRes);
  } catch (err) {
    console.error("🔥 [ZALOPAY] error:", err);
    return res
      .status(400)
      .json({ message: "Lỗi tạo thanh toán ZaloPay", error: err.message });
  }
};

// Webhook / IPN callback (ZaloPay gửi trạng thái thanh toán)
export const zaloPayIpn = async (req, res) => {
  try {
    console.log("🔥 [ZALOPAY] IPN:", req.body);

    // TODO: cập nhật trạng thái đơn hàng trong DB

    return res.status(200).json({ returncode: 1, message: "OK" });
  } catch (err) {
    console.error("🔥 [ZALOPAY] IPN error:", err);
    return res.status(200).json({ returncode: -1, message: "error" });
  }
};
