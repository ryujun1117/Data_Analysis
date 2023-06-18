
--1. SQL文で計算式を書く
select shohin_mei, hanbai_tanka, hanbai_tanka * 2 as `hanbai_tanka_x2`
from shop.Shohin;

--2. hanbai_tanka列が500の行を選択
select shohin_mei, shohin_bunrui
from shop.Shohin
where hanbai_tanka = 500;

--3. hanbai_tanka列が500ではない行を選択
select shohin_mei, shohin_bunrui
from shop.Shohin
where hanbai_tanka <> 500;

--4. 販売単価が1000円以上の行を選択
select shohin_mei, shohin_bunrui, hanbai_tanka
from shop.Shohin
where hanbai_tanka >= 1000;

--5. 登録日が2009年9月27日より前の行を選択
select shohin_mei, shohin_bunrui, torokubi
from shop.Shohin
where torokubi < '2009-09-27';

--6. where句の条件式にも計算式を書ける
select shohin_mei, hanbai_tanka, shiire_tanka
from shop.Shohin
where hanbai_tanka - shiire_tanka >= 500;

--7. nullに比較演算子は使えない（フォークとボールペンは仕入単価がnull）
select shohin_mei, shiire_tanka
from shop.Shohin
where shiire_tanka <> 2800;

--8. まちがったselect文（1行も選択されない）
-- select shohin_mei, shiire_tanka
--   from shop.Shohin
--   where shiire_tanka = NULL;

--9. NULLである行を選択
select shohin_mei, shiire_tanka
from shop.Shohin
where shiire_tanka is null;

--10. NULLではない行を選択
select shohin_mei, shiire_tanka
from shop.Shohin
where shiire_tanka is not null;

--11. NOT演算子
select shohin_mei, shohin_bunrui, hanbai_tanka
from shop.Shohin
where not hanbai_tanka >= 1000;

--12. where句の検索条件にand演算を使った検索
select shohin_mei, shiire_tanka
from shop.Shohin
where shohin_bunrui = 'キッチン用品'
  and hanbai_tanka >= 3000;

--13. where句の検索条件にor演算子を使った検索
select shohin_mei, shiire_tanka
from shop.Shohin
where shohin_bunrui = 'キッチン用品'
   or hanbai_tanka >= 3000;

--14. 「商品分類が事務用品」かつ「登録日が2009年9月11日または2009年9月20日」
--カッコでAND演算子よりOR演算子を優先させる
select shohin_mei, shohin_bunrui, torokubi
from shop.Shohin
where shohin_bunrui ='事務用品'
  and (
            torokubi = '2009-09-11'
        or
            torokubi = '2009-09-20'
    );






