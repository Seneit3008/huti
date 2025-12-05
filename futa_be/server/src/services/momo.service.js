// server/src/services/momo.service.js
import crypto from "crypto";
import axios from "axios";
import momoConfig from "../config/momo.config.js";

export async function taoThanhToanMomo({ orderId, amount, orderInfo }) {
  if (!momoConfig.secretKey) {
    throw new Error(
      "MOMO_SECRET_KEY is not defined. Vui lòng kiểm tra file .env và momo.config.js"
    );
  }

  const requestId = String(orderId);
  const requestType = "captureWallet";  // dùng cho tạo payUrl (có thể đổi payWithMethod nếu cần)
  const extraData = "";

  // đúng format ký MoMo yêu cầu
  const rawSignature =
    `accessKey=${momoConfig.accessKey}` +
    `&amount=${amount}` +
    `&extraData=${extraData}` +
    `&ipnUrl=${momoConfig.ipnUrl}` +
    `&orderId=${orderId}` +
    `&orderInfo=${orderInfo}` +
    `&partnerCode=${momoConfig.partnerCode}` +
    `&redirectUrl=${momoConfig.redirectUrl}` +
    `&requestId=${requestId}` +
    `&requestType=${requestType}`;

  const signature = crypto
    .createHmac("sha256", momoConfig.secretKey)
    .update(rawSignature)
    .digest("hex");

  const body = {
    partnerCode: momoConfig.partnerCode,
    accessKey: momoConfig.accessKey,
    requestId,
    amount: String(amount),
    orderId: String(orderId),
    orderInfo,
    redirectUrl: momoConfig.redirectUrl,
    ipnUrl: momoConfig.ipnUrl,
    requestType,
    signature,
    extraData,
    lang: "vi",
  };

  const response = await axios.post(momoConfig.endpoint, body);
  return response.data;          // trong này sẽ có payUrl / qrCode tùy cấu hình
}
