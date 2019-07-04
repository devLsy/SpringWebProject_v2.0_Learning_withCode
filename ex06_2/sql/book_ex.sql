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
      
SELECT * FROM tbl_attach ORDER BY bno desc;

--게시글, 파일 목록 조인 조회
SELECT
    A.bno, A.title, A.content, A.writer, A.regdate, A.updatedate, A.replycnt, B.uuid, B.uploadpath, B.filename, B.filetype
FROM tbl_board A
LEFT OUTER JOIN tbl_attach B ON A.bno = B.bno 
ORDER BY bno desc;
        
select /*+INDEX_DESC(tbl_board pk_board) */
        rownum rn, bno, title, content, writer, regdate, updatedate, replycnt 
      from 
        tbl_board
    ORDER BY bno desc;  
                
SELECT * FROM tbl_attach WHERE uploadpath = to_char(sysdate -1, 'yyyy\mm\dd');              

SELECT * FROM tbl_member;

SELECT userid username, userpw password, enabled
FROM tbl_member 
	WHERE userid = 'admin90';
    
SELECT mem.userid, userpw, username, enabled, regdate, updatedate, auth
  			FROM 
  		tbl_member mem LEFT OUTER JOIN tbl_member_auth auth on mem.userid = auth.userid;

SELECT * FROM persistent_logins;

    

             