const sql = require('mssql');
const config = {
  user: process.env.SA_USER,
  password: process.env.SA_PASSWORD,
  database: process.env.DB_NAME,
  server: process.env.DB_HOST,
  options: {
    trustServerCertificate: true
  }
};

async function borrowBook(isbn, email, quantity, dueDate){
    const pool = await sql.connect(config);
    const result = await pool.request()
        .input('isbn', sql.VarChar(13), isbn)
        .input('email', sql.VarChar(50), email)
        .input('quantity', sql.Int, quantity)
        .input('dueDate', sql.DateTime, dueDate)
        .query(`EXEC BorrowBook @ISBN=@isbn, @Email=@email, @Due_Date=@dueDate${quantity?', @Quantity=@quantity':''}`);
    pool.close();

    return result;
}

async function returnBook(isbn, email){
    const pool = await sql.connect(config);
    const result = await pool.request()
        .input('isbn', sql.VarChar(13), isbn)
        .input('email', sql.VarChar(50), email)
        .query('EXEC ReturnBook @ISBN=@isbn, @Email=@email');
    pool.close();

    return result;
}

async function getMyBooks(email){
    const pool = await sql.connect(config);
    const result = await pool.request()
        .input('email', sql.VarChar(50), email)
        .query('EXEC GetMyBooks @Email=@email');
    pool.close();

    return result;
}

async function getOverdueBorrows(){
    const pool = await sql.connect(config);
    const result = await pool.request().query('EXEC GetOverdueBorrows');
    pool.close();

    return result;
}

module.exports = {borrowBook, returnBook, getMyBooks, getOverdueBorrows}