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

async function createBook(isbn, title, author, quantity, shelfNumber){
    const pool = await sql.connect(config);
    const result = await pool.request()
        .input('isbn', sql.VarChar(13), isbn)
        .input('title', sql.VarChar(255), title)
        .input('author', sql.VarChar(255), author)
        .input('quantity', sql.Int, quantity)
        .input('shelfNumber', sql.Int, shelfNumber)
        .query(`EXEC CreateBook @ISBN=@isbn, @Title=@title, @Author=@author${quantity?', @Quantity=@quantity':''}${shelfNumber?', @Shelf_Number=@shelfNumber':''}`);
    pool.close();

    return result;
}

async function readBook(isbn){
  const pool = await sql.connect(config);
  const result = await pool.request()
      .input('isbn', sql.VarChar(13), isbn)
      .query('EXEC ReadBook @ISBN=@isbn');
  pool.close();

  return result;
}

async function updateBook(isbn, title, author, quantity, shelfNumber){
  const pool = await sql.connect(config);
  const result = await pool.request()
      .input('isbn', sql.VarChar(13), isbn)
      .input('title', sql.VarChar(255), title)
      .input('author', sql.VarChar(255), author)
      .input('quantity', sql.Int, quantity)
      .input('shelfNumber', sql.Int, shelfNumber)
      .query('EXEC UpdateBook @ISBN=@isbn, @Title=@title, @Author=@author, @Quantity=@quantity, @Shelf_Number=@shelfNumber');
  pool.close();

  return result;
}

async function deleteBook(isbn){
  const pool = await sql.connect(config);
  const result = await pool.request()
      .input('isbn', sql.VarChar(13), isbn)
      .query('EXEC DeleteBook @ISBN=@isbn');
  pool.close();

  return result;
}

async function getAllBooks(){
  const pool = await sql.connect(config);
  const result = await pool.request().query('EXEC GetAllBooks');
  pool.close();

  return result;
}

async function searchBooks(searchColumn, searchKey){
  const pool = await sql.connect(config);
  const result = await pool.request()
      .input('key', sql.VarChar(255), searchKey)
      .query(`EXEC SearchBook${searchColumn} @Key=@key`);
  pool.close();

  return result;
}

module.exports = {createBook, readBook, updateBook, deleteBook, getAllBooks, searchBooks}