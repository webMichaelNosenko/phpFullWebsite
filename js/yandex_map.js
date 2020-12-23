ymaps.ready(init);

function init() {
    var myMap = new ymaps.Map('map', {
        center: [55.753994, 37.622093],
        zoom: 12
    }, {
        searchControlProvider: 'yandex#search'
    });
    cities = document.getElementsByClassName("cityName");
    for (i = 0; i < cities.length; i++) {
        ymaps.geocode(cities[i].innerText, {
            /**
             * Опции запроса
             * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/geocode.xml
             */
            kind: 'locality',
            results: 1
        }).then(function (res) {
            // Задаем изображение для иконок меток.
            res.geoObjects.options.set('preset', 'islands#redCircleIcon');
            res.geoObjects.events
                // При наведении на метку показываем хинт с названием станции метро.
                .add('mouseenter', function (event) {
                    var geoObject = event.get('target');
                    myMap.hint.open(geoObject.geometry.getCoordinates(), geoObject.getPremise());
                })
                // Скрываем хинт при выходе курсора за пределы метки.
                .add('mouseleave', function (event) {
                    myMap.hint.close(true);
                });
            // Добавляем коллекцию найденных геообъектов на карту.
            myMap.geoObjects.add(res.geoObjects);
        });
    }
    myMap.setZoom(4);

}