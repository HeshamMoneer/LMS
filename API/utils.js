function validateEmail(email){
    if(!email) throw new Error("Email should have value");

    const regex = /^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/;
    if(regex.test(email)){
        return email;
    } else {
        throw new Error("Invalid email address");
    }
}

function validateISBN(isbn){
    if(!isbn) throw new Error("ISBN should have value");

    const regex = /^\d{13}$/;
    isbn = isbn.replace('-', '');
    if(regex.test(isbn)){
        return isbn;
    } else {
        throw new Error("Invalid ISBN, valid ISBN consists of exactly 13 digits");
    }
}

function isString(msg){
    return (typeof msg === 'string' || msg instanceof String);
}

function refineError(msg){
    if(isString(msg) && msg.includes('CHECK constraint')){
        if(msg.includes('CK_Book_Quantity')){
            return `Quantity should be >= 0`;
        } else if(msg.includes('CK_Borrow_Quantity')){
            return `Quantity should be > 0`;
        } else if(msg.includes('CK_Borrow_Dates')){
            return `Due date should be >= borrow date`
        }
    }
    if(isString(msg) && msg.includes('Cannot insert the value NULL into column')){
        const column = msg.split(',')[0].split("'")[1].replace("'", '');
        return `Column ${column} cannot be null`;
    }
    if(isString(msg) && msg.includes('Violation of UNIQUE KEY constraint')){
        const val = msg.split('(')[1].replace(')', '').replace('.', '');
        return `Value ${val} is duplicated`;
    }

    return msg;
}

module.exports = {validateEmail, validateISBN, refineError};