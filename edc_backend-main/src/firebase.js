import admin from 'firebase-admin';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { readFileSync } from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const serviceAccount = JSON.parse(
    readFileSync(join(__dirname, 'services', 'e-donation-community-v2-firebase-adminsdk-fbsvc-4bd39e6f75.json'))
);

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

export default admin;
