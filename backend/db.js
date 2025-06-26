const sql = require('mssql');

const config = {
  server: 'LAPTOP-SJHQ76LM',
  database: 'SetoBaghApp',
  user: 'sa',
  password: 'Robinson18',
  port: 1433, // Use your static port here
  options: {
    encrypt: false,
    trustServerCertificate: true,
    enableArithAbort: true
  },
  connectionTimeout: 30000,
  requestTimeout: 30000,
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000
  }
};

async function connectDB() {
  try {
    console.log('Attempting to connect to SQL Server...');
    console.log('Server:', config.server);
    console.log('Port:', config.port);
    console.log('Database:', config.database);
    
    const pool = await sql.connect(config);
    console.log('Connected to SQL Server database successfully');
    return pool;
  } catch (err) {
    console.error('Database connection failed:', err);
    console.error('Error details:', err.message);
    throw err;
  }
}

module.exports = { connectDB, sql };