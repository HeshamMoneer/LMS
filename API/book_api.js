const express = require('express');
const router = express.Router();
const repo = require('../Repository/book_repository');
const validateISBN = require('./utils').validateISBN;

router.get('/all', async (_, res) => {
    console.log('get all books');
    try {
        const data = await repo.getAllBooks();
        res.send(data.recordset);
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

router.post('/', async (req, res) => {
    console.log(`add new book ${JSON.stringify(req.body)}`);
    try {
        const isbn = validateISBN(req.body.isbn);
        await repo.createBook(isbn, req.body.title, req.body.author, req.body.quantity, req.body.shelfNumber);
        res.sendStatus(201);
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

router.get('/:isbn', async (req, res) => {
    console.log(`get book ${req.params.isbn} info`);
    try {
        const data = await repo.readBook(req.params.isbn);
        res.send(data.recordset);
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

router.patch('/', async (req, res) => {
    console.log(`update book ${JSON.stringify(req.body)}`);
    try {
        await repo.updateBook(req.body.isbn, req.body.title, req.body.author, req.body.quantity, req.body.shelfNumber);
        res.status(200);
        res.send('Updated');
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

router.delete('/:isbn', async (req, res) => {
    console.log(`delete book ${req.params.isbn}`);
    try {
        await repo.deleteBook(req.params.isbn);
        res.status(200);
        res.send('Deleted');
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

router.get('/search/ISBN/:key', async (req, res) => {
    console.log(`search books by ISBN with search key ${req.params.key}`);
    try {
        const data = await repo.searchBooks('ISBN', req.params.key);
        res.send(data.recordset);
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

router.get('/search/Author/:key', async (req, res) => {
    console.log(`search books by Author with search key ${req.params.key}`);
    try {
        const data = await repo.searchBooks('Author', req.params.key);
        res.send(data.recordset);
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

router.get('/search/Title/:key', async (req, res) => {
    console.log(`search books by Title with search key ${req.params.key}`);
    try {
        const data = await repo.searchBooks('Title', req.params.key);
        res.send(data.recordset);
    } catch(err) {
        res.status(500);
        res.send(err.message);
    }
});

module.exports = router;