select /*+INDEX_DESC(tbl_board pk_board) */
        rownum rn, bno, title, content, writer, regdate, updatedate 
      from 
        tbl_board;
        
------------------------------------------------------------------------------
SELECT * FROM tbl_board
    WHERE rownum < 10 
        ORDER BY bno desc;
        
------------------------------------------------------------------------------
SELECT * FROM tbl_reply ORDER BY rno desc;