// server/src/config/zalopay.config.js
import dotenv from "dotenv";
dotenv.config();

const zaloPayConfig = {
  appId: process.env.ZP_APP_ID,
  key1: process.env.ZP_KEY1,
  key2: process.env.ZP_KEY2,
  endpoint: process.env.ZP_ENDPOINT,
  callbackUrl: process.env.ZP_CALLBACK_URL,
};

export default zaloPayConfig;
