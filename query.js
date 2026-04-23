require('dotenv').config({ path: './backend/.env' });
const pool = require('./backend/config/db');
async function test() {
  const [rows] = await pool.query('SELECT * FROM Supplier_Services LIMIT 5');
  console.log('Supplier_Services:', rows);
  const [svcs] = await pool.query('SELECT * FROM Services LIMIT 5');
  console.log('Services:', svcs);
  process.exit(0);
}
test();
