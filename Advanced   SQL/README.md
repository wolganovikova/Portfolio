## Продвинутый SQL. Анализ сервиса постов базы данных StackOverflow.

[sql1](https://github.com/wolganovikova/Portfolio/blob/master/Advanced%20%20%20SQL/Advanced%20%20SQL(1).sql)
[sql2](https://github.com/wolganovikova/Portfolio/blob/master/Advanced%20%20%20SQL/Advanced%20SQL(2).sql)

Анализ проводился  с помощью запросов разной сложности к базе данных StackOverflow — сервиса вопросов и ответов о программировании. В данной версии базы хранятся данные о постах за 2008 год, но в таблицах есть информация и о более поздних оценках, которые эти посты получили. Анализ рынка инвестиций проводился с помощью запросов разной сложности к базе данных, которая хранит информацию о венчурных фондах и инвестициях в компании-стартапы.

ER-диаграмму базы:

[png](https://github.com/wolganovikova/Portfolio/blob/master/Advanced%20%20%20SQL/Image%20Advanced%20%20.png)


* badges (хранит информацию о значках, которые присуждаются за разные достижения),
* post_types (содержит информацию о типе постов),
* posts (содержит информацию о постах),
* users (содержит информацию о пользователях),
* vote_types (содержит информацию о метках, которые пользователи ставят посту),
* votes (cодержит информацию о голосах за посты).

