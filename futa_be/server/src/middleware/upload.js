import multer from "multer";

const storage = multer.memoryStorage(); // lưu file vào RAM
export const upload = multer({ storage });
