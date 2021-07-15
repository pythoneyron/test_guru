# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

kratos = User.create({ email: 'kratos@mail.com', first_name: 'Kratos', last_name: '', password: '123qwe123' })
smith = User.create({ email: 'smith@mail.com', first_name: 'John', last_name: 'Smith', password: '123qwe123' })

users = User.create(
  [{ email: 'Vasya@mail.com', first_name: 'Вася', last_name: 'Пупкин', password: '123qwe123' },
   { email: 'Elon@mail.com', first_name: 'Илон', last_name: 'Маск', password: '123qwe123' },
   { email: 'Matz@mail.com', first_name: 'Юкихиро', last_name: 'Мацумото', password: '123qwe123' }]
)

categories = Category.create([{ title: 'Frontend' }, { title: 'Backend' },
                              { title: 'Machine Language' }, { title: 'Test' }])

tests = Test.create(
  [{ title: 'Python', level: 1, category_id: categories[1].id, author_id: kratos.id },
   { title: 'JavaScript', level: 2, category_id: categories[0].id, author_id: smith.id },
   { title: 'Ruby', level: 2, category_id: categories[1].id, author_id: smith.id },
   { title: 'Java', level: 3, category_id: categories[1].id, author_id: kratos.id },
   { title: 'Python3', level: 2, category_id: categories[2].id, author_id: smith.id },
   { title: 'C++', level: 3, category_id: categories[2].id, author_id: smith.id },
   { title: 'Java', level: 3, category_id: categories[2].id, author_id: kratos.id },
   { title: 'Creator TEST', level: 4, category_id: categories[3].id, author_id: smith.id }]
)

questions = Question.create(
  [{ body: 'Какой ЯП написал Юкихиро Мацумото', test_id: tests[2].id },
   { body: 'Какой ЯП написал Гвидо ван Россум', test_id: tests[0].id },
   { body: 'Какой ЯП разработала компания Netscape', test_id: tests[1].id },
   { body: 'В какой ЯП используются пробелы для определения блока кода', test_id: tests[0].id },
   { body: 'Какой самый популярный ЯП для машинного обучения', test_id: tests[4].id },
   { body: 'В каком году был написан язык Ruby', test_id: tests[2].id },
   { body: 'В каком году был написан язык Java', test_id: tests[3].id }]
)

Answer.create(
  [{ text: 'Ruby', question_id: questions[0].id, correct: true },
   { text: 'JavaScript', question_id: questions[0].id, correct: false },

   { text: 'Python', question_id: questions[1].id, correct: true },
   { text: 'C++', question_id: questions[1].id, correct: false },

   { text: 'JavaScript', question_id: questions[2].id, correct: true },
   { text: 'Ruby', question_id: questions[2].id, correct: false },

   { text: 'Python', question_id: questions[3].id, correct: true },
   { text: 'Java', question_id: questions[3].id, correct: false },

   { text: 'Python, Java, C++', question_id: questions[4].id, correct: true },
   { text: 'Ruby', question_id: questions[4].id, correct: false },

   { text: '1995', question_id: questions[5].id, correct: true },
   { text: '1993', question_id: questions[5].id, correct: false },

   { text: '1995', question_id: questions[6].id, correct: true },
   { text: '1992', question_id: questions[6].id, correct: false },
   { text: '1996', question_id: questions[6].id, correct: false }]
)

TestPassage.create([
    { user_id: users[0].id, test_id: tests[0].id },
    { user_id: users[0].id, test_id: tests[1].id },
    { user_id: users[0].id, test_id: tests[3].id },
    { user_id: users[0].id, test_id: tests[2].id },
    { user_id: users[0].id, test_id: tests[4].id },
    { user_id: users[1].id, test_id: tests[4].id },
    { user_id: users[1].id, test_id: tests[3].id },
    { user_id: users[1].id, test_id: tests[5].id },
    { user_id: users[2].id, test_id: tests[4].id },
    { user_id: users[2].id, test_id: tests[3].id },
    { user_id: users[2].id, test_id: tests[2].id }]
)

Badge.create([
               {title: 'Успешно выполнил все тесты Backend', url_image: 'https://image.flaticon.com/icons/png/128/1579/1579506.png', rule: 'success_backend'},
               {title: 'Успешно выполнил тест с первого раза', url_image: 'https://image.flaticon.com/icons/png/128/1579/1579498.png', rule: 'success_on_first_try'},
               {title: 'Успешно выполнил тесты 3 уровня', url_image: 'https://image.flaticon.com/icons/png/128/1579/1579504.png', rule: 'success_certain_level'}
             ])
