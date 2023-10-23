const express = require('express');
const router = express.Router();
const repo = require('../Repository/borrower_repository');
const utils = require('./utils');

router.get('/all', async (_, res) => {
    console.log('get all borrowers');
    try{
        const data = await repo.getAllBorrowers();
        res.send(data.recordset);
    } catch(err) {
        res.status(500);
        res.send(utils.refineError(err.message));
    }
});

router.post('/', async (req, res) => {
    console.log(`register new borrower ${JSON.stringify(req.body)}`);
    try{
        const email = utils.validateEmail(req.body.email);
        await repo.createBorrower(email, req.body.name);
        res.sendStatus(201);
    } catch(err){
        res.status(500);
        res.send(utils.refineError(err.message));
    }
});

router.get('/:email', async (req, res) => {
    console.log(`get borrower ${req.params.email} info`);
    try{
        const data = await repo.readBorrower(req.params.email);
        res.send(data.recordset[0]);
    } catch(err){
        res.status(500);
        res.send(utils.refineError(err.message));
    }
});

router.patch('/', async (req, res) => {
    console.log(`updated borrower ${JSON.stringify(req.body)}`);
    try{
        await repo.updateBorrower(req.body.email, req.body.name);
        res.status(200);
        res.send('Updated');
    } catch(err){
        res.status(500);
        res.send(utils.refineError(err.message));
    }
});

router.delete('/:email', async (req, res) => {
    console.log(`delete borrower ${req.params.email}`);
    try{
        await repo.deleteBorrower(req.params.email);
        res.status(200);
        res.send('Deleted');
    } catch(err){
        res.status(500);
        res.send(utils.refineError(err.message));
    }
});

module.exports = router;