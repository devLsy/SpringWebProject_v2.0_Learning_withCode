select 
    bno, title, content, writer, regdate, updatedate, replycnt
  from 
      (
      select /*+INDEX_DESC(tbl_board pk_board) */
        rownum rn, bno, title, content, writer, regdate, updatedate, replycnt 
      from 
        tbl_board)
      where ROWNUM <= 20 
      ORDER BY bno desc;
      
SELECT * FROM tbl_attach;