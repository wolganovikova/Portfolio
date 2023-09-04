1.Выведите общую сумму просмотров постов за каждый месяц 2008 года. Если данных за какой-либо 
месяц в базе нет, такой месяц можно пропустить. Результат отсортируйте по убыванию общего количества просмотров.

SELECT CAST(DATE_TRUNC('month', creation_date) As date) As month,
       SUM(views_count) As number_views
FROM  stackoverflow.posts
WHERE CAST(DATE_TRUNC('month', creation_date) As date) BETWEEN '2008-01-01' AND '2008-12-31'
GROUP BY month
ORDER BY number_views DESC;

2.Выведите имена самых активных пользователей, которые в первый месяц после регистрации
(включая день регистрации) дали больше 100 ответов. Вопросы, которые задавали пользователи, 
не учитывайте. Для каждого имени пользователя выведите количество уникальных значений user_id. 
Отсортируйте результат по полю с именами в лексикографическом порядке.

SELECT display_name,
       COUNT(DISTINCT (user_id))
FROM stackoverflow.users As u
JOIN stackoverflow.posts As p ON u.id = p.user_id
JOIN stackoverflow.post_types As pt ON pt.id = p.post_type_id
WHERE (DATE_TRUNC('day', p.creation_date) <= DATE_TRUNC('day', u.creation_date) + INTERVAL '1 month') AND type LIKE 'Answer'
GROUP BY display_name
HAVING COUNT(p.id)>100;

3.Выведите количество постов за 2008 год по месяцам. Отберите посты от пользователей, 
которые зарегистрировались в сентябре 2008 года и сделали хотя бы один пост в декабре того же года. 
Отсортируйте таблицу по значению месяца по убыванию.

WITH 
ds1 As (SELECT u.id
      FROM stackoverflow.posts As p
      JOIN stackoverflow.users As u ON p.user_id = u.id
      WHERE CAST(DATE_TRUNC('month', u.creation_date) AS date) BETWEEN '2008-09-01' AND '2008-09-30'   AND  CAST(DATE_TRUNC('month', p.creation_date) AS date) BETWEEN '2008-12-01' AND '2008-12-31' 
      GROUP BY u.id)
SELECT CAST(DATE_TRUNC('month', p.creation_date) AS date),
       COUNT(p.id)
FROM stackoverflow.posts As p
      JOIN stackoverflow.users As u ON p.user_id = u.id
WHERE  CAST(DATE_TRUNC('month', p.creation_date) AS date) BETWEEN '2008-01-01' AND '2008-12-31' AND p.user_id IN (SELECT * FROM ds1)
GROUP BY CAST(DATE_TRUNC('month', p.creation_date) AS date)
ORDER BY CAST(DATE_TRUNC('month', p.creation_date) AS date) DESC;

4.Используя данные о постах, выведите несколько полей:
идентификатор пользователя, который написал пост;
дата создания поста;
количество просмотров у текущего поста;
сумму просмотров постов автора с накоплением.
Данные в таблице должны быть отсортированы по возрастанию идентификаторов пользователей, 
а данные об одном и том же пользователе — по возрастанию даты создания поста.

SELECT user_id,
       creation_date,
       views_count,
       SUM(views_count) OVER (PARTITION BY user_id ORDER BY creation_date)
FROM stackoverflow.posts;

5.Сколько в среднем дней в период с 1 по 7 декабря 2008 года включительно пользователи 
взаимодействовали с платформой? Для каждого пользователя отберите дни, в которые он или 
она опубликовали хотя бы один пост. Нужно получить одно целое число — не забудьте округлить результат.

WITH 
ds As (SELECT p.user_id,
       COUNT(DISTINCT p.creation_date::date)
FROM stackoverflow.posts As p
WHERE p.creation_date::date  BETWEEN '2008-12-01' AND '2008-12-07'
GROUP BY p.user_id
HAVING COUNT(p.id)>=1)
SELECT ROUND(AVG(count))
FROM ds; 

6.На сколько процентов менялось количество постов ежемесячно с 1 сентября по 31 декабря 2008 года? Отобразите таблицу со следующими полями:
номер месяца;
количество постов за месяц;
процент, который показывает, насколько изменилось количество постов в текущем месяце по сравнению с предыдущим.
Если постов стало меньше, значение процента должно быть отрицательным, если больше — положительным. 
Округлите значение процента до двух знаков после запятой.
Напомним, что при делении одного целого числа на другое в PostgreSQL в результате получится целое число, 
округлённое до ближайшего целого вниз. Чтобы этого избежать, переведите делимое в тип numeric.

WITH
ds AS (SELECT EXTRACT(month from creation_date) AS num,
       COUNT(id) As count_id
       FROM stackoverflow.posts 
       WHERE creation_date::date BETWEEN '2008-09-01' AND '2008-12-31'
      GROUP BY 1)
SELECT  num,
       count_id,
       ROUND(((count_id::numeric/LAG(count_id) OVER (ORDER BY num))-1)*100,2)
FROM ds;

7.Выгрузите данные активности пользователя, который опубликовал больше всего постов за всё время. 
Выведите данные за октябрь 2008 года в таком виде:
номер недели;
дата и время последнего поста, опубликованного на этой неделе.

WITH
ds1 As(SELECT creation_date,
             EXTRACT(week FROM CAST(creation_date AS timestamp)) As week
FROM stackoverflow.posts
WHERE user_id = (SELECT user_id FROM
        (SELECT user_id,
               COUNT(user_id)
       FROM stackoverflow.posts
        GROUP BY user_id
        ORDER BY COUNT(user_id) DESC
        LIMIT 1) as t)
        AND CAST(DATE_TRUNC('month', creation_date) AS date) ='2008-10-01') 
SELECT DISTINCT week,
       LAST_VALUE(creation_date) OVER (PARTITION BY week ORDER BY creation_date ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) last_post
FROM ds1; 