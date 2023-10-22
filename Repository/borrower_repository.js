const sql = require('mssql');
const config = {
  user: process.env.SA_USER,
  password: process.env.SA_PASSWORD,
  database: process.env.DB_NAME,
  server: 'localhost',
  options: {
    trustServerCertificate: true
  }
};

async function createBorrower(email, name){
    const pool = await sql.connect(config);
    const result = await pool.request()
        .input('email', sql.VarChar(50), email)
        .input('name', sql.VarChar(255), name)
        .query('EXEC CreateBorrower @Email=@email, @Name=@name');
    pool.close();

    return result;
}

async function readBorrower(email){
  const pool = await sql.connect(config);
  const result = await pool.request()
      .input('email', sql.VarChar(50), email)
      .query('EXEC ReadBorrower @Email=@email');
  pool.close();

  return result;
}

async function updateBorrower(email, name){
  const pool = await sql.connect(config);
  const result = await pool.request()
      .input('email', sql.VarChar(50), email)
      .input('name', sql.VarChar(255), name)
      .query('EXEC UpdateBorrower @Email=@email, @Name=@name');
  pool.close();

  return result;
}

async function deleteBorrower(email){
  const pool = await sql.connect(config);
  const result = await pool.request()
      .input('email', sql.VarChar(50), email)
      .query('EXEC DeleteBorrower @Email=@email');
  pool.close();

  return result;
}

async function getAllBorrowers(){
  const pool = await sql.connect(config);
  const result = await pool.request().query('EXEC GetAllBorrowers');
  pool.close();

  return result;
}

module.exports = {createBorrower, readBorrower, updateBorrower, deleteBorrower, getAllBorrowers}