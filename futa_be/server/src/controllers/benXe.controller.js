// src/controllers/auth.controller.js
import { layDSBenXe_SV, layDSTinhThanh_SV} from '../services/benXe.service.js';

export const layDSBenXe = async (req, res) => {
  try {
    const query = req.query.q; // lấy từ ?q=...
    const benXe = await layDSBenXe_SV(query);
    return res.status(200).json(benXe); // trả trực tiếp array
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};


export const layDSTinhThanh = async (req, res) => {
  try {
    const { query } = req.body;
    const benXe = await layDSTinhThanh_SV(query);
    return res.status(200).json({ benXe });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};
