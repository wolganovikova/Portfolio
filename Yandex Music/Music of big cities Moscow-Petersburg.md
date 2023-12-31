<h1>Table of Contents<span class="tocSkip"></span></h1>
<div class="toc"><ul class="toc-item"><li><span><a href="#Обзор-данных" data-toc-modified-id="Обзор-данных-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>Обзор данных</a></span></li><li><span><a href="#Предобработка-данных" data-toc-modified-id="Предобработка-данных-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>Предобработка данных</a></span><ul class="toc-item"><li><span><a href="#Стиль-заголовков" data-toc-modified-id="Стиль-заголовков-2.1"><span class="toc-item-num">2.1&nbsp;&nbsp;</span>Стиль заголовков</a></span></li><li><span><a href="#Пропуски-значений" data-toc-modified-id="Пропуски-значений-2.2"><span class="toc-item-num">2.2&nbsp;&nbsp;</span>Пропуски значений</a></span></li><li><span><a href="#Дубликаты" data-toc-modified-id="Дубликаты-2.3"><span class="toc-item-num">2.3&nbsp;&nbsp;</span>Дубликаты</a></span></li></ul></li><li><span><a href="#Проверка-гипотез" data-toc-modified-id="Проверка-гипотез-3"><span class="toc-item-num">3&nbsp;&nbsp;</span>Проверка гипотез</a></span><ul class="toc-item"><li><span><a href="#Сравнение-поведения-пользователей-двух-столиц" data-toc-modified-id="Сравнение-поведения-пользователей-двух-столиц-3.1"><span class="toc-item-num">3.1&nbsp;&nbsp;</span>Сравнение поведения пользователей двух столиц</a></span></li><li><span><a href="#Музыка-в-начале-и-в-конце-недели" data-toc-modified-id="Музыка-в-начале-и-в-конце-недели-3.2"><span class="toc-item-num">3.2&nbsp;&nbsp;</span>Музыка в начале и в конце недели</a></span></li><li><span><a href="#Жанровые-предпочтения-в-Москве-и-Петербурге" data-toc-modified-id="Жанровые-предпочтения-в-Москве-и-Петербурге-3.3"><span class="toc-item-num">3.3&nbsp;&nbsp;</span>Жанровые предпочтения в Москве и Петербурге</a></span></li></ul></li><li><span><a href="#Итоги-исследования" data-toc-modified-id="Итоги-исследования-4"><span class="toc-item-num">4&nbsp;&nbsp;</span>Итоги исследования</a></span></li></ul></div>

# Исследование данных сервиса “Яндекс.Музыка” — сравнение пользователей двух городов

Сравнение Москвы и Петербурга окружено мифами. Например:
 * Москва — мегаполис, подчинённый жёсткому ритму рабочей недели;
 * Петербург — культурная столица, со своими вкусами.

На данных Яндекс Музыки вы сравните поведение пользователей двух столиц.

**Цель исследования** — проверьте три гипотезы:
1. Активность пользователей зависит от дня недели. Причём в Москве и Петербурге это проявляется по-разному.
2. В понедельник утром в Москве преобладают одни жанры, а в Петербурге — другие. Так же и вечером пятницы преобладают разные жанры — в зависимости от города. 
3. Москва и Петербург предпочитают разные жанры музыки. В Москве чаще слушают поп-музыку, в Петербурге — русский рэп.

**Ход исследования**

Данные о поведении пользователей вы получите из файла `yandex_music_project.csv`. О качестве данных ничего не известно. Поэтому перед проверкой гипотез понадобится обзор данных. 

Вы проверите данные на ошибки и оцените их влияние на исследование. Затем, на этапе предобработки вы поищете возможность исправить самые критичные ошибки данных.
 
Таким образом, исследование пройдёт в три этапа:
 1. Обзор данных.
 2. Предобработка данных.
 3. Проверка гипотез.

**Данные**

Данные хранятся в файле yandex_music_project.csv. На платформе он находится по пути /datasets/yandex_music_project.csv. 

**Описание колонок:**

- userID — идентификатор пользователя;
- Track — название трека;
- artist — имя исполнителя;
- genre — название жанра;
- City — город пользователя;
- time — время начала прослушивания;
- Day — день недели.

## Обзор данных

Составьте первое представление о данных Яндекс Музыки.

**Задание 1**

Основной инструмент аналитика — `pandas`. Импортируйте эту библиотеку.


```python
# импорт библиотеки pandas
import pandas as pd
```

**Задание 2**

Прочитайте файл `yandex_music_project.csv` из папки `/datasets` и сохраните его в переменной `df`:


```python
# чтение файла с данными и сохранение в df
#"B:\Аналитик данных яндекс\Спринт 3 Базовый Python\yandex_music_project.csv"
df = pd.read_csv(r"B:\Аналитик данных яндекс\Спринт 3 Базовый Python\yandex_music_project.csv")
```

**Задание 3**


Выведите на экран первые десять строк таблицы:


```python
# получение первых 10 строк таблицы df
df.head(10)
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
      <th>userID</th>
      <th>Track</th>
      <th>artist</th>
      <th>genre</th>
      <th>City</th>
      <th>time</th>
      <th>Day</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>FFB692EC</td>
      <td>Kamigata To Boots</td>
      <td>The Mass Missile</td>
      <td>rock</td>
      <td>Saint-Petersburg</td>
      <td>20:28:33</td>
      <td>Wednesday</td>
    </tr>
    <tr>
      <th>1</th>
      <td>55204538</td>
      <td>Delayed Because of Accident</td>
      <td>Andreas Rönnberg</td>
      <td>rock</td>
      <td>Moscow</td>
      <td>14:07:09</td>
      <td>Friday</td>
    </tr>
    <tr>
      <th>2</th>
      <td>20EC38</td>
      <td>Funiculì funiculà</td>
      <td>Mario Lanza</td>
      <td>pop</td>
      <td>Saint-Petersburg</td>
      <td>20:58:07</td>
      <td>Wednesday</td>
    </tr>
    <tr>
      <th>3</th>
      <td>A3DD03C9</td>
      <td>Dragons in the Sunset</td>
      <td>Fire + Ice</td>
      <td>folk</td>
      <td>Saint-Petersburg</td>
      <td>08:37:09</td>
      <td>Monday</td>
    </tr>
    <tr>
      <th>4</th>
      <td>E2DC1FAE</td>
      <td>Soul People</td>
      <td>Space Echo</td>
      <td>dance</td>
      <td>Moscow</td>
      <td>08:34:34</td>
      <td>Monday</td>
    </tr>
    <tr>
      <th>5</th>
      <td>842029A1</td>
      <td>Преданная</td>
      <td>IMPERVTOR</td>
      <td>rusrap</td>
      <td>Saint-Petersburg</td>
      <td>13:09:41</td>
      <td>Friday</td>
    </tr>
    <tr>
      <th>6</th>
      <td>4CB90AA5</td>
      <td>True</td>
      <td>Roman Messer</td>
      <td>dance</td>
      <td>Moscow</td>
      <td>13:00:07</td>
      <td>Wednesday</td>
    </tr>
    <tr>
      <th>7</th>
      <td>F03E1C1F</td>
      <td>Feeling This Way</td>
      <td>Polina Griffith</td>
      <td>dance</td>
      <td>Moscow</td>
      <td>20:47:49</td>
      <td>Wednesday</td>
    </tr>
    <tr>
      <th>8</th>
      <td>8FA1D3BE</td>
      <td>И вновь продолжается бой</td>
      <td>NaN</td>
      <td>ruspop</td>
      <td>Moscow</td>
      <td>09:17:40</td>
      <td>Friday</td>
    </tr>
    <tr>
      <th>9</th>
      <td>E772D5C0</td>
      <td>Pessimist</td>
      <td>NaN</td>
      <td>dance</td>
      <td>Saint-Petersburg</td>
      <td>21:20:49</td>
      <td>Wednesday</td>
    </tr>
  </tbody>
</table>
</div>



**Задание 4**


Одной командой получить общую информацию о таблице c помощью метода `info()`:


```python
# получение общей информации о данных в таблице df
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 65079 entries, 0 to 65078
    Data columns (total 7 columns):
     #   Column    Non-Null Count  Dtype 
    ---  ------    --------------  ----- 
     0     userID  65079 non-null  object
     1   Track     63848 non-null  object
     2   artist    57876 non-null  object
     3   genre     63881 non-null  object
     4     City    65079 non-null  object
     5   time      65079 non-null  object
     6   Day       65079 non-null  object
    dtypes: object(7)
    memory usage: 3.5+ MB
    

Итак, в таблице семь столбцов. Тип данных во всех столбцах — `object`.

Согласно документации к данным:
* `userID` — идентификатор пользователя;
* `Track` — название трека;  
* `artist` — имя исполнителя;
* `genre` — название жанра;
* `City` — город пользователя;
* `time` — время начала прослушивания;
* `Day` — день недели.

Количество значений в столбцах различается. Значит, в данных есть пропущенные значения.

**Задание 5**

**Вопрос со свободной формой ответа**

В названиях колонок видны нарушения стиля:
* Строчные буквы сочетаются с прописными.
* Встречаются пробелы.

Какое третье нарушение?


```python
# Напишите ваш ответ здесь комментарием. Не удаляйте символ #. Не меняйте тип этой ячейки на Markdown.
#Название состоящее из двух слов 
```

**Выводы**

В каждой строке таблицы — данные о прослушанном треке. Часть колонок описывает саму композицию: название, исполнителя и жанр. Остальные данные рассказывают о пользователе: из какого он города, когда он слушал музыку. 

Предварительно можно утверждать, что данных достаточно для проверки гипотез. Но встречаются пропуски в данных, а в названиях колонок — расхождения с хорошим стилем.

Чтобы двигаться дальше, нужно устранить проблемы в данных.

## Предобработка данных
Исправьте стиль в заголовках столбцов, исключите пропуски. Затем проверьте данные на дубликаты.

### Стиль заголовков

**Задание 6**

Выведите на экран названия столбцов:


```python
# перечень названий столбцов таблицы df
df.columns
```




    Index(['  userID', 'Track', 'artist', 'genre', '  City  ', 'time', 'Day'], dtype='object')



**Задание 7**


Приведите названия в соответствие с хорошим стилем:
* несколько слов в названии запишите в «змеином_регистре»,
* все символы сделайте строчными,
* устраните пробелы.

Для этого переименуйте колонки так:
* `'  userID'` → `'user_id'`;
* `'Track'` → `'track'`;
* `'  City  '` → `'city'`;
* `'Day'` → `'day'`.


```python
# переименование столбцов
df=df.rename(columns={'  userID':'user_id', 'Track':'track', '  City  ':'city', 'Day':'day'})
```

**Задание 8**


Проверьте результат. Для этого ещё раз выведите на экран названия столбцов:


```python
# проверка результатов - перечень названий столбцов
df.columns
```




    Index(['user_id', 'track', 'artist', 'genre', 'city', 'time', 'day'], dtype='object')



### Пропуски значений

**Задание 9**

Сначала посчитайте, сколько в таблице пропущенных значений. Для этого достаточно двух методов `pandas`:


```python
# подсчёт пропусков
df.isna().sum()
```




    user_id       0
    track      1231
    artist     7203
    genre      1198
    city          0
    time          0
    day           0
    dtype: int64



Не все пропущенные значения влияют на исследование. Так в `track` и `artist` пропуски не важны для вашей работы. Достаточно заменить их явными обозначениями.

Но пропуски в `genre` могут помешать сравнению музыкальных вкусов в Москве и Санкт-Петербурге. На практике было бы правильно установить причину пропусков и восстановить данные. Такой возможности нет в учебном проекте. Придётся:
* заполнить и эти пропуски явными обозначениями;
* оценить, насколько они повредят расчётам. 

**Задание 10**

Замените пропущенные значения в столбцах `track`, `artist` и `genre` на строку `'unknown'`. Для этого создайте список `columns_to_replace`, переберите его элементы циклом `for` и для каждого столбца выполните замену пропущенных значений:


```python
# перебор названий столбцов в цикле и замена пропущенных значений на 'unknown'
columns_to_replace = ['track', 'artist', 'genre']
for columns in columns_to_replace:
    df[columns] = df[columns].fillna('unknown') 
```

**Задание 11**

Убедитесь, что в таблице не осталось пропусков. Для этого ещё раз посчитайте пропущенные значения.


```python
# подсчёт пропусков
df.isna().sum()
```




    user_id    0
    track      0
    artist     0
    genre      0
    city       0
    time       0
    day        0
    dtype: int64



### Дубликаты

**Задание 12**

Посчитайте явные дубликаты в таблице одной командой:


```python
# подсчёт явных дубликатов
df.duplicated().sum()
```




    3826



**Задание 13**

Вызовите специальный метод `pandas`, чтобы удалить явные дубликаты:


```python
# удаление явных дубликатов
df = df.drop_duplicates()
df
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
      <th>user_id</th>
      <th>track</th>
      <th>artist</th>
      <th>genre</th>
      <th>city</th>
      <th>time</th>
      <th>day</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>FFB692EC</td>
      <td>Kamigata To Boots</td>
      <td>The Mass Missile</td>
      <td>rock</td>
      <td>Saint-Petersburg</td>
      <td>20:28:33</td>
      <td>Wednesday</td>
    </tr>
    <tr>
      <th>1</th>
      <td>55204538</td>
      <td>Delayed Because of Accident</td>
      <td>Andreas Rönnberg</td>
      <td>rock</td>
      <td>Moscow</td>
      <td>14:07:09</td>
      <td>Friday</td>
    </tr>
    <tr>
      <th>2</th>
      <td>20EC38</td>
      <td>Funiculì funiculà</td>
      <td>Mario Lanza</td>
      <td>pop</td>
      <td>Saint-Petersburg</td>
      <td>20:58:07</td>
      <td>Wednesday</td>
    </tr>
    <tr>
      <th>3</th>
      <td>A3DD03C9</td>
      <td>Dragons in the Sunset</td>
      <td>Fire + Ice</td>
      <td>folk</td>
      <td>Saint-Petersburg</td>
      <td>08:37:09</td>
      <td>Monday</td>
    </tr>
    <tr>
      <th>4</th>
      <td>E2DC1FAE</td>
      <td>Soul People</td>
      <td>Space Echo</td>
      <td>dance</td>
      <td>Moscow</td>
      <td>08:34:34</td>
      <td>Monday</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>65074</th>
      <td>729CBB09</td>
      <td>My Name</td>
      <td>McLean</td>
      <td>rnb</td>
      <td>Moscow</td>
      <td>13:32:28</td>
      <td>Wednesday</td>
    </tr>
    <tr>
      <th>65075</th>
      <td>D08D4A55</td>
      <td>Maybe One Day (feat. Black Spade)</td>
      <td>Blu &amp; Exile</td>
      <td>hip</td>
      <td>Saint-Petersburg</td>
      <td>10:00:00</td>
      <td>Monday</td>
    </tr>
    <tr>
      <th>65076</th>
      <td>C5E3A0D5</td>
      <td>Jalopiina</td>
      <td>unknown</td>
      <td>industrial</td>
      <td>Moscow</td>
      <td>20:09:26</td>
      <td>Friday</td>
    </tr>
    <tr>
      <th>65077</th>
      <td>321D0506</td>
      <td>Freight Train</td>
      <td>Chas McDevitt</td>
      <td>rock</td>
      <td>Moscow</td>
      <td>21:43:59</td>
      <td>Friday</td>
    </tr>
    <tr>
      <th>65078</th>
      <td>3A64EF84</td>
      <td>Tell Me Sweet Little Lies</td>
      <td>Monica Lopez</td>
      <td>country</td>
      <td>Moscow</td>
      <td>21:59:46</td>
      <td>Friday</td>
    </tr>
  </tbody>
</table>
<p>61253 rows × 7 columns</p>
</div>



**Задание 14**

Ещё раз посчитайте явные дубликаты в таблице — убедитесь, что полностью от них избавились:


```python
# проверка на отсутствие дубликатов
df.duplicated().sum()
```




    0



Теперь избавьтесь от неявных дубликатов в колонке `genre`. Например, название одного и того же жанра может быть записано немного по-разному. Такие ошибки тоже повлияют на результат исследования.

**Задание 15**

Выведите на экран список уникальных названий жанров, отсортированный в алфавитном порядке. Для этого:
1. извлеките нужный столбец датафрейма; 
2. примените к нему метод сортировки;
3. для отсортированного столбца вызовите метод, который вернёт уникальные значения из столбца.


```python
# Просмотр уникальных названий жанров
df['genre'].sort_values().unique()
```




    array(['acid', 'acoustic', 'action', 'adult', 'africa', 'afrikaans',
           'alternative', 'alternativepunk', 'ambient', 'americana',
           'animated', 'anime', 'arabesk', 'arabic', 'arena',
           'argentinetango', 'art', 'audiobook', 'author', 'avantgarde',
           'axé', 'baile', 'balkan', 'beats', 'bigroom', 'black', 'bluegrass',
           'blues', 'bollywood', 'bossa', 'brazilian', 'breakbeat', 'breaks',
           'broadway', 'cantautori', 'cantopop', 'canzone', 'caribbean',
           'caucasian', 'celtic', 'chamber', 'chanson', 'children', 'chill',
           'chinese', 'choral', 'christian', 'christmas', 'classical',
           'classicmetal', 'club', 'colombian', 'comedy', 'conjazz',
           'contemporary', 'country', 'cuban', 'dance', 'dancehall',
           'dancepop', 'dark', 'death', 'deep', 'deutschrock', 'deutschspr',
           'dirty', 'disco', 'dnb', 'documentary', 'downbeat', 'downtempo',
           'drum', 'dub', 'dubstep', 'eastern', 'easy', 'electronic',
           'electropop', 'emo', 'entehno', 'epicmetal', 'estrada', 'ethnic',
           'eurofolk', 'european', 'experimental', 'extrememetal', 'fado',
           'fairytail', 'film', 'fitness', 'flamenco', 'folk', 'folklore',
           'folkmetal', 'folkrock', 'folktronica', 'forró', 'frankreich',
           'französisch', 'french', 'funk', 'future', 'gangsta', 'garage',
           'german', 'ghazal', 'gitarre', 'glitch', 'gospel', 'gothic',
           'grime', 'grunge', 'gypsy', 'handsup', "hard'n'heavy", 'hardcore',
           'hardstyle', 'hardtechno', 'hip', 'hip-hop', 'hiphop',
           'historisch', 'holiday', 'hop', 'horror', 'house', 'hymn', 'idm',
           'independent', 'indian', 'indie', 'indipop', 'industrial',
           'inspirational', 'instrumental', 'international', 'irish', 'jam',
           'japanese', 'jazz', 'jewish', 'jpop', 'jungle', 'k-pop',
           'karadeniz', 'karaoke', 'kayokyoku', 'korean', 'laiko', 'latin',
           'latino', 'leftfield', 'local', 'lounge', 'loungeelectronic',
           'lovers', 'malaysian', 'mandopop', 'marschmusik', 'meditative',
           'mediterranean', 'melodic', 'metal', 'metalcore', 'mexican',
           'middle', 'minimal', 'miscellaneous', 'modern', 'mood', 'mpb',
           'muslim', 'native', 'neoklassik', 'neue', 'new', 'newage',
           'newwave', 'nu', 'nujazz', 'numetal', 'oceania', 'old', 'opera',
           'orchestral', 'other', 'piano', 'podcasts', 'pop', 'popdance',
           'popelectronic', 'popeurodance', 'poprussian', 'post',
           'posthardcore', 'postrock', 'power', 'progmetal', 'progressive',
           'psychedelic', 'punjabi', 'punk', 'quebecois', 'ragga', 'ram',
           'rancheras', 'rap', 'rave', 'reggae', 'reggaeton', 'regional',
           'relax', 'religious', 'retro', 'rhythm', 'rnb', 'rnr', 'rock',
           'rockabilly', 'rockalternative', 'rockindie', 'rockother',
           'romance', 'roots', 'ruspop', 'rusrap', 'rusrock', 'russian',
           'salsa', 'samba', 'scenic', 'schlager', 'self', 'sertanejo',
           'shanson', 'shoegazing', 'showtunes', 'singer', 'ska', 'skarock',
           'slow', 'smooth', 'soft', 'soul', 'soulful', 'sound', 'soundtrack',
           'southern', 'specialty', 'speech', 'spiritual', 'sport',
           'stonerrock', 'surf', 'swing', 'synthpop', 'synthrock',
           'sängerportrait', 'tango', 'tanzorchester', 'taraftar', 'tatar',
           'tech', 'techno', 'teen', 'thrash', 'top', 'traditional',
           'tradjazz', 'trance', 'tribal', 'trip', 'triphop', 'tropical',
           'türk', 'türkçe', 'ukrrock', 'unknown', 'urban', 'uzbek',
           'variété', 'vi', 'videogame', 'vocal', 'western', 'world',
           'worldbeat', 'ïîï', 'электроника'], dtype=object)



**Задание 16**

Просмотрите список и найдите неявные дубликаты названия `hiphop`. Это могут быть названия с ошибками или альтернативные названия того же жанра.

Вы увидите следующие неявные дубликаты:
* *hip*,
* *hop*,
* *hip-hop*.

Чтобы очистить от них таблицу используйте метод `replace()` с двумя аргументами: списком строк-дубликатов (включащий *hip*, *hop* и *hip-hop*) и строкой с правильным значением. Вам нужно исправить колонку `genre` в таблице `df`: заменить каждое значение из списка дубликатов на верное. Вместо `hip`, `hop` и `hip-hop` в таблице должно быть значение `hiphop`:


```python
# Устранение неявных дубликатов

df['genre'] = df['genre'].replace(['hip', 'hop', 'hip-hop'], 'hiphop')
```

**Задание 17**

Проверьте, что заменили неправильные названия:

*   hip,
*   hop,
*   hip-hop.

Выведите отсортированный список уникальных значений столбца `genre`:


```python
# Проверка на неявные дубликаты
df['genre'].sort_values().unique()
```




    array(['acid', 'acoustic', 'action', 'adult', 'africa', 'afrikaans',
           'alternative', 'alternativepunk', 'ambient', 'americana',
           'animated', 'anime', 'arabesk', 'arabic', 'arena',
           'argentinetango', 'art', 'audiobook', 'author', 'avantgarde',
           'axé', 'baile', 'balkan', 'beats', 'bigroom', 'black', 'bluegrass',
           'blues', 'bollywood', 'bossa', 'brazilian', 'breakbeat', 'breaks',
           'broadway', 'cantautori', 'cantopop', 'canzone', 'caribbean',
           'caucasian', 'celtic', 'chamber', 'chanson', 'children', 'chill',
           'chinese', 'choral', 'christian', 'christmas', 'classical',
           'classicmetal', 'club', 'colombian', 'comedy', 'conjazz',
           'contemporary', 'country', 'cuban', 'dance', 'dancehall',
           'dancepop', 'dark', 'death', 'deep', 'deutschrock', 'deutschspr',
           'dirty', 'disco', 'dnb', 'documentary', 'downbeat', 'downtempo',
           'drum', 'dub', 'dubstep', 'eastern', 'easy', 'electronic',
           'electropop', 'emo', 'entehno', 'epicmetal', 'estrada', 'ethnic',
           'eurofolk', 'european', 'experimental', 'extrememetal', 'fado',
           'fairytail', 'film', 'fitness', 'flamenco', 'folk', 'folklore',
           'folkmetal', 'folkrock', 'folktronica', 'forró', 'frankreich',
           'französisch', 'french', 'funk', 'future', 'gangsta', 'garage',
           'german', 'ghazal', 'gitarre', 'glitch', 'gospel', 'gothic',
           'grime', 'grunge', 'gypsy', 'handsup', "hard'n'heavy", 'hardcore',
           'hardstyle', 'hardtechno', 'hiphop', 'historisch', 'holiday',
           'horror', 'house', 'hymn', 'idm', 'independent', 'indian', 'indie',
           'indipop', 'industrial', 'inspirational', 'instrumental',
           'international', 'irish', 'jam', 'japanese', 'jazz', 'jewish',
           'jpop', 'jungle', 'k-pop', 'karadeniz', 'karaoke', 'kayokyoku',
           'korean', 'laiko', 'latin', 'latino', 'leftfield', 'local',
           'lounge', 'loungeelectronic', 'lovers', 'malaysian', 'mandopop',
           'marschmusik', 'meditative', 'mediterranean', 'melodic', 'metal',
           'metalcore', 'mexican', 'middle', 'minimal', 'miscellaneous',
           'modern', 'mood', 'mpb', 'muslim', 'native', 'neoklassik', 'neue',
           'new', 'newage', 'newwave', 'nu', 'nujazz', 'numetal', 'oceania',
           'old', 'opera', 'orchestral', 'other', 'piano', 'podcasts', 'pop',
           'popdance', 'popelectronic', 'popeurodance', 'poprussian', 'post',
           'posthardcore', 'postrock', 'power', 'progmetal', 'progressive',
           'psychedelic', 'punjabi', 'punk', 'quebecois', 'ragga', 'ram',
           'rancheras', 'rap', 'rave', 'reggae', 'reggaeton', 'regional',
           'relax', 'religious', 'retro', 'rhythm', 'rnb', 'rnr', 'rock',
           'rockabilly', 'rockalternative', 'rockindie', 'rockother',
           'romance', 'roots', 'ruspop', 'rusrap', 'rusrock', 'russian',
           'salsa', 'samba', 'scenic', 'schlager', 'self', 'sertanejo',
           'shanson', 'shoegazing', 'showtunes', 'singer', 'ska', 'skarock',
           'slow', 'smooth', 'soft', 'soul', 'soulful', 'sound', 'soundtrack',
           'southern', 'specialty', 'speech', 'spiritual', 'sport',
           'stonerrock', 'surf', 'swing', 'synthpop', 'synthrock',
           'sängerportrait', 'tango', 'tanzorchester', 'taraftar', 'tatar',
           'tech', 'techno', 'teen', 'thrash', 'top', 'traditional',
           'tradjazz', 'trance', 'tribal', 'trip', 'triphop', 'tropical',
           'türk', 'türkçe', 'ukrrock', 'unknown', 'urban', 'uzbek',
           'variété', 'vi', 'videogame', 'vocal', 'western', 'world',
           'worldbeat', 'ïîï', 'электроника'], dtype=object)



**Выводы**

Предобработка обнаружила три проблемы в данных:

- нарушения в стиле заголовков,
- пропущенные значения,
- дубликаты — явные и неявные.

Вы исправили заголовки, чтобы упростить работу с таблицей. Без дубликатов исследование станет более точным.

Пропущенные значения вы заменили на `'unknown'`. Ещё предстоит увидеть, не повредят ли исследованию пропуски в колонке `genre`.

Теперь можно перейти к проверке гипотез. 

## Проверка гипотез

### Сравнение поведения пользователей двух столиц

Первая гипотеза утверждает, что пользователи по-разному слушают музыку в Москве и Санкт-Петербурге. Проверьте это предположение по данным о трёх днях недели — понедельнике, среде и пятнице. Для этого:

* Разделите пользователей Москвы и Санкт-Петербурга.
* Сравните, сколько треков послушала каждая группа пользователей в понедельник, среду и пятницу.

**Задание 18**

Для тренировки сначала выполните каждый из расчётов по отдельности. 

Оцените активность пользователей в каждом городе. Сгруппируйте данные по городу и посчитайте прослушивания в каждой группе.


```python
# Подсчёт прослушиваний в каждом городе
df.groupby('city')['user_id'].count()
```




    city
    Moscow              42741
    Saint-Petersburg    18512
    Name: user_id, dtype: int64



В Москве прослушиваний больше, чем в Петербурге. Из этого не следует, что московские пользователи чаще слушают музыку. Просто самих пользователей в Москве больше.

**Задание 19**

Теперь сгруппируйте данные по дню недели и посчитайте прослушивания в понедельник, среду и пятницу. Учтите, что в данных есть информация о прослушиваниях только за эти дни.


```python
# Подсчёт прослушиваний в каждый из трёх дней
df.groupby('day')['user_id'].count()
```




    day
    Friday       21840
    Monday       21354
    Wednesday    18059
    Name: user_id, dtype: int64



В среднем пользователи из двух городов менее активны по средам. Но картина может измениться, если рассмотреть каждый город в отдельности.

**Задание 20**


Вы видели, как работает группировка по городу и по дням недели. Теперь напишите функцию, которая объединит два эти расчёта.

Создайте функцию `number_tracks()`, которая посчитает прослушивания для заданного дня и города. Ей понадобятся два параметра:
* день недели,
* название города.

В функции сохраните в переменную строки исходной таблицы, у которых значение:
  * в колонке `day` равно параметру `day`,
  * в колонке `city` равно параметру `city`.

Для этого примените последовательную фильтрацию с логической индексацией (или сложные логические выражения в одну строку, если вы уже знакомы с ними).

Затем посчитайте значения в столбце `user_id` получившейся таблицы. Результат сохраните в новую переменную. Верните эту переменную из функции.


```python
# <создание функции number_tracks()>
# Объявляется функция с двумя параметрами: day, city
def number_tracks(day, city): 
# В переменной track_list сохраняются те строки таблицы df, для которых 
# значение в столбце 'day' равно параметру day и одновременно значение
# в столбце 'city' равно параметру city (используйте последовательную фильтрацию
# с помощью логической индексации или сложные логические выражения в одну строку, если вы уже знакомы с ними).
    track_list = df[(df['day'] == day) & (df['city'] == city)]

# В переменной track_list_count сохраняется число значений столбца 'user_id',
# рассчитанное методом count() для таблицы track_list.
    track_list_count = track_list['user_id'].count()
# Функция возвращает число - значение track_list_count.
    return track_list_count
# Функция для подсчёта прослушиваний для конкретного города и дня.
# С помощью последовательной фильтрации с логической индексацией она 
# сначала получит из исходной таблицы строки с нужным днём,
# затем из результата отфильтрует строки с нужным городом,
# методом count() посчитает количество значений в колонке user_id. 
# Это количество функция вернёт в качестве результата
```

**Задание 21**

Вызовите `number_tracks()` шесть раз, меняя значение параметров — так, чтобы получить данные для каждого города в каждый из трёх дней.


```python
# количество прослушиваний в Москве по понедельникам
number_tracks('Monday', 'Moscow')
```




    15740




```python
# количество прослушиваний в Санкт-Петербурге по понедельникам
number_tracks('Monday', 'Saint-Petersburg')
```




    5614




```python
# количество прослушиваний в Москве по средам
number_tracks('Wednesday', 'Moscow')
```




    11056




```python
# количество прослушиваний в Санкт-Петербурге по средам
number_tracks('Wednesday', 'Saint-Petersburg')
```




    7003




```python
# количество прослушиваний в Москве по пятницам
number_tracks('Friday', 'Moscow')
```




    15945




```python
# количество прослушиваний в Санкт-Петербурге по пятницам
number_tracks('Friday', 'Saint-Petersburg')
```




    5895



**Задание 22**

Создайте c помощью конструктора `pd.DataFrame` таблицу, где
* названия колонок — `['city', 'monday', 'wednesday', 'friday']`;
* данные — результаты, которые вы получили с помощью `number_tracks`.


```python
# Таблица с результатами
data = [['Moscow', 15740, 11056, 15945], ['Saint-Petersburg', 5614, 7003, 5895]]
columns = ['city', 'monday', 'wednesday', 'friday']
table = pd.DataFrame(data=data, columns=columns)
table
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
      <th>city</th>
      <th>monday</th>
      <th>wednesday</th>
      <th>friday</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Moscow</td>
      <td>15740</td>
      <td>11056</td>
      <td>15945</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Saint-Petersburg</td>
      <td>5614</td>
      <td>7003</td>
      <td>5895</td>
    </tr>
  </tbody>
</table>
</div>



**Выводы**

Данные показывают разницу поведения пользователей:

- В Москве пик прослушиваний приходится на понедельник и пятницу, а в среду заметен спад.
- В Петербурге, наоборот, больше слушают музыку по средам. Активность в понедельник и пятницу здесь почти в равной мере уступает среде.

Значит, данные говорят в пользу первой гипотезы.

### Музыка в начале и в конце недели

Согласно второй гипотезе, утром в понедельник в Москве преобладают одни жанры, а в Петербурге — другие. Так же и вечером пятницы преобладают разные жанры — в зависимости от города.

**Задание 23**

Сохраните таблицы с данными в две переменные:
* по Москве — в `moscow_general`;
* по Санкт-Петербургу — в `spb_general`.


```python
# получение таблицы moscow_general из тех строк таблицы df, 
# для которых значение в столбце 'city' равно 'Moscow'
moscow_general = df[df['city'] == 'Moscow']
```


```python
# получение таблицы spb_general из тех строк таблицы df,
# для которых значение в столбце 'city' равно 'Saint-Petersburg'
spb_general = df[df['city'] == 'Saint-Petersburg']
```

**Задание 24**

Создайте функцию `genre_weekday()` с четырьмя параметрами:
* таблица (датафрейм) с данными,
* день недели,
* начальная временная метка в формате 'hh:mm', 
* последняя временная метка в формате 'hh:mm'.

Функция должна вернуть информацию о топ-10 жанров тех треков, которые прослушивали в указанный день, в промежутке между двумя отметками времени.


```python
# Объявление функции genre_weekday() с параметрами table, day, time1, time2,
# которая возвращает информацию о самых популярных жанрах в указанный день в
# заданное время:
#def genre_weekday(table, day, time1, time2):

#1) в переменную genre_df сохраняются те строки переданного датафрейма table, для
#    которых одновременно:
#    - значение в столбце day равно значению аргумента day
#    - значение в столбце time больше значения аргумента time1
#    - значение в столбце time меньше значения аргумента time2
#    Используйте последовательную фильтрацию с помощью логической индексации.
#genre_df = df[(df['day'] == day) & (df['time'] > time1) & (df['time'] < time2)]     
# 2) сгруппировать датафрейм genre_df по столбцу genre, взять один из его
#    столбцов и посчитать методом count() количество записей для каждого из
#    присутствующих жанров, получившийся Series записать в переменную
#    genre_df_count
#genre_df_count = genre_df['genre'].count()
# 3) отсортировать genre_df_count по убыванию встречаемости и сохранить
#    в переменную genre_df_sorted
 # 4) вернуть Series из 10 первых значений genre_df_sorted, это будут топ-10
#    популярных жанров (в указанный день, в заданное время)
#genre_df_sorted = genre_df_count('genre')['genre'].sort_values(ascending=False).head(10)
    

#Для фильтрации датафрейма воспользуйтесь последовательной логической индексацией или сложными логическими выражениями pandas, если вы уже с ними знакомы. Вам также понадобится группировка и сортировка значений:
def genre_weekday(df, day, time1, time2):
    # последовательная фильтрация
    # оставляем в genre_df только те строки df, у которых день равен day
    genre_df = df[df['day'] == day]
    # оставляем в genre_df только те строки genre_df, у которых время меньше time2
    genre_df = genre_df[genre_df['time'] < time2]
    # оставляем в genre_df только те строки genre_df, у которых время больше time1
    genre_df = genre_df[genre_df['time'] > time1]
    # сгруппируем отфильтрованный датафрейм по столбцу с названиями жанров, возьмём столбец genre и посчитаем кол-во строк для каждого жанра методом count()
    genre_df_grouped = genre_df.groupby('genre')['genre'].count()
    # отсортируем результат по убыванию (чтобы в начале Series оказались самые популярные жанры)
    genre_df_sorted = genre_df_grouped.sort_values(ascending=False)
    # вернём Series с 10 самыми популярными жанрами в указанный отрезок времени заданного дня
    return genre_df_sorted[:10] 
```

**Задание 25**


Cравните результаты функции `genre_weekday()` для Москвы и Санкт-Петербурга в понедельник утром (с 7:00 до 11:00) и в пятницу вечером (с 17:00 до 23:00):


```python
# вызов функции для утра понедельника в Москве (вместо df — таблица moscow_general)
# объекты, хранящие время, являются строками и сравниваются как строки
# пример вызова: genre_weekday(moscow_general, 'Monday', '07:00', '11:00')
genre_weekday(moscow_general, 'Monday', '07:00', '11:00')
```




    genre
    pop            781
    dance          549
    electronic     480
    rock           474
    hiphop         286
    ruspop         186
    world          181
    rusrap         175
    alternative    164
    unknown        161
    Name: genre, dtype: int64




```python
# вызов функции для утра понедельника в Петербурге (вместо df — таблица spb_general)
genre_weekday(spb_general, 'Monday', '07:00', '11:00')
```




    genre
    pop            218
    dance          182
    rock           162
    electronic     147
    hiphop          80
    ruspop          64
    alternative     58
    rusrap          55
    jazz            44
    classical       40
    Name: genre, dtype: int64




```python
# вызов функции для вечера пятницы в Москве
genre_weekday(moscow_general, 'Friday', '17:00', '23:00')
```




    genre
    pop            713
    rock           517
    dance          495
    electronic     482
    hiphop         273
    world          208
    ruspop         170
    alternative    163
    classical      163
    rusrap         142
    Name: genre, dtype: int64




```python
# вызов функции для вечера пятницы в Петербурге
genre_weekday(spb_general, 'Friday', '17:00', '23:00')
```




    genre
    pop            256
    electronic     216
    rock           216
    dance          210
    hiphop          97
    alternative     63
    jazz            61
    classical       60
    rusrap          59
    world           54
    Name: genre, dtype: int64



**Выводы**

Если сравнить топ-10 жанров в понедельник утром, можно сделать такие выводы:

1. В Москве и Петербурге слушают похожую музыку. Единственное отличие — в московский рейтинг вошёл жанр “world”, а в петербургский — джаз и классика.

2. В Москве пропущенных значений оказалось так много, что значение `'unknown'` заняло десятое место среди самых популярных жанров. Значит, пропущенные значения занимают существенную долю в данных и угрожают достоверности исследования.

Вечер пятницы не меняет эту картину. Некоторые жанры поднимаются немного выше, другие спускаются, но в целом топ-10 остаётся тем же самым.

Таким образом, вторая гипотеза подтвердилась лишь частично:
* Пользователи слушают похожую музыку в начале недели и в конце.
* Разница между Москвой и Петербургом не слишком выражена. В Москве чаще слушают русскую популярную музыку, в Петербурге — джаз.

Однако пропуски в данных ставят под сомнение этот результат. В Москве их так много, что рейтинг топ-10 мог бы выглядеть иначе, если бы не утерянные  данные о жанрах.

### Жанровые предпочтения в Москве и Петербурге

Гипотеза: Петербург — столица рэпа, музыку этого жанра там слушают чаще, чем в Москве.  А Москва — город контрастов, в котором, тем не менее, преобладает поп-музыка.

**Задание 26**

Сгруппируйте таблицу `moscow_general` по жанру и посчитайте прослушивания треков каждого жанра методом `count()`. Затем отсортируйте результат в порядке убывания и сохраните его в таблице `moscow_genres`.


```python
# одной строкой: группировка таблицы moscow_general по столбцу 'genre', 
# подсчёт числа значений 'genre' в этой группировке методом count(), 
# сортировка получившегося Series в порядке убывания и сохранение в moscow_genres
moscow_genres = moscow_general.groupby('genre')['genre'].count().sort_values(ascending=False)
```

**Задание 27**

Выведите на экран первые десять строк `moscow_genres`:


```python
# просмотр первых 10 строк moscow_genres
moscow_genres.head(10)
```




    genre
    pop            5892
    dance          4435
    rock           3965
    electronic     3786
    hiphop         2096
    classical      1616
    world          1432
    alternative    1379
    ruspop         1372
    rusrap         1161
    Name: genre, dtype: int64



**Задание 28**


Теперь повторите то же и для Петербурга.

Сгруппируйте таблицу `spb_general` по жанру. Посчитайте прослушивания треков каждого жанра. Результат отсортируйте в порядке убывания и сохраните в таблице `spb_genres`:


```python
# одной строкой: группировка таблицы spb_general по столбцу 'genre', 
# подсчёт числа значений 'genre' в этой группировке методом count(), 
# сортировка получившегося Series в порядке убывания и сохранение в spb_genres
spb_genres = spb_general.groupby('genre')['genre'].count().sort_values(ascending=False)
```

**Задание 29**

Выведите на экран первые десять строк `spb_genres`:


```python
# просмотр первых 10 строк spb_genres
spb_genres.head(10)
```




    genre
    pop            2431
    dance          1932
    rock           1879
    electronic     1736
    hiphop          960
    alternative     649
    classical       646
    rusrap          564
    ruspop          538
    world           515
    Name: genre, dtype: int64



**Выводы**

Гипотеза частично подтвердилась:
* Поп-музыка — самый популярный жанр в Москве, как и предполагала гипотеза. Более того, в топ-10 жанров встречается близкий жанр — русская популярная музыка.
* Вопреки ожиданиям, рэп одинаково популярен в Москве и Петербурге. 

Этап 4. Результаты исследования Рабочие гипотезы:

музыку в двух городах — Москве и Санкт-Петербурге — слушают в разном режиме;

списки десяти самых популярных жанров утром в понедельник и вечером в пятницу имеют характерные отличия;

население двух городов предпочитает разные музыкальные жанры.

Общие результаты

Москва и Петербург сходятся во вкусах: везде преобладает популярная музыка. При этом зависимости предпочтений от дня недели в каждом отдельном городе нет — люди постоянно слушают то, что им нравится. Но между городами в разрезе дней неделей наблюдается зеркальность относительно среды: Москва больше слушает в понедельник и пятницу, а Петербург наоборот - больше в среду, но меньше в понедельник и пятницу.

## Итоги исследования

Вы проверили три гипотезы и установили:

1. День недели по-разному влияет на активность пользователей в Москве и Петербурге. 

Первая гипотеза полностью подтвердилась.

2. Музыкальные предпочтения не сильно меняются в течение недели — будь то Москва или Петербург. Небольшие различия заметны в начале недели, по понедельникам:
* в Москве слушают музыку жанра “world”,
* в Петербурге — джаз и классику.

Таким образом, вторая гипотеза подтвердилась лишь отчасти. Этот результат мог оказаться иным, если бы не пропуски в данных.

3. Во вкусах пользователей Москвы и Петербурга больше общего чем различий. Вопреки ожиданиям, предпочтения жанров в Петербурге напоминают московские.

Третья гипотеза не подтвердилась. Если различия в предпочтениях и существуют, на основной массе пользователей они незаметны.
