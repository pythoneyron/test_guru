document.addEventListener('turbolinks:load', function () {
    let passwordInput = document.querySelectorAll('.password')

    document.querySelectorAll('.password').forEach(item => {
        item.addEventListener('input', event => {
            let password = document.querySelector('#user_password').value
            let password_confirmation = document.querySelector('#user_password_confirmation').value

            if (password != password_confirmation) {
                passwordInput.forEach(item => {
                    item.classList.add('invalid')
                    item.classList.remove('valid')
                })
            } else if (password.length == 0 && password_confirmation.length == 0) {
                passwordInput.forEach(item => {
                    item.classList.remove('valid')
                    item.classList.remove('invalid')
                })
            } else {
                passwordInput.forEach(item => {
                    item.classList.add('valid')
                    item.classList.remove('invalid')
                })
            }
        })
    })
})
