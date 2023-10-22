const express = require('express');
const swaggerUi = require('swagger-ui-express');
const yml = require('yamljs');
const bodyParser = require('body-parser');
const app = express();
const port = process.env.BACKEND_PORT;

app.use(bodyParser.json());

const swaggerYML = yml.load('./swagger.yml');
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerYML));


const bookRoutes = require('./API/book_api');
const borrowRoutes = require('./API/borrow_api');
const borrowerRoutes = require('./API/borrower_api');

app.use('/book', bookRoutes);
app.use('/borrow', borrowRoutes);
app.use('/borrower', borrowerRoutes);

app.listen(port, () => {
    console.log(`Server is listening at http://localhost:${port}`);
});