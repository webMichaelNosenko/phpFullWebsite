const form  = document.getElementsByTagName('form')[0];

const name = document.getElementById('name');
const nameError = document.querySelector('span.error#nameError');
const birth_date = document.getElementById('birth_date');
const birthDateError = document.querySelector('span.error#birthDateError');
const work_time = document.getElementById('work_time');
const workTimeError = document.querySelector('span.error#workTimeError');
const position = document.getElementById('position');
const positionError = document.querySelector('span.error#positionError');
const payout = document.getElementById('payout');
const payoutError = document.querySelector('span.error#payoutError');

name.addEventListener('input', function (event) {
    if (name.validity.valid) {
        nameError.innerHTML = '';
        nameError.className = 'error';
    } else {
        showErrorInName();
    }
});

birth_date.addEventListener('input', function (event) {
    if (birth_date.validity.valid) {
        birthDateError.innerHTML = '';
        birthDateError.className = 'error';
    }
    else {
        showErrorIfEmpty(birth_date, birthDateError);
    }
});

work_time.addEventListener('input', function (event) {
    if (work_time.validity.valid) {
        workTimeError.innerHTML = '';
        workTimeError.className = 'error';
    }
    else {
        showErrorIfEmpty(work_time, workTimeError);
    }
});

position.addEventListener('input', function (event) {
    if (position.validity.valid) {
        positionError.innerHTML = '';
        positionError.className = 'error';
    }
    else {
         showErrorIfEmpty(position, positionError);
    }
});

payout.addEventListener('input', function (event) {
    if (payout.validity.valid) {
        payoutError.innerHTML = '';
        payoutError.className = 'error';
    }
    else {
        showErrorInPayout();
    }
});

form.addEventListener('submit', function (event) {
    if(!name.validity.valid) {
        showErrorInName();
        event.preventDefault();
    }
    else if(!birth_date.validity.valid) {
        showErrorIfEmpty(birth_date, birthDateError);
        event.preventDefault();
    }
    else if(!work_time.validity.valid) {
        showErrorIfEmpty(work_time, workTimeError);
        event.preventDefault();
    }
    else if(!position.validity.valid) {
        showErrorIfEmpty(position, positionError);
        event.preventDefault();
    }
    else if(!payout.validity.valid) {
        showErrorInPayout();
        event.preventDefault();
    }
});

function showErrorInName() {
    if (name.validity.tooLong) {
        nameError.textContent = `Имя может быть максимально ${ name.minLength } символов; вы ввели ${ name.value.length }.`;
    }
    nameError.className = 'error active';
}

function showErrorInPayout() {
    if(payout.validity.rangeOverflow) {
        payoutError.textContent = `Зарплата может быть максимально 100000000.`;
    }
    payoutError.className = 'error active';
}

function showErrorIfEmpty(field, errorSpan) {
    if(field.validity.valueMissing) {
        errorSpan.textContent = `Необходимо ввести значение в ${field.placeholder}.`;
        errorSpan.className = 'error active';
    }
}