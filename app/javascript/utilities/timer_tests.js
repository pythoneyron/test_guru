document.addEventListener('turbolinks:load', function () {
    let timerData = document.getElementById("timer")
    if (timerData) {
        let urlTimer = timerData.dataset.url_timer
        let urlResult = timerData.dataset.result
        let timer = timerData.dataset.timer

        if (timer){
            startTimer(timer, urlTimer, urlResult);
        }
    }
})

function startTimer(time, urlTimer, urlResult) {
    let timePassed = 0;
    let timeLeft = time;

    const timerInterval = setInterval(() => {
        urlRequest(urlTimer).then(json => {
            if (!json['time_left']) {
                clearInterval(timerInterval);
                alert('Время вышло! Тест завершен!')
                location.href = urlResult
            }
        })

        // Количество времени, которое прошло, увеличивается на 1
        timePassed = timePassed += 1;
        timeLeft = time - timePassed;

        // Обновление оставшегося времени
        document.getElementById("timer").innerHTML = formatTime(timeLeft);
    }, 1000);
}

function formatTime(time) {
    // Наибольшее целое число меньше или равно результату деления времени на 60.
    let minutes = Math.floor(time / 60);
    let hours = Math.floor(minutes / 60);

    // Секунды, минуты – это остаток деления времени на 60 (оператор модуля)
    let seconds = time % 60;
    minutes = minutes % 60

    // Если значение секунд меньше 10, тогда отображаем его с 0 впереди
    if (seconds < 10) {
        seconds = `0${seconds}`;
    }

    // Если значение минут меньше 10, тогда отображаем его с 0 впереди
    if (minutes < 10) {
        minutes = `0${minutes}`;
    }

    // Если значение часов меньше 10, тогда отображаем его с 0 впереди
    if (hours < 10) {
        hours = `0${hours}`;
    }

    // Вывод в формате HH:MM:SS
    return `${hours}:${minutes}:${seconds}`;
}

async function urlRequest(url) {
    let response = await fetch(url);

    if (response.ok) {
        return response.json();
    } else {
        alert("Ошибка HTTP: " + response.status);
    }
}