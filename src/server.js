import express from 'express';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import uploadRoutes from './routes/uploads.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use('/api/uploads', uploadRoutes);

// Serve static files from public/
app.use(express.static(join(__dirname, '../public')));

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));