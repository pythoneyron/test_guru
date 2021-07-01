document.addEventListener('turbolinks:load', function () {
    setProgress()

    let submit = document.getElementById('submit-form')

    if (submit) {
        submit.addEventListener('click', setProgress)
    }

})

function setProgress(event) {
    let current_count_question = document.querySelector('.count-questions').dataset.countQuestions - 1
    let all_count_questions = document.querySelector('.all-count-questions').dataset.allCountQuestions

    if (!current_count_question && !all_count_questions) {
        return
    }

    const part_percent = 100 / all_count_questions

    if (current_count_question <= all_count_questions) {

        let res_part_percent = part_percent * current_count_question


        let elem = document.getElementById("progress-bar");

        elem.style.width = res_part_percent + "%";
        elem.innerHTML = res_part_percent + "%";
    }
}
