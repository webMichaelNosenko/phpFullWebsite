const form  = document.getElementsByTagName('form')[0];

const event_name = document.getElementById('event_name');
const eventNameError = document.querySelector('span.error#eventNameError');
const date_time = document.getElementById('date_time');
const dateTimeError = document.querySelector('span.error#dateTimeError');
const city_name = document.getElementById('city_name');
const cityNameError = document.querySelector('span.error#cityNameError');
const theme = document.getElementById('theme');
const themeError = document.querySelector('span.error#themeError');

event_name.addEventListener('input', function (event) {
    if (event_name.validity.valid) {
        eventNameError.innerHTML = '';
        eventNameError.className = 'error';
    } else {
        showErrorInName();
    }
});

date_time.addEventListener('input', function (event) {
    if (date_time.validity.valid) {
        dateTimeError.innerHTML = '';
        dateTimeError.className = 'error';
    }
    else {
        showErrorIfEmpty(date_time, dateTimeError);
    }
});

city_name.addEventListener('input', function (event) {
    if (city_name.validity.valid) {
        cityNameError.innerHTML = '';
        cityNameError.className = 'error';
    }
    else {
        showErrorIfEmpty(city_name, cityNameError);
    }
});

theme.addEventListener('input', function (event) {
    if (theme.validity.valid) {
        themeError.innerHTML = '';
        themeError.className = 'error';
    }
    else {
        showErrorIfEmpty(theme, themeError);
    }
});

form.addEventListener('submit', function (event) {
    if(!event_name.validity.valid) {
        showErrorInEventName();
        event.preventDefault();
    }
    else if(!date_time.validity.valid) {
        showErrorIfEmpty(date_time, dateTimeError);
        event.preventDefault();
    }
    else if(!city_name.validity.valid) {
        showErrorIfEmpty(city_name, cityNameError);
        event.preventDefault();
    }
    else if(!theme.validity.valid) {
        showErrorIfEmpty(theme, themeError);
        event.preventDefault();
    }
});

function showErrorInEventName() {
    if (event_name.validity.tooLong) {
        eventNameError.textContent = `Название может быть максимально ${ event_name.minLength } 
                                      символов; вы ввели ${ event_name.value.length }.`;
    }
    eventNameError.className = 'error active';
}

function showErrorIfEmpty(field, errorSpan) {
    if(field.validity.valueMissing) {
        errorSpan.textContent = `Необходимо ввести значение в ${field.placeholder}.`;
        errorSpan.className = 'error active';
    }
}