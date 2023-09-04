1.Найдите количество вопросов, которые набрали больше 300 очков или как минимум 100 раз были добавлены в «Закладки».

SELECT COUNT(id)
FROM stackoverflow.posts
WHERE (score>300 OR favorites_count >=100) AND post_type_id = 1;

2.Сколько в среднем в день задавали вопросов с 1 по 18 ноября 2008 включительно? Результат округлите до целого числа.

WITH ps AS 
    (SELECT CAST(DATE_TRUNC('day', p.creation_date) As date) As date,
           COUNT(id)     
    FROM stackoverflow.posts As p
    WHERE post_type_id = 1
    GROUP BY date
    HAVING CAST(DATE_TRUNC('day', p.creation_date) As date) BETWEEN '2008-11-01' AND '2008-11-18')
SELECT ROUND(AVG(count)) 
FROM ps;

3.Сколько пользователей получили значки сразу в день регистрации? Выведите количество уникальных пользователей.

SELECT COUNT(DISTINCT(u.id))
FROM stackoverflow.users As u
JOIN stackoverflow.badges As b ON u.id = b.user_id
WHERE CAST(DATE_TRUNC('day', u.creation_date)AS date) = CAST(DATE_TRUNC('day', b.creation_date) As date);

4.Сколько уникальных постов пользователя с именем Joel Coehoorn получили хотя бы один голос?

SELECT COUNT(DISTINCT(p.id))
FROM stackoverflow.posts As p
JOIN stackoverflow.users As u ON p.user_id = u.id
JOIN stackoverflow.votes As v ON p.id = v.post_id
WHERE u.display_name LIKE 'Joel Coehoorn';

5.Выгрузите все поля таблицы vote_types. Добавьте к таблице поле rank, в которое войдут номера записей 
в обратном порядке. Таблица должна быть отсортирована по полю id.

SELECT *,
      RANK() OVER (ORDER BY id DESC)
FROM stackoverflow.vote_types
ORDER BY id;

6.Отберите 10 пользователей, которые поставили больше всего голосов типа Close. 
Отобразите таблицу из двух полей: идентификатором пользователя и количеством голосов. 
Отсортируйте данные сначала по убыванию количества голосов, потом по убыванию значения идентификатора пользователя.

SELECT v.user_id, 
       COUNT(v.id)
FROM stackoverflow.vote_types As vt
JOIN stackoverflow.votes As v ON vt.id = v.vote_type_id
JOIN stackoverflow.users As u ON v.user_id = u.id
WHERE name LIKE 'Close'
GROUP BY v.user_id
ORDER BY COUNT(v.id) DESC, v.user_id DESC
LIMIT 10;

7.Отберите 10 пользователей по количеству значков, полученных в период с 15 ноября по 15 декабря 2008 года включительно.
Отобразите несколько полей:
идентификатор пользователя;
число значков;
место в рейтинге — чем больше значков, тем выше рейтинг.
Пользователям, которые набрали одинаковое количество значков, присвойте одно и то же место в рейтинге.
Отсортируйте записи по количеству значков по убыванию, а затем по возрастанию значения идентификатора пользователя.

SELECT user_id,
       COUNT(id),
       DENSE_RANK() OVER (ORDER BY COUNT(id) DESC)

FROM stackoverflow.badges
WHERE CAST(creation_date As date) BETWEEN '2008-11-15' AND '2008-12-15'
GROUP BY user_id
ORDER BY COUNT(id) DESC, user_id
LIMIT 10;

8.Сколько в среднем очков получает пост каждого пользователя?
Сформируйте таблицу из следующих полей:
заголовок поста;
идентификатор пользователя;
число очков поста;
среднее число очков пользователя за пост, округлённое до целого числа.
Не учитывайте посты без заголовка, а также те, что набрали ноль очков.

SElECT title,
       user_id,
       score,
       ROUND(AVG(score) OVER (PARTITION BY user_id))
FROM stackoverflow.posts
WHERE score != 0 AND title IS  NOT NULL;

9.Отобразите заголовки постов, которые были написаны пользователями, получившими 
более 1000 значков. Посты без заголовков не должны попасть в список.

SELECT title
FROM stackoverflow.posts As p
WHERE user_id IN(SELECT user_id 
                 FROM stackoverflow.badges As b 
                 GROUP BY user_id
                 HAVING COUNT(id)>1000)
                 GROUP BY title
                 HAVING title IS NOT NULL;

10.Напишите запрос, который выгрузит данные о пользователях из США (англ. United States). 
Разделите пользователей на три группы в зависимости от количества просмотров их профилей:
пользователям с числом просмотров больше либо равным 350 присвойте группу 1;
пользователям с числом просмотров меньше 350, но больше либо равно 100 — группу 2;
пользователям с числом просмотров меньше 100 — группу 3.
Отобразите в итоговой таблице идентификатор пользователя, количество просмотров профиля и группу. 
Пользователи с нулевым количеством просмотров не должны войти в итоговую таблицу.

SELECT id,
       views,
CASE
    WHEN  views >= 350 THEN 1
    WHEN  views < 350  AND views >= 100 THEN 2
    WHEN  views < 100 THEN 3
END    
FROM stackoverflow.users
WHERE location LIKE '%United States%' AND views <> 0;

11.Дополните предыдущий запрос. Отобразите лидеров каждой группы — пользователей, которые набрали
максимальное число просмотров в своей группе. Выведите поля с идентификатором пользователя, группой 
и количеством просмотров. Отсортируйте таблицу по убыванию просмотров, а затем по возрастанию значения идентификатора.

WITH 
gf1 As 
   (SELECT id,
           views,
    CASE
         WHEN  views >= 350 THEN 1
         WHEN  views < 350  AND views >= 100 THEN 2
         WHEN  views < 100 THEN 3
    END  AS rang  
    FROM stackoverflow.users
    WHERE location LIKE '%United States%' AND views <> 0),
gf2 As 
   (SELECT *,
           MAX(views) OVER (PARTITION BY rang) AS top
    FROM gf1 
    ORDER BY views)
SELECT id,
       rang,
       views
FROM gf2 
WHERE views = top
ORDER BY views DESC, id;

12.Посчитайте ежедневный прирост новых пользователей в ноябре 2008 года. Сформируйте таблицу с полями:
номер дня;
число пользователей, зарегистрированных в этот день;
сумму пользователей с накоплением.

WITH
fg As 
    (SELECT CAST(DATE_TRUNC('days', creation_date)As date) As dt,
       COUNT(id) As val
    FROM stackoverflow.users
    GROUP BY CAST(DATE_TRUNC('days', creation_date)As date)
    ORDER BY CAST(DATE_TRUNC('days', creation_date)As date))
SELECT RANK() OVER(ORDER BY dt),
       val,
       SUM(val) OVER (ORDER BY dt)
FROM fg   
WHERE CAST(DATE_TRUNC('days', dt)As date) BETWEEN '2008-11-01' AND '2008-11-30';

13.Для каждого пользователя, который написал хотя бы один пост, найдите интервал между регистрацией 
и временем создания первого поста. Отобразите:
идентификатор пользователя;
разницу во времени между регистрацией и первым постом.

WITH 

ds As (SELECT p.user_id,
      MIN(p.creation_date) OVER (PARTITION BY user_id ORDER BY u.creation_date) As min_date,
      u.creation_date As date
      FROM stackoverflow.posts As p
      JOIN stackoverflow.users As u ON p.user_id = u.id)
SELECT DISTINCT user_id,
                  min_date - date
FROM ds;   