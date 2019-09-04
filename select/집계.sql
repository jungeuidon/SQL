select avg(salary), sum(salary)
  from salaries
 where emp_no='10060'; 
 
  select emp_no, avg(salary), sum(salary)
	from salaries
   where to_date='9999-01-01'
group by emp_no
  having avg(salary) > 40000
order by avg(salary) asc;  

-- ex1) 각 사원별로 평균연봉 출력
  select emp_no, avg(salary)
    from salaries
group by emp_no
order by avg(salary) desc;

-- ex2 [과제]각 현재 Manager 직책 사원에 대한 평균 연봉은?
select avg(a.salary)
  from salaries a, titles b
 where a.emp_no = b.emp_no        -- 조인조건
   and a.to_date = '9999-01-01'   -- row 선택조건1 
   and b.to_date = '9999-01-01'   -- row 선택조건2
   and b.title = 'Manager';       -- row 선택조건3

-- ex2-1 [과제]각 현재 직책별 평균 연봉은?
  select b.title, avg(a.salary)
    from salaries a, titles b
   where a.emp_no = b.emp_no        -- 조인조건
     and a.to_date = '9999-01-01'   -- row 선택조건1 
     and b.to_date = '9999-01-01'   -- row 선택조건2
group by b.title
order by avg(a.salary) desc;

-- ex3 사원별 몇 번의 직책 변경이 있었는지 조회
  select emp_no, count(*)
    from titles
group by emp_no
order by count(*) desc;

select * from titles where emp_no='204120';


-- ex4 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
    select emp_no, avg(salary)
      from salaries
  group by emp_no
    having avg(salary) > 50000
  order by avg(salary) asc;
  
-- ex5 [과제] 
-- 현재 직책별로 평균연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.  
select avg(salaries.salary) as '평균연봉', count(*) as '인원수'
from salaries
inner join titles on titles.emp_no=salaries.emp_no
where substr(titles.to_date,1,4)='9999'
and substr(salaries.to_date,1,4)='9999'
group by titles.title
having count(titles.emp_no) >=100;

-- ex6 [과제] 
-- 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
select departments.dept_name as '부서', titles.title as 직책, avg(salaries.salary) as 평균급여
from titles
inner join salaries on salaries.emp_no=titles.emp_no
inner join dept_emp on salaries.emp_no=dept_emp.emp_no
inner join departments on departments.dept_no = dept_emp.dept_no
where substr(titles.to_date,1,4)='9999' 
and substr(salaries.to_date,1,4)='9999' 
and substr(dept_emp.to_date,1,4)='9999' 
and titles.title='Engineer'
group by departments.dept_name;

-- ex7 [과제] 
-- 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요 
-- 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에
-- 대해서 내림차순(DESC)로 정렬하세요.
  select a.title, sum(b.salary)
	from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
     and a.title != 'Engineer'
group by a.title
  having sum(b.salary) > 2000000000
order by sum(b.salary) desc
   limit 0, 1;