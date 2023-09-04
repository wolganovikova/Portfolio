<h1>Table of Contents<span class="tocSkip"></span></h1>
<div class="toc"><ul class="toc-item"></ul></div>

# Анализ пользовательского взаимодействия с карточками статей 

Цели исследования: 
- Определить взаимодействия пользователей с карточками в системе с разбивкой по темам карточек;
- Определить как события генерируют источники с разными темами;
- Определить соотношения темы карточек и темы источников.

Данные исследования: составлены на основе приложения для просмотра и создания контента Яндекс.Дзен за 24.09.2019 c 18:28 до 19:00 из  источника данных: файл dash_visits.csv


Для менеджера по анализу контента был составлен дашборд, который будет использоваться не реже, чем раз в неделю.

Состав данных для дашборда:
- История событий по темам карточек (два графика - абсолютные числа и процентное соотношение);
- Разбивка событий по темам источников;
- Таблица соответствия тем источников темам карточек;

По каким параметрам данные должны группироваться:
- Дата и время;
- Тема карточки;
- Тема источника;
- Возрастная группа;

Характер данных:
- История событий по темам карточек — абсолютные величины с разбивкой по минутам;
- Разбивка событий по темам источников — относительные величины (% событий);
- Соответствия тем источников темам карточек - абсолютные величины;

Дата-инженеры подготовили агрегирующую таблицу dash_visits, которая является источником данных для дашборда.

Вот её структура:
- record_id — первичный ключ,
- item_topic — тема карточки,
- source_topic — тема источника,
- age_segment — возрастной сегмент,
- dt — дата и время,
- visits — количество событий.



```python
!pip install psycopg2_binary
```

    Requirement already satisfied: psycopg2_binary in c:\users\tima\anaconda3\lib\site-packages (2.9.6)
    


```python
# импортируем библиотеки
import pandas as pd
from sqlalchemy import create_engine

db_config = {'user': 'praktikum_student', # имя пользователя
            'pwd': 'Sdf4$2;d-d30pp', # пароль
            'host': 'rc1b-wcoijxj3yxfsf3fs.mdb.yandexcloud.net',
            'port': 6432, # порт подключения
            'db': 'data-analyst-zen-project-db'} # название базы данных

connection_string = 'postgresql://{}:{}@{}:{}/{}'.format(db_config['user'],
                                                db_config['pwd'],
                                                db_config['host'],
                                                db_config['port'],
                                                db_config['db'])

engine = create_engine(connection_string)

#формируем текст запроса к базе SQL
query = ''' SELECT * 
        FROM dash_visits
    '''
#Сохраняем в переменную dash_visits данные, выгруженные
#из SQL в соответствии с запросом
dash_visits = pd.io.sql.read_sql(query, con = engine)

display(dash_visits.head())
display(dash_visits.info())
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
      <th>record_id</th>
      <th>item_topic</th>
      <th>source_topic</th>
      <th>age_segment</th>
      <th>dt</th>
      <th>visits</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1040597</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:32:00</td>
      <td>3</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1040598</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:35:00</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1040599</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:54:00</td>
      <td>4</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1040600</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:55:00</td>
      <td>17</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1040601</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:56:00</td>
      <td>27</td>
    </tr>
  </tbody>
</table>
</div>


    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 30745 entries, 0 to 30744
    Data columns (total 6 columns):
     #   Column        Non-Null Count  Dtype         
    ---  ------        --------------  -----         
     0   record_id     30745 non-null  int64         
     1   item_topic    30745 non-null  object        
     2   source_topic  30745 non-null  object        
     3   age_segment   30745 non-null  object        
     4   dt            30745 non-null  datetime64[ns]
     5   visits        30745 non-null  int64         
    dtypes: datetime64[ns](1), int64(2), object(3)
    memory usage: 1.4+ MB
    


    None



```python
#выгружаем файл в формате csv для работы в Tableau
dash_visits.to_csv(r"dash_visits.csv", index=False)
```


```python
dash_visits.sort_values(by=['item_topic','source_topic'])
dash_visits.head()
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
      <th>record_id</th>
      <th>item_topic</th>
      <th>source_topic</th>
      <th>age_segment</th>
      <th>dt</th>
      <th>visits</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1040597</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:32:00</td>
      <td>3</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1040598</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:35:00</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1040599</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:54:00</td>
      <td>4</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1040600</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:55:00</td>
      <td>17</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1040601</td>
      <td>Деньги</td>
      <td>Авто</td>
      <td>18-25</td>
      <td>2019-09-24 18:56:00</td>
      <td>27</td>
    </tr>
  </tbody>
</table>
</div>




```python
# уникальные данные столбца item_topic
dash_visits['item_topic'].unique()
```




    array(['Деньги', 'Дети', 'Женская психология', 'Женщины', 'Здоровье',
           'Знаменитости', 'Интересные факты', 'Искусство', 'История',
           'Красота', 'Культура', 'Наука', 'Общество', 'Отношения',
           'Подборки', 'Полезные советы', 'Психология', 'Путешествия',
           'Рассказы', 'Россия', 'Семья', 'Скандалы', 'Туризм', 'Шоу', 'Юмор'],
          dtype=object)




```python
# уникальные данные столбца source_topic
dash_visits['source_topic'].unique()
```




    array(['Авто', 'Деньги', 'Дети', 'Еда', 'Здоровье', 'Знаменитости',
           'Интерьеры', 'Искусство', 'История', 'Кино', 'Музыка', 'Одежда',
           'Полезные советы', 'Политика', 'Психология', 'Путешествия',
           'Ремонт', 'Россия', 'Сад и дача', 'Сделай сам',
           'Семейные отношения', 'Семья', 'Спорт', 'Строительство',
           'Технологии', 'Финансы'], dtype=object)




```python
# уникальные данные столбца age_segment
dash_visits['age_segment'].unique()
```




    array(['18-25', '26-30', '31-35', '36-40', '41-45', '45+'], dtype=object)




```python
# формируем данные по столбцу item_topic
dash_visits_item_topic_total = dash_visits.groupby('item_topic')['visits'].sum()
dash_visits_item_topic_total
```




    item_topic
    Деньги                10291
    Дети                  10989
    Женская психология     7737
    Женщины               11499
    Здоровье              10399
    Знаменитости           7394
    Интересные факты      19942
    Искусство              8516
    История               15389
    Красота                9814
    Культура              10205
    Наука                 21736
    Общество              19640
    Отношения             20666
    Подборки              17772
    Полезные советы       15435
    Психология             8036
    Путешествия            9260
    Рассказы              10909
    Россия                16966
    Семья                 11897
    Скандалы               9294
    Туризм                 9512
    Шоу                    7511
    Юмор                   9398
    Name: visits, dtype: int64




```python
# формируем данные по столбцам item_topic и dt 
dash_visits_item_topic = dash_visits.groupby(['item_topic', 'dt'])['visits'].agg(sum).sort_values(ascending=False)
dash_visits_item_topic
```




    item_topic          dt                 
    Наука               2019-09-24 18:58:00    4372
                        2019-09-24 18:57:00    4277
    Отношения           2019-09-24 18:58:00    4145
                        2019-09-24 18:57:00    4133
    Интересные факты    2019-09-24 18:58:00    3910
                                               ... 
    Искусство           2019-09-24 18:35:00       4
    Знаменитости        2019-09-24 18:35:00       4
    Туризм              2019-09-24 18:35:00       4
    Женская психология  2019-09-24 18:35:00       3
    Шоу                 2019-09-24 18:35:00       2
    Name: visits, Length: 425, dtype: int64




```python
# формируем данные по столбцам item_topic и dt(% от общего количества) 
dash_tota_item_topic_percent = (dash_visits_item_topic/dash_visits_item_topic_total*100).round(2)
dash_tota_item_topic_percent
```




    item_topic          dt                 
    Наука               2019-09-24 18:58:00    20.11
                        2019-09-24 18:57:00    19.68
    Отношения           2019-09-24 18:58:00    20.06
                        2019-09-24 18:57:00    20.00
    Интересные факты    2019-09-24 18:58:00    19.61
                                               ...  
    Искусство           2019-09-24 18:35:00     0.05
    Знаменитости        2019-09-24 18:35:00     0.05
    Туризм              2019-09-24 18:35:00     0.04
    Женская психология  2019-09-24 18:35:00     0.04
    Шоу                 2019-09-24 18:35:00     0.03
    Name: visits, Length: 425, dtype: float64




```python
dash_visits_it = pd.pivot_table(dash_visits, index=['item_topic'], values=['visits'], aggfunc='sum')\
                .reset_index().sort_values(by='visits', ascending=False)
dash_visits_it
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
      <th>item_topic</th>
      <th>visits</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>11</th>
      <td>Наука</td>
      <td>21736</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Отношения</td>
      <td>20666</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Интересные факты</td>
      <td>19942</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Общество</td>
      <td>19640</td>
    </tr>
    <tr>
      <th>14</th>
      <td>Подборки</td>
      <td>17772</td>
    </tr>
    <tr>
      <th>19</th>
      <td>Россия</td>
      <td>16966</td>
    </tr>
    <tr>
      <th>15</th>
      <td>Полезные советы</td>
      <td>15435</td>
    </tr>
    <tr>
      <th>8</th>
      <td>История</td>
      <td>15389</td>
    </tr>
    <tr>
      <th>20</th>
      <td>Семья</td>
      <td>11897</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Женщины</td>
      <td>11499</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Дети</td>
      <td>10989</td>
    </tr>
    <tr>
      <th>18</th>
      <td>Рассказы</td>
      <td>10909</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Здоровье</td>
      <td>10399</td>
    </tr>
    <tr>
      <th>0</th>
      <td>Деньги</td>
      <td>10291</td>
    </tr>
    <tr>
      <th>10</th>
      <td>Культура</td>
      <td>10205</td>
    </tr>
    <tr>
      <th>9</th>
      <td>Красота</td>
      <td>9814</td>
    </tr>
    <tr>
      <th>22</th>
      <td>Туризм</td>
      <td>9512</td>
    </tr>
    <tr>
      <th>24</th>
      <td>Юмор</td>
      <td>9398</td>
    </tr>
    <tr>
      <th>21</th>
      <td>Скандалы</td>
      <td>9294</td>
    </tr>
    <tr>
      <th>17</th>
      <td>Путешествия</td>
      <td>9260</td>
    </tr>
    <tr>
      <th>7</th>
      <td>Искусство</td>
      <td>8516</td>
    </tr>
    <tr>
      <th>16</th>
      <td>Психология</td>
      <td>8036</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Женская психология</td>
      <td>7737</td>
    </tr>
    <tr>
      <th>23</th>
      <td>Шоу</td>
      <td>7511</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Знаменитости</td>
      <td>7394</td>
    </tr>
  </tbody>
</table>
</div>




```python
dash_visits_t
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
      <th>item_topic</th>
      <th>dt</th>
      <th>visits</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>201</th>
      <td>Наука</td>
      <td>2019-09-24 18:58:00</td>
      <td>4372</td>
    </tr>
    <tr>
      <th>200</th>
      <td>Наука</td>
      <td>2019-09-24 18:57:00</td>
      <td>4277</td>
    </tr>
    <tr>
      <th>235</th>
      <td>Отношения</td>
      <td>2019-09-24 18:58:00</td>
      <td>4145</td>
    </tr>
    <tr>
      <th>234</th>
      <td>Отношения</td>
      <td>2019-09-24 18:57:00</td>
      <td>4133</td>
    </tr>
    <tr>
      <th>116</th>
      <td>Интересные факты</td>
      <td>2019-09-24 18:58:00</td>
      <td>3910</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>126</th>
      <td>Искусство</td>
      <td>2019-09-24 18:35:00</td>
      <td>4</td>
    </tr>
    <tr>
      <th>92</th>
      <td>Знаменитости</td>
      <td>2019-09-24 18:35:00</td>
      <td>4</td>
    </tr>
    <tr>
      <th>381</th>
      <td>Туризм</td>
      <td>2019-09-24 18:35:00</td>
      <td>4</td>
    </tr>
    <tr>
      <th>41</th>
      <td>Женская психология</td>
      <td>2019-09-24 18:35:00</td>
      <td>3</td>
    </tr>
    <tr>
      <th>398</th>
      <td>Шоу</td>
      <td>2019-09-24 18:35:00</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
<p>425 rows × 3 columns</p>
</div>




```python
# формируем данные по столбцу source_topic 
dash_visits_c = pd.pivot_table(dash_visits, index=['source_topic'], values=['visits'], aggfunc='sum')\
                .reset_index().sort_values(by='visits', ascending=False)
# считаем % от общего количества
dash_visits_c['percent'] = (dash_visits_c['visits']/dash_visits['visits']\
                                  .sum()*100).round(2).sort_values(ascending=False)
dash_visits_c
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
      <th>source_topic</th>
      <th>visits</th>
      <th>percent</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>20</th>
      <td>Семейные отношения</td>
      <td>33309</td>
      <td>10.74</td>
    </tr>
    <tr>
      <th>17</th>
      <td>Россия</td>
      <td>29831</td>
      <td>9.62</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Полезные советы</td>
      <td>27412</td>
      <td>8.84</td>
    </tr>
    <tr>
      <th>15</th>
      <td>Путешествия</td>
      <td>24124</td>
      <td>7.78</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Знаменитости</td>
      <td>23945</td>
      <td>7.72</td>
    </tr>
    <tr>
      <th>9</th>
      <td>Кино</td>
      <td>20084</td>
      <td>6.47</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Дети</td>
      <td>15243</td>
      <td>4.91</td>
    </tr>
    <tr>
      <th>8</th>
      <td>История</td>
      <td>14628</td>
      <td>4.72</td>
    </tr>
    <tr>
      <th>21</th>
      <td>Семья</td>
      <td>13896</td>
      <td>4.48</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Здоровье</td>
      <td>12831</td>
      <td>4.14</td>
    </tr>
    <tr>
      <th>11</th>
      <td>Одежда</td>
      <td>11895</td>
      <td>3.83</td>
    </tr>
    <tr>
      <th>0</th>
      <td>Авто</td>
      <td>9567</td>
      <td>3.08</td>
    </tr>
    <tr>
      <th>7</th>
      <td>Искусство</td>
      <td>8001</td>
      <td>2.58</td>
    </tr>
    <tr>
      <th>18</th>
      <td>Сад и дача</td>
      <td>7470</td>
      <td>2.41</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Политика</td>
      <td>7341</td>
      <td>2.37</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Еда</td>
      <td>6892</td>
      <td>2.22</td>
    </tr>
    <tr>
      <th>19</th>
      <td>Сделай сам</td>
      <td>6287</td>
      <td>2.03</td>
    </tr>
    <tr>
      <th>14</th>
      <td>Психология</td>
      <td>5730</td>
      <td>1.85</td>
    </tr>
    <tr>
      <th>16</th>
      <td>Ремонт</td>
      <td>5699</td>
      <td>1.84</td>
    </tr>
    <tr>
      <th>22</th>
      <td>Спорт</td>
      <td>5253</td>
      <td>1.69</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Деньги</td>
      <td>5157</td>
      <td>1.66</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Интерьеры</td>
      <td>3614</td>
      <td>1.17</td>
    </tr>
    <tr>
      <th>24</th>
      <td>Технологии</td>
      <td>3501</td>
      <td>1.13</td>
    </tr>
    <tr>
      <th>23</th>
      <td>Строительство</td>
      <td>3000</td>
      <td>0.97</td>
    </tr>
    <tr>
      <th>10</th>
      <td>Музыка</td>
      <td>2869</td>
      <td>0.92</td>
    </tr>
    <tr>
      <th>25</th>
      <td>Финансы</td>
      <td>2628</td>
      <td>0.85</td>
    </tr>
  </tbody>
</table>
</div>



Общие выводы:
Топ-5 событий по темам карточек:
 
- 1.Наука - 4372
- 2.Отношения - 4145
- 3.Интересные факты - 3910
- 4.Общество - 3897
- 5.Подборки – 3520

Топ-5 % событий по темам карточек :
- 1.История -9.184%
- 2.Полезные советы – 8.673%
- 3.Наука – 8.183%
- 4.Интересные факты – 7.375%
- 5.Подборки – 7.143%

Топ -5 событий по темам источника:
- 1.Семейные отношения – 10.74%
- 2.Россия – 9.62%
- 3.Полезные советы – 8.84%
- 4.Путешествия – 7.78%
- 5.Знаменитости – 7.72%

Топ-5 соответствий тем карточек темам источников:
- 1.Рассказы-путешествия - 4587
- 2.Общество-Россия – 3471
- 3.Наука-кино – 3279
- 4.Россия-Россия - 2847
- 5.Подборки-полезные советы – 2795



Презентация: <https://drive.google.com/file/d/1G_zCPwV2lVNlCsE61tv4pR9a270kaW6C/view?usp=sharing> 

Сcылка на дашборд: <https://public.tableau.com/app/profile/.36561146/viz/Book1_16863108352290/sheet4?publish=yes> 

