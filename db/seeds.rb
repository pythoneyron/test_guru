# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

creator = User.create({ first_name: 'Creator', last_name: 'Creator', is_author: true })

users = User.create(
  [{ first_name: 'Вася', last_name: 'Пупкин' },
   { first_name: 'John', last_name: 'Smith' },
   { first_name: 'Юкихиро', last_name: 'Мацумото' }])

categories = Category.create([{ title: 'Frontend' }, { title: 'Backend' },
                              { title: 'Machine Language' }, { title: 'Test' }])

tests = Test.create(
  [{ title: 'Python', level: 1, category_id: categories[1].id },
   { title: 'JavaScript', level: 2, category_id: categories[0].id },
   { title: 'Ruby', level: 2, category_id: categories[1].id },
   { title: 'Java', level: 3, category_id: categories[1].id },
   { title: 'Python3', level: 2, category_id: categories[2].id },
   { title: 'C++', level: 3, category_id: categories[2].id },
   { title: 'Java', level: 3, category_id: categories[2].id },
   { title: 'Creator TEST', level: 4, category_id: categories[3].id, author_id: creator.id}])

questions = Question.create(
  [{ body: 'Какой ЯП написал Юкихиро Мацумото', test_id: tests[2].id },
   { body: 'Какой ЯП написал Гвидо ван Россум', test_id: tests[0].id },
   { body: 'Какой ЯП разработала компания Netscape', test_id: tests[1].id },
   { body: 'В какой ЯП используются пробелы для определения блока кода', test_id: tests[0].id },
   { body: 'Какой самый популярный ЯП для машинного обучения', test_id: tests[4].id }])

Answer.create(
  [{ text: 'Правильный ответ: Ruby', question_id: questions[0].id },
   { text: 'Правильный ответ: Python', question_id: questions[1].id },
   { text: 'Правильный ответ: JavaScript', question_id: questions[2].id },
   { text: 'Правильный ответ: Python', question_id: questions[3].id },
   { text: 'Правильный ответ: Python, Java, C++', question_id: questions[4].id }])

UsersTest.create([
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
    { user_id: users[2].id, test_id: tests[2].id }])
