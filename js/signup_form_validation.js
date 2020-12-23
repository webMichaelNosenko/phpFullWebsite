const form  = document.getElementsByTagName('form')[0];

const admin_name = document.getElementById('admin_name');
const adminNameError = document.querySelector('span.error#adminNameError');
const party_name = document.getElementById('party_name');
const partyNameError = document.querySelector('span.error#partyNameError');
const email = document.getElementById('email');
const emailError = document.querySelector('span.error#emailError');
const password = document.getElementById('password');
const passwordError = document.querySelector('span.error#passwordError');

admin_name.addEventListener('input', function (event) {
    if (admin_name.validity.valid) {
        adminNameError.innerHTML = '';
        adminNameError.className = 'error';
    } else {
        showError(admin_name, adminNameError);
    }
});

party_name.addEventListener('input', function (event) {
    if (party_name.validity.valid) {
        partyNameError.innerHTML = '';
        partyNameError.className = 'error';
    } else {
        showError(party_name, partyNameError);
    }
});

email.addEventListener('input', function (event) {
    if (email.validity.valid) {
        emailError.innerHTML = '';
        emailError.className = 'error';
    } else {
        showError(email, emailError);
    }
});

password.addEventListener('input', function (event) {
    if (password.validity.valid) {
        passwordError.innerHTML = '';
        passwordError.className = 'error';
    } else {
        showError(password, passwordError);
    }
});

form.addEventListener('submit', function (event) {
    if(!admin_name.validity.valid) {
        showError(admin_name, adminNameError);
        event.preventDefault();
    }
    else if(!party_name.validity.valid) {
        showError(party_name, partyNameError);
        event.preventDefault();
    }
    else if(!email.validity.valid) {
        showError(email, emailError);
        event.preventDefault();
    }
    else if(!password.validity.valid) {
        showError(password, passwordError);
        event.preventDefault();
    }
})

function showError(field, errorSpan) {
    if (field.validity.tooLong) {
        errorSpan.textContent = `Имя может быть максимально ${ field.maxLength } символов; вы ввели ${ field.value.length }.`;
    }
    else if(field.validity.tooShort) {
        errorSpan.textContent = `Имя может быть минимально ${ field.minLength } символов; вы ввели ${ field.value.length }.`;
    }
    else if(field.validity.valueMissing) {
        errorSpan.textContent = `Необходимо ввести значение в ${field.placeholder}.`;
    }
    errorSpan.className = 'error active';
}

