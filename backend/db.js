const config = {
  user: 'sa',
  password: 'Robinson18',
  server: 'localhost\\SQLEXPRESS', // double backslash for Node.js
  database: 'SetoBaghDB',
  port: 1433, // add this line if you set a specific port
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
};