// server/src/services/zalopay.service.js
import axios from "axios";
import crypto from "crypto";
import zaloPayConfig from "../config/zalopay.config.js";

function getAppTransId() {
  // yymmdd_xxxxxx
  const d = new Date();
  const yy = d.getFullYear().toString().slice(-2);
  const mm = (d.getMonth() + 1).toString().padStart(2, "0");
  const dd = d.getDate().toString().padStart(2, "0");
  const date = `${yy}${mm}${dd}`;
  const rand = Math.floor(Math.random() * 1000000);
  return `${date}_${rand}`;
}

export async function taoThanhToanZaloPay({ orderId, amount, orderInfo }) {
  const appid = Number(zaloPayConfig.appId);
  const key1 = zaloPayConfig.key1;
  const endpoint = zaloPayConfig.endpoint;

  if (!appid || !key1 || !endpoint) {
    throw new Error("Thiếu config ZaloPay (appid, key1, endpoint).");
  }

  const apptransid = getAppTransId();
  const appuser = "user123"; // tạm, có thể là id KH
  const apptime = Date.now();
  const embeddata = JSON.stringify({ redirecturl: zaloPayConfig.callbackUrl });
  const item = JSON.stringify([]);

  const rawData = [
    appid,
    apptransid,
    appuser,
    amount,
    apptime,
    embeddata,
    item,
  ].join("|");

  const mac = crypto.createHmac("sha256", key1).update(rawData).digest("hex");

  const body = {
    appid,
    apptransid,
    appuser,
    apptime,
    amount,
    description: orderInfo || `Thanh toán đơn hàng ${orderId}`,
    bankcode: "zalopayapp",
    item,
    embeddata,
    mac,
    callbackurl: zaloPayConfig.callbackUrl,
  };

  console.log("🔥 [ZP] body:", body);

  const response = await axios.post(endpoint, body, {
    headers: { "Content-Type": "application/json" },
  });

  const data = response.data;
  console.log("🔥 [ZP] response:", data);

  if (data.returncode !== 1) {
    throw new Error(
      `ZaloPay error: returncode=${data.returncode}, message=${data.returnmessage}`
    );
  }

  return {
    orderUrl: data.orderurl,
    zpTransToken: data.zp_trans_token,
    appTransId: apptransid,
  };
}
