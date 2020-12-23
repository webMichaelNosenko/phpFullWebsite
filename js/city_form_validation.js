const form  = document.getElementsByTagName('form')[0];

const city_name = document.getElementById('city_name');
const cityNameError = document.querySelector('span.error#cityNameError');

city_name.addEventListener('input', function (event) {
    if (city_name.validity.valid) {
        cityNameError.innerHTML = '';
        cityNameError.className = 'error';
    } else {
        showErrorInName();
    }
});

form.addEventListener('submit', function (event) {
    if (!city_name.validity.valid) {
        showErrorInName();
        event.preventDefault();
    }
})

function showErrorInName() {
    if (city_name.validity.tooLong) {
        cityNameError.textContent = `Имя может быть максимально ${ city_name.minLength } символов; вы ввели ${ city_name.value.length }.`;
    }
    cityNameError.className = 'error active';
}

function showErrorIfEmpty(field, errorSpan) {
    if(field.validity.valueMissing) {
        errorSpan.textContent = `Необходимо ввести значение в ${field.placeholder}.`;
        errorSpan.className = 'error active';
    }
}