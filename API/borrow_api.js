const express = require('express');
const router = express.Router();
const repo = require('../Repository/borrow_repository');

router.post('/borrow', async (req, res) => {
    console.log(`borrow book ${JSON.stringify(req.body)}`);
    try{
        if(req.body.quantity <= 0) throw new Error('Borrowed quantity has to be > 0');

        await repo.borrowBook(req.body.isbn, req.body.email, req.body.quantity, req.body.dueDate);
        res.status(200);
        res.send('Borrowed');
    } catch(err){
        res.status(500);
        res.send(err.message);
    }
});

router.post('/return', async (req, res) => {
    console.log(`return book ${JSON.stringify(req.body)}`);
    try{
        await repo.returnBook(req.body.isbn, req.body.email);
        res.status(200);
        res.send('Returned');
    } catch(err){
        res.status(500);
        res.send(err.message);
    }
});

router.get('/mybooks/:email', async (req, res) => {
    console.log(`get my books ${req.params.email}`);
    try{
        const data = await repo.getMyBooks(req.params.email);
        res.send(data.recordset);
    } catch(err){
        res.status(500);
        res.send(err.message);
    }
});

router.get('/overdue', async (_, res) => {
    console.log(`get overdue borrows`);
    try{
        const data = await repo.getOverdueBorrows();
        res.send(data.recordset);
    } catch(err){
        res.status(500);
        res.send(err.message);
    }
});

module.exports = router;