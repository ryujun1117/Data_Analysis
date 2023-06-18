/*
テーブルを集約して検索する
テーブルをグループに切り分ける
集約した結果に条件を指定する
検索結果を並び替える
*/

--1. 全行を数える
select count(*)
from shop.Shohin;

--2. NULLを除外して数える
select count(shiire_tanka)
from shop.Shohin;

--3. 販売単価の合計を求める
select sum(hanbai_tanka)
from shop.Shohin;

--4. 販売単価と仕入単価の合計を求める（NULLは計算式に入らず、無視される）
select sum(hanbai_tanka), sum(shiire_tanka)
from shop.Shohin;

--5. 平均値を求める
select avg(hanbai_tanka)
from shop.Shohin;


--6. 販売単価と仕入単価の平均値を求める
select avg(hanbai_tanka), avg(shiire_tanka)
from shop.Shohin;

--7. 最大値・最小値を求める
select max(torokubi), min(torokubi)
from shop.Shohin;

--8. 値の重複を除いて行数を数える
select count(distinct shohin_bunrui)
from shop.Shohin;

--9. group by句による集約
select shohin_bunrui, count(*)
from shop.Shohin
group by shohin_bunrui;

--10. 仕入単価ごとの行数を数える（nullが含まれる場合、結果にも不明として現れる）
select shiire_tanka, count(*)
from shop.Shohin
group by shiire_tanka;

--11. where句とgroup by句の併用（group by句にselect句でつけた別名は使えない）
select shiire_tanka, count(*)
from shop.Shohin
where shohin_bunrui = '衣服'
group by shiire_tanka;

--12. 集約した結果に条件を指定する
select shohin_bunrui, count(*)
from shop.Shohin
group by shohin_bunrui
having count(*) = 2;

--13. 集約した結果に条件を指定する２
select shohin_bunrui, avg(hanbai_tanka)
from shop.Shohin
group by shohin_bunrui
having avg(hanbai_tanka) >= 2500;

-- having句よりwhere句の方が、より実行速度が速い

--14. 検索結果を並べる（販売単価の低い順に並べる）
select shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
from shop.Shohin
order by hanbai_tanka;

--15. 販売単価の高い順（降順）に並べる
select shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
from shop.Shohin
order by hanbai_tanka desc;

--16. 複数のソートキーを指定する
select shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
from shop.Shohin
order by hanbai_tanka, shohin_id;


--17. 仕入単価を昇順に並べる→ NULLは先頭か末尾にまとめられる（BigQueryでは先頭に来た）
select shohin_id, shohin_mei, hanbai_tanka , shiire_tanka
from shop.Shohin
order by shiire_tanka asc;

/*
  select文の内部的な実行順序についてのまとめ
  from -> where -> group by -> having -> select -> order by
*/

--18. 集約関数もorder by句で利用可能
select shohin_bunrui, count(*)
from shop.Shohin
group by shohin_bunrui
order by count(*);

-- 注意：order by句で列番号は使わない！
