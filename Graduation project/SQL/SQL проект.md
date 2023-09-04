# Aнализ базы данных приложения для чтения книг по подписке.

Цель исследования: Анализ базы данных крупного сервиса, которая поможет сформулировать ценностное предложение для нового продукта.В ней — информация о книгах, издательствах, авторах, а также пользовательские обзоры книг.

Коронавирус застал мир врасплох, изменив привычный порядок вещей. В свободное время жители городов больше не выходят на улицу, не посещают кафе и торговые центры. Зато стало больше времени для книг. Это заметили стартаперы — и бросились создавать приложения для тех, кто любит читать.
Ваша компания решила быть на волне и купила крупный сервис для чтения книг по подписке. Ваша первая задача как аналитика — проанализировать базу данных.

# Описание данных

Таблица **books** - cодержит данные о книгах:

- book_id — идентификатор книги;
- author_id — идентификатор автора;
- title — название книги;
- num_pages — количество страниц;
- publication_date — дата публикации книги;
- publisher_id — идентификатор издателя

Таблица **authors** -cодержит данные об авторах:
- author_id — идентификатор автора;
- author — имя автора.

Таблица **publishers** - cодержит данные об издательствах:
- publisher_id — идентификатор издательства;
- publisher — название издательства;

Таблица **ratings** - cодержит данные о пользовательских оценках книг:
- rating_id — идентификатор оценки;
- book_id — идентификатор книги;
- username — имя пользователя, оставившего оценку;
- rating — оценка книги.

Таблица reviews - cодержит данные о пользовательских обзорах:
- review_id — идентификатор обзора;
- book_id — идентификатор книги;
- username — имя автора обзора;
- text — текст обзора.


# Схема данных

"![%D0%91%D0%B0%D0%B7%D0%B0%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85.png](attachment:%D0%91%D0%B0%D0%B7%D0%B0%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85.png)"

# Задания

- Посчитайте, сколько книг вышло после 1 января 2000 года;

- Для каждой книги посчитайте количество обзоров и среднюю оценку;

- Определите издательство, которое выпустило наибольшее число книг толще 50 страниц — так вы исключите из анализа брошюры;

- Определите автора с самой высокой средней оценкой книг — учитывайте только книги с 50 и более оценками;

- Посчитайте среднее количество обзоров от пользователей, которые поставили больше 48 оценок.



```python
# импортируем библиотеки
import pandas as pd
from sqlalchemy import text, create_engine
```


```python
# устанавливаем параметры
db_config = {'user': 'praktikum_student', # имя пользователя
'pwd': 'Sdf4$2;d-d30pp', # пароль
'host': 'rc1b-wcoijxj3yxfsf3fs.mdb.yandexcloud.net',
'port': 6432, # порт подключения
'db': 'data-analyst-final-project-db'} # название базы данных
connection_string = 'postgresql://{user}:{pwd}@{host}:{port}/{db}'.format(**db_config)

# сохраняем коннектор

engine = create_engine(connection_string, connect_args={'sslmode':'require'})

# ознакомимся с данными
for table in ['books', 'authors', 'publishers', 'ratings', 'reviews']:
    query = ''' SELECT * FROM {}; 
    '''.format(table) 

    request = pd.io.sql.read_sql(query, con = engine) 
    display(request.head())
    print(request.info())
    print(f'Таблица - "{table}"') 
```


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>book_id</th>
      <th>author_id</th>
      <th>title</th>
      <th>num_pages</th>
      <th>publication_date</th>
      <th>publisher_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>546</td>
      <td>'Salem's Lot</td>
      <td>594</td>
      <td>2005-11-01</td>
      <td>93</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>465</td>
      <td>1 000 Places to See Before You Die</td>
      <td>992</td>
      <td>2003-05-22</td>
      <td>336</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>407</td>
      <td>13 Little Blue Envelopes (Little Blue Envelope...</td>
      <td>322</td>
      <td>2010-12-21</td>
      <td>135</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>82</td>
      <td>1491: New Revelations of the Americas Before C...</td>
      <td>541</td>
      <td>2006-10-10</td>
      <td>309</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>125</td>
      <td>1776</td>
      <td>386</td>
      <td>2006-07-04</td>
      <td>268</td>
    </tr>
  </tbody>
</table>
</div>


    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 1000 entries, 0 to 999
    Data columns (total 6 columns):
     #   Column            Non-Null Count  Dtype 
    ---  ------            --------------  ----- 
     0   book_id           1000 non-null   int64 
     1   author_id         1000 non-null   int64 
     2   title             1000 non-null   object
     3   num_pages         1000 non-null   int64 
     4   publication_date  1000 non-null   object
     5   publisher_id      1000 non-null   int64 
    dtypes: int64(4), object(2)
    memory usage: 47.0+ KB
    None
    Таблица - "books"
    


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>author_id</th>
      <th>author</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>A.S. Byatt</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Aesop/Laura Harris/Laura Gibbs</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Agatha Christie</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Alan Brennert</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Alan Moore/David   Lloyd</td>
    </tr>
  </tbody>
</table>
</div>


    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 636 entries, 0 to 635
    Data columns (total 2 columns):
     #   Column     Non-Null Count  Dtype 
    ---  ------     --------------  ----- 
     0   author_id  636 non-null    int64 
     1   author     636 non-null    object
    dtypes: int64(1), object(1)
    memory usage: 10.1+ KB
    None
    Таблица - "authors"
    


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>publisher_id</th>
      <th>publisher</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Ace</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Ace Book</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Ace Books</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Ace Hardcover</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Addison Wesley Publishing Company</td>
    </tr>
  </tbody>
</table>
</div>


    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 340 entries, 0 to 339
    Data columns (total 2 columns):
     #   Column        Non-Null Count  Dtype 
    ---  ------        --------------  ----- 
     0   publisher_id  340 non-null    int64 
     1   publisher     340 non-null    object
    dtypes: int64(1), object(1)
    memory usage: 5.4+ KB
    None
    Таблица - "publishers"
    


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rating_id</th>
      <th>book_id</th>
      <th>username</th>
      <th>rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>ryanfranco</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>1</td>
      <td>grantpatricia</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>1</td>
      <td>brandtandrea</td>
      <td>5</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>2</td>
      <td>lorichen</td>
      <td>3</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>2</td>
      <td>mariokeller</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>


    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 6456 entries, 0 to 6455
    Data columns (total 4 columns):
     #   Column     Non-Null Count  Dtype 
    ---  ------     --------------  ----- 
     0   rating_id  6456 non-null   int64 
     1   book_id    6456 non-null   int64 
     2   username   6456 non-null   object
     3   rating     6456 non-null   int64 
    dtypes: int64(3), object(1)
    memory usage: 201.9+ KB
    None
    Таблица - "ratings"
    


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>review_id</th>
      <th>book_id</th>
      <th>username</th>
      <th>text</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>brandtandrea</td>
      <td>Mention society tell send professor analysis. ...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>1</td>
      <td>ryanfranco</td>
      <td>Foot glass pretty audience hit themselves. Amo...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>2</td>
      <td>lorichen</td>
      <td>Listen treat keep worry. Miss husband tax but ...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>3</td>
      <td>johnsonamanda</td>
      <td>Finally month interesting blue could nature cu...</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>3</td>
      <td>scotttamara</td>
      <td>Nation purpose heavy give wait song will. List...</td>
    </tr>
  </tbody>
</table>
</div>


    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 2793 entries, 0 to 2792
    Data columns (total 4 columns):
     #   Column     Non-Null Count  Dtype 
    ---  ------     --------------  ----- 
     0   review_id  2793 non-null   int64 
     1   book_id    2793 non-null   int64 
     2   username   2793 non-null   object
     3   text       2793 non-null   object
    dtypes: int64(2), object(2)
    memory usage: 87.4+ KB
    None
    Таблица - "reviews"
    

Посчитать, сколько книг вышло после 1 января 2000 года


```python
query = '''

SELECT COUNT(book_id)
FROM books
WHERE publication_date > '2000-01-01'

'''

pd.io.sql.read_sql(query, con = engine)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>819</td>
    </tr>
  </tbody>
</table>
</div>



После 1 января 2000 года вышло 819 книг.

Для каждой книги посчитайте количество обзоров и среднюю оценку


```python
query = '''

SELECT b.book_id, 
       b.title, 
       COUNT(DISTINCT rev.review_id) AS count_reviews, 
       ROUND(AVG(r.rating),2) AS avg_rating
FROM books AS b

LEFT JOIN reviews AS rev
ON b.book_id = rev.book_id

LEFT JOIN  ratings AS r
ON b.book_id = r.book_id

GROUP BY b.book_id, b.title
ORDER BY count_reviews DESC

'''

pd.io.sql.read_sql(query, con = engine)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>book_id</th>
      <th>title</th>
      <th>count_reviews</th>
      <th>avg_rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>948</td>
      <td>Twilight (Twilight  #1)</td>
      <td>7</td>
      <td>3.66</td>
    </tr>
    <tr>
      <th>1</th>
      <td>963</td>
      <td>Water for Elephants</td>
      <td>6</td>
      <td>3.98</td>
    </tr>
    <tr>
      <th>2</th>
      <td>734</td>
      <td>The Glass Castle</td>
      <td>6</td>
      <td>4.21</td>
    </tr>
    <tr>
      <th>3</th>
      <td>302</td>
      <td>Harry Potter and the Prisoner of Azkaban (Harr...</td>
      <td>6</td>
      <td>4.41</td>
    </tr>
    <tr>
      <th>4</th>
      <td>695</td>
      <td>The Curious Incident of the Dog in the Night-Time</td>
      <td>6</td>
      <td>4.08</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>83</td>
      <td>Anne Rice's The Vampire Lestat: A Graphic Novel</td>
      <td>0</td>
      <td>3.67</td>
    </tr>
    <tr>
      <th>996</th>
      <td>808</td>
      <td>The Natural Way to Draw</td>
      <td>0</td>
      <td>3.00</td>
    </tr>
    <tr>
      <th>997</th>
      <td>672</td>
      <td>The Cat in the Hat and Other Dr. Seuss Favorites</td>
      <td>0</td>
      <td>5.00</td>
    </tr>
    <tr>
      <th>998</th>
      <td>221</td>
      <td>Essential Tales and Poems</td>
      <td>0</td>
      <td>4.00</td>
    </tr>
    <tr>
      <th>999</th>
      <td>191</td>
      <td>Disney's Beauty and the Beast (A Little Golden...</td>
      <td>0</td>
      <td>4.00</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 4 columns</p>
</div>




```python
query = '''

SELECT COUNT(book_id)
FROM books

'''

pd.io.sql.read_sql(query, con = engine)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1000</td>
    </tr>
  </tbody>
</table>
</div>



Из 1000 книг средняя оценка вариирует от 1.5 до 5. Средняя оценка не зависит от количества обзоров. Больше всего обзоров у книги Twilight (Сумерки) - 7, но рейтинг у данной книги - 3.66. Есть книги, которые не получили обзора пользователей. Разрекламированная книга не значит, что она интересна пользователю.

Определите издательство, которое выпустило наибольшее число книг толще 50 страниц — так вы исключите из анализа брошюры


```python
query = '''

SELECT pub.publisher,
       COUNT(b.title) AS count_pub
       
      
FROM publishers AS pub

RIGHT JOIN books AS b
ON b.publisher_id = pub.publisher_id
WHERE num_pages>50
GROUP BY publisher

ORDER BY count_pub DESC 
LIMIT 1

'''

pd.io.sql.read_sql(query, con = engine)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>publisher</th>
      <th>count_pub</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Penguin Books</td>
      <td>42</td>
    </tr>
  </tbody>
</table>
</div>



Издательство Penguin Books выпустило больше всего книг толще 50 страниц - 42 шт.

Определите автора с самой высокой средней оценкой книг — учитывайте только книги с 50 и более оценками


```python
query = '''
SELECT  a.author,
        AVG(avg_book_avg_ratings.avg_b_r) as   avg_a_r 
FROM authors As a
JOIN books As b ON b.author_id = a.author_id
JOIN (
    SELECT
        book_id,
        AVG(rating) as avg_b_r
    from ratings
    group by book_id
    having count(rating_id) >= 50
) as avg_book_avg_ratings on
     avg_book_avg_ratings.book_id = b.book_id
GROUP BY a.author
ORDER BY avg_a_r DESC
LIMIT 1
'''

pd.io.sql.read_sql(query, con = engine)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>author</th>
      <th>avg_a_r</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>J.K. Rowling/Mary GrandPré</td>
      <td>4.283844</td>
    </tr>
  </tbody>
</table>
</div>



Самой высокой средней оценкой книг(только книги с 50 и более оценками) является автор -J.K. Rowling/Mary GrandPré.Средняя оценка книг составляет 4.283844.

Посчитайте среднее количество обзоров от пользователей, которые поставили больше 48 оценок


```python
query = '''

WITH

u_rating As (SELECT username,
                    COUNT(rating) As count_rating
             FROM ratings
             GROUP  BY 1
             HAVING COUNT(rating)> 48
             ORDER BY count_rating DESC
),
u_review As (SELECT username, 
                    COUNT(text) As count_text
             FROM reviews
             GROUP  BY 1
             ORDER BY count_text DESC   
)
SELECT AVG(urg.count_text) As avg_count
FROM u_rating As urw JOIN u_review As urg ON urg.username = urw.username

'''

pd.io.sql.read_sql(query, con = engine)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>avg_count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>24.0</td>
    </tr>
  </tbody>
</table>
</div>



Среднее количество обзоров от пользователей, которые поставили больше 48 оценок составляет 24.

ВЫВОДЫ:
- После 1 января 2000 года вышло 819 книг. 
- Из 1000 книг средняя оценка варьирует от 1.5 до 5. Средняя оценка не зависит от количества обзоров. Больше всего обзоров у книги Twilight (Сумерки) - 7, но рейтинг у данной книги - 3.66. Есть книги, которые не получили обзора пользователей. Разрекламированная книга не значит, что она интересна пользователю.
- Издательство Penguin Books выпустило больше всего книг толще 50 страниц - 42 шт.
- Самой высокой средней оценкой книг(только книги с 50 и более оценками) является автор -J.K. Rowling/Mary GrandPré.Средняя оценка книг составляет 4.283844.
- Среднее количество обзоров от пользователей, которые поставили больше 48 оценок составляет 24.

Рекомендации:

    - Увеличить ассортимент книг;
    - Увеличить количество книг;
    - Устраивать рекламные кампании;
    - Придумать систему поощрения пользователей.    
