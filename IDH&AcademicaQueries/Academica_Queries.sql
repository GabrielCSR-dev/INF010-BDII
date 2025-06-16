-- - Gerar um relatório com todos os departamentos, professores, turmas e média das notas dos alunos em cada turma entre 2006 a 2010.

-- Updating takes table to include numeric grades

CREATE TABLE grade
	(ID INT,
	letter_grade VARCHAR(2),
	numeric_grade NUMERIC(4,2),
	CONSTRAINT pk_grade PRIMARY KEY (ID));

insert into grade values
(0,'F',0.),
(1,'E-', 10./15.),
(2,'E ',10./15.*2),
(3,'E+',10./15.*3),
(4,'D-',10./15.*4),
(5,'D ',10./15.*5),
(6,'D+',10./15.*6),
(7,'C-',10./15.*7),
(8,'C ',10./15.*8),
(9,'C+',10./15.*9),
(10,'B-',10./15.*10),
(11,'B ',10./15.*11),
(12,'B+',10./15.*12),
(13,'A-',10./15.*13),
(14,'A ',10./15.*14),
(15,'A+',10.);

select * from grade;

ALTER TABLE TAKES
ADD COLUMN numeric_grade numeric(4,2);

UPDATE TAKES AS T
SET numeric_grade = G.numeric_grade
FROM GRADE AS G
WHERE T.grade = G.letter_grade;

SELECT DISTINCT grade, numeric_grade FROM TAKES;

-- Query

EXPLAIN ANALYZE
WITH TAB1 AS
(SELECT S.course_id, S.sec_id, S.semester, S.year, AVG(T.numeric_grade) As grade_avg FROM SECTION AS S
	INNER JOIN TAKES AS T
		ON((S.course_id, S.sec_id, S.semester) = (T.course_id, T.sec_id, T.semester))
WHERE S.year >= 2006 AND S.year <= 2010
GROUP BY S.course_id, S.sec_id, S.semester, S.year)
SELECT I.dept_name, I.name, TAB1.course_id, TAB1.sec_id, TAB1.semester, TAB1.year, TAB1.grade_avg FROM TAB1
	INNER JOIN TEACHES AS TE
		ON((TAB1.course_id, TAB1.sec_id, TAB1.semester, TAB1.year) = (TE.course_id, TE.sec_id, TE.semester, TE.year))
	INNER JOIN INSTRUCTOR AS I
		ON(I.ID = TE.ID);


-- - Gerar relatório com nome do aluno, disciplinas cursadas com respectivos professores das turmas e notas e respectivo departamento dos professores
EXPLAIN ANALYZE
WITH TAB1 AS
(
SELECT C.title, I.name, I.dept_name, SE.course_id, SE.sec_id, SE.semester, SE.year FROM SECTION AS SE
	INNER JOIN COURSE AS C 
		ON(SE.course_Id = C.course_Id)
	INNER JOIN TEACHES AS TE 
		ON((TE.course_id, TE.sec_id, TE.semester, TE.year) = (SE.course_id, SE.sec_id, SE.semester, SE.year))
	INNER JOIN INSTRUCTOR AS I 
		ON(I.ID = TE.ID)
	ORDER BY SE.course_id, SE.sec_id, SE.semester, SE.year
)
SELECT S.name, TAB1.title, T.numeric_grade, TAB1.name, TAB1.dept_name FROM TAB1
	INNER JOIN TAKES AS T
		ON((T.course_id, T.sec_id, T.semester, T.year) = (TAB1.course_id, TAB1.sec_id, TAB1.semester, TAB1.year))
	INNER JOIN STUDENT AS S 
		ON(T.ID = S.ID);	

EXPLAIN ANALYZE
WITH TAB1 AS
(
SELECT C.title, I.name, I.dept_name, SE.course_id, SE.sec_id, SE.semester, SE.year FROM SECTION AS SE
	INNER JOIN COURSE AS C 
		ON(SE.course_Id = C.course_Id)
	INNER JOIN TEACHES AS TE 
		ON((TE.course_id, TE.sec_id, TE.semester, TE.year) = (SE.course_id, SE.sec_id, SE.semester, SE.year))
	INNER JOIN INSTRUCTOR AS I 
		ON(I.ID = TE.ID)
)
SELECT S.name, TAB1.title, T.numeric_grade, TAB1.name, TAB1.dept_name FROM TAB1
	INNER JOIN TAKES AS T
		ON((T.course_id, T.sec_id, T.semester, T.year) = (TAB1.course_id, TAB1.sec_id, TAB1.semester, TAB1.year))
	INNER JOIN STUDENT AS S 
		ON(T.ID = S.ID);
