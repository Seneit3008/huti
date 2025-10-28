// src/controllers/auth.controller.js
import { loginUser, registerUser } from '../services/auth.service.js';

export const register = async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const user = await registerUser(name, email, password);
    return res.status(201).json({ user });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await loginUser(email, password);
    return res.status(200).json({ user });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};
