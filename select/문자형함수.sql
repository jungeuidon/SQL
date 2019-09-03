-- upper, ucase
-- 1. 자바 upperCase 보다 DB의 upper() 함수가 훨씬 빠르다.
-- 2. 웬만한 DB에서 문자열 처리 뿐만 아니라 포맷팅 처리등을 다해주고 자바에서 출력만 해결한다
-- 3. 자바코드가 간결해서 좋다.

select upper('Seoul'), ucase('seoul');
select upper(first_name) from employees;

-- lower, lcase
select lower('SEOUL'), lcase('GanGNAM');


-- 문자열 자르기  
-- substring ()
select substring('Happy DAy', 5,3);   -- y D    공백도 가져온다.
select first_name, substr(hire_date,1,4)as 입사년도 from employees;

-- lpad, rpad 떨어뜨리기. 
select lpad('1234', 10, '0');
select rpad('1234', 10, '0');

-- ex1) salaries 테이블에서 2001년 급여가 70000뷸 이하의 직원만 사번, 급여로 출력하되
-- 급여는 10자리로 부족한 자릿수는 * 로 표시
select emp_no as 사번, rpad(cast(salary as char),10,'*') from salaries where from_date like '2001%' and salary <70000;

-- ltrim, rtrim, trim     스페이스바 지우기
select ltrim('    hello *'), rtrim('*        hello       ');
select concat('----',ltrim('    hello    '), '----') as LTRIM,
 concat('----',rtrim('    hello    '), '----') as RTRIM,
 concat('----',trim('    hello    '), '----') as TRIM,
 concat('----',trim('xxxxxxxhelloxxxxx'), '----') as TRIM,
 concat('----',trim(both 'x' from 'xxxxxxxhelloxxxxx'), '----') as both문자fromTRIM,
 concat('----',trim(leading 'x' from 'xxxxxxxhelloxxxxx'), '----') as leading문자fromTRIM,
 concat('----',trim(trailing 'x' from 'xxxxxxxhelloxxxxx'), '----') as trailing문자fromTRIM;
