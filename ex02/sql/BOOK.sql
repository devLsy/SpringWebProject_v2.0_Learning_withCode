SELECT /*+ INDEX_DESC(tbl_board pk_board) */
    rownum rn, bno, title, content 
FROM tbl_board
    WHERE rownum <= 20;
    

-- �ζ��� �� ����
SELECT
    bno, title, content
FROM 
    (
    SELECT /*+ INDEX_DESC(tbl_board pk_board)*/
        rownum rn, bno, title, content
    FROM 
        tbl_board
    WHERE rownum <= 10
    )
WHERE rn > 10;