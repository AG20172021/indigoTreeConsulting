import express from 'express';
import multer from 'multer';
import { PutObjectCommand } from '@aws-sdk/client-s3';
import { r2Client, r2Bucket, r2PublicUrl } from '../config/r2.js';

const router = express.Router();
const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 5 * 1024 * 1024 } });

router.post('/image', upload.single('file'), async (req, res) => {
  if (!r2Client) return res.status(503).json({ error: 'R2 not configured' });
  if (!req.file) return res.status(400).json({ error: 'No file' });

  const key = `uploads/${Date.now()}-${req.file.originalname}`;
  
  await r2Client.send(new PutObjectCommand({
    Bucket: r2Bucket,
    Key: key,
    Body: req.file.buffer,
    ContentType: req.file.mimetype,
  }));

  res.json({ url: `${r2PublicUrl}/${key}` });
});

export default router;