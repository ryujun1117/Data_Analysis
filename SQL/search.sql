
--1. Shohinテーブルから3つの列を出力
select shohin_id, shohin_mei, shiire_tanka
from shop.Shohin;

--2. 全ての列を出力(アスタリスクは全列を意味する)
select * from shop.Shohin;

--3. 列に別名をつける
select
    shohin_id as id,
    shohin_mei as namae,
    shiire_tanka as tanka
from shop.Shohin;

--4. 日本語で列に別名をつける
--BigQueryでは、列の別名を指定する際にはダブルクォーテーション (") ではなくバッククォート ()) を使用する必要があります。
select
    shohin_id as `商品ID`,
    shohin_mei as `商品名`,
    shiire_tanka as `仕入単価`
from shop.Shohin;

--5. 定数の出力（定数を他の列を一緒に出力する）
select
    '商品' as mojiretsu,
    38 as kazu,
    '2009-02-24' as hizuke,
    shohin_id,
    shohin_mei
from shop.Shohin;

--6. distinctを使って、shohin_bunrui列を重複を省いた形で出力(NULLは消えない)
select distinct shohin_bunrui
from shop.Shohin;

--7. 複数の列の前にdistinctを置いた場合
select distinct shohin_bunrui, torokubi
from shop.Shohin;

--8. 商品分類が衣服の行を選択する（where句は必ずfrom句の直後に書く）
select shohin_mei, shohin_bunrui
from shop.Shohin
where shohin_bunrui = '衣類';

--9.
