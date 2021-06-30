document.addEventListener('turbolinks:load', function () {
    let passwordInputAll = document.querySelectorAll('.password')

    passwordInputAll.forEach(item => {
        item.addEventListener('input', event => {
            let password = document.querySelector('#user_password').value
            let password_confirmation = document.querySelector('#user_password_confirmation').value

            if (password.length == 0 && password_confirmation.length == 0) {
                return passwordInputAll.forEach(item => {
                    item.classList.remove('valid')
                    item.classList.remove('invalid')
                })
            }

            if (password != password_confirmation) {
                return passwordInputAll.forEach(item => {
                    item.classList.add('invalid')
                    item.classList.remove('valid')
                })
            } else {
                passwordInputAll.forEach(item => {
                    item.classList.add('valid')
                    item.classList.remove('invalid')
                })
            }
        })
    })
})
