function validateEmail(email){
    const regex = /^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/;
    if(regex.test(email)){
        return email;
    } else {
        throw new Error("Invalid email address");
    }
}

function validateISBN(isbn){
    const regex = /^\d{13}$/;
    isbn = isbn.replace('-', '');
    if(regex.test(isbn)){
        return isbn;
    } else {
        throw new Error("Invalid ISBN, valid ISBN consists of exactly 13 digits");
    }
}

module.exports = {validateEmail, validateISBN};