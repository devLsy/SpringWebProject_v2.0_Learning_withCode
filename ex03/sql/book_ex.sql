SELECT rno, bno, reply, replyer, replydate, updatedate
FROM
    (
        SELECT /*+INDEX(tbl_reply idx_reply) */
            rownum rn, bno, rno, reply, replyer, replyDate, updatedate
        FROM tbl_reply
            WHERE bno = 4194362 AND rno > 0 AND rownum <= 20
    )      
WHERE rn > 10;