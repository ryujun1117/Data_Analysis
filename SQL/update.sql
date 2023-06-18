/*
  データの登録（insert）
  データの削除（delete）
  データの更新（update）
  トランザクション
*/

/*
  ACID特性
    - 原子性（Atomicity）
    - 一貫性（Consistency）
    - 独立性（Isolation）
    - 永続性（Durability）
*/

-- insert学習用にShohinInsテーブルを作成する
/*
create table shop.ShohinIns
(
  shohin_id STRING NOT NULL,
  shohin_mei STRING(100) NOT NULL,
  shohin_bunrui STRING(32) NOT NULL,
  hanbai_tanka INTEGER,
  shiire_tanka INTEGER,
  torokubi DATE
);
begin transaction;
insert into shop.ShohinIns values('0001', 'Tシャツ', '衣服', 1000, 500, '2009-09-20');
insert into shop.ShohinIns values('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
insert into shop.ShohinIns values('0003', 'カッターシャツ', '衣類', 4000, 2800, NULL);
insert into shop.ShohinIns values('0004', '包丁', 'キッチン用品', 3000, 2800, '2009-09-20');
insert into shop.ShohinIns values('0005', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-25');
insert into shop.ShohinIns values('0006', 'フォーク', 'キッチン用品', 500, NULL, '2009-09-20');
insert into shop.ShohinIns values('0007', 'おろしがね', 'キッチン用品', 880, 790, '2008-04-28');
insert into shop.ShohinIns values('0008', 'ボールペン', '事務用品', 100, NULL, '2009-11-11');
commit;
*/

-- 原則、insert文は1回の実行で1行を実行する
--1. insert 列リストあり
insert into shop.ShohinIns(shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
values('0005', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15');

--2. insert 列リストなし
insert into shop.ShohinIns values('00051', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15');

--3. shiire_tanka列にNULLを割り当てる
insert into shop.ShohinIns values('0006', 'フォーク', 'キッチン用品', 500, NULL, '2009-09-20');

--4. create table時にデフォルト値を設定しておけば明示的にinsertできる

--5. ShohinInsテーブルを空っぽにする（truncateコマンドも同様の動作）
delete from shop.ShohinIns;

--6. 販売単価が4000円以上の行だけを削除
delete from shop.ShohinIns
where hanbai_tanka >= 4000;

--7. 登録日を全て2019-10-10に変更 ※where文がないとエラーするので無理やり指定
update shop.ShohinIns
set torokubi = '2009-10-10'
where shohin_id is not null;

--8. 商品分類がキッチン用品の行のみ販売単価を10倍に変更
update shop.ShohinIns
set hanbai_tanka = hanbai_tanka * 1000
where shohin_bunrui = 'キッチン用品';

--9. updateでnullクリア -> 列をnullで更新すること
update shop.ShohinIns
set torokubi = NULL
where shohin_id = '0006';

--10. トランザクション
start transaction;
-- カッターシャツの販売単価を1000円値引き
update shop.ShohinIns
set hanbai_tanka = hanbai_tanka - 1000
where shohin_mei = 'カッターシャツ';

update shop.ShohinIns
set hanbai_tanka = hanbai_tanka + 1000
where shohin_mei = 'Tシャツ';
commit; -- rollback; することで元にもどせる。確認時に有用

-- 変更内容の確認
select * from shop.ShohinIns order by shohin_id;









