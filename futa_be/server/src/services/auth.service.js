// src/services/auth.service.js
import User from '../models/user.model.js';
import { hashPassword, comparePassword } from '../utils/hash.js';

export const registerUser = async (name, email, password) => {
  const existing = await User.findOne({ email });
  if (existing) {
    throw new Error('Email đã tồn tại');
  }

  const hashed = await hashPassword(password);
  const user = await User.create({ name, email, password: hashed });

  return {
    id: user._id,
    name: user.name,
    email: user.email,
  };
};

export const loginUser = async (email, password) => {
  const user = await User.findOne({ email });
  if (!user) throw new Error('Email không tồn tại');

  const match = await comparePassword(password, user.password);
  if (!match) throw new Error('Sai mật khẩu');

  return {
    id: user._id,
    name: user.name,
    email: user.email,
  };
};
