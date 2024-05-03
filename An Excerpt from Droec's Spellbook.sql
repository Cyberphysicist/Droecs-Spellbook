/*
Miller,Jonathan. "Exerpt from Droec's Spellbook," Telicom 35,no. 2 (July-September 2023):82.

Poetic expression of a SQL query designed to visualize person to person connections in a network diagram.

*/

/*
Oh, Revers! I, Droec, seek your guidance! See my heart and grant me your discretion!

I seek to know those brought together by place. I seek Connection!

In your right hand, hold before you all the earth.

With your left, bind to the earth memories of man’s travels therein.

With your left, bind to your memories the souls of those remembered.

And draw into your cup your memories, now tied to earth and men.

Take your cup and place it before a looking glass, and draw from that glass its twin.

With your left hand, bind the earths of the cup and twin.

Now draw the pairs:

In the first, should the soul of the former shine as bright as or brighter than the latter, draw out the former.

In the first, should the soul of the later shine as bright as or brighter than the former, draw out the latter.

In the second, should the soul of the former shine as bright as or brighter than the latter, draw out the latter.

In the second, should the soul of the latter shine as bright as or brighter than the former, draw out the former.

And should any of the first and second match another pair, draw but one pair. And place the whole in my hands.

Grant me connection! And empty your cup!
*/
/*Connect to Server*/
--Server Name: Revers
--User Name: Droec
--Password: my_heart
  
/*Table Formats*/
--place: [place_id, place_name]
--place_person: [place_id, person_id]
--person: [person_id, person_name]
  
/*Execute*/
DECLARE @CONNECTION TABLE (p1 NVARCHAR(MAX), p2 NVARCHAR(MAX))
  
SELECT pl.place_id, pl.place_name, pr.person_id, pr.person_name
INTO #CUP
FROM place pl
LEFT JOIN place_person pp ON pl.place_id = pp.place_id
LEFT JOIN person pr ON pp.person_id = pr.person_id
  
INSERT INTO @CONNECTION
SELECT DISTINCT CASE WHEN a.person_id >= b.person_id 
                     THEN a.person_id 
                     ELSE b.person_id 
                END AS ‘p1’, 
                CASE WHEN a.person_id >= b.person_id 
                     THEN b.person_id 
                     ELSE a.person_id 
                END AS ‘p2’
FROM #CUP a
LEFT JOIN #CUP b ON a. place_id = b. place_id
  
SELECT c.*
FROM @CONNECTION c
  
DROP TABLE #CUP
/**/
