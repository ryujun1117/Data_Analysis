-- 変換のソースとなったクエリ
--
-- CREATE VOLATILE TABLE exampleTable (age INT, gender VARCHAR(10));
-- INS INTO exampleTable (10, 'F');
-- INS INTO exampleTable (20, 'M');
--
-- SEL *
-- FROM exampleTable
-- WHERE gender EQ 'F'
-- AND age LT 15;

CREATE TEMPORARY TABLE exampletable
(
  age INT64,
  gender STRING
)
;
INSERT INTO exampletable (age, gender)
VALUES (10, 'F')
;
INSERT INTO exampletable (age, gender)
VALUES (20, 'M')
;
SELECT
    exampletable.*
FROM
    exampletable
WHERE upper(exampletable.gender) = 'F'
  AND exampletable.age < 15
;
