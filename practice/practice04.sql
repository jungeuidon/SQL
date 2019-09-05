-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(emp_no) as '직원수'
from salaries 
where salary > ( select avg(salary) 
					from salaries 
                    where substr(to_date,1,4)='9999')
and substr(to_date,1,4)='9999';
 
-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select a.first_name, c.dept_no, b.salary 
	from employees a, salaries b, dept_emp c
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and (c.dept_no, b.salary) =any (  select c.dept_no, max(b.salary) as max_salary 
	from employees a, salaries b, dept_emp c
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
group by c.dept_no); 


-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요.
select e.emp_no as '사번', concat(e.first_name, ' ', e.last_name) as '이름', s.salary as '연봉'
from employees e, salaries s, dept_emp d_e, (select avg(s.salary) as avgsal
						from salaries s, dept_emp d_e
                        where s.emp_no = d_e.emp_no
                        and substr(s.to_date,1,4) ='9999'
						and substr(d_e.to_date,1,4)='9999'
                        group by dept_no) a
where e.emp_no = s.emp_no
and e.emp_no = d_e.emp_no
and substr(s.to_date,1,4) ='9999'
and substr(d_e.to_date,1,4)='9999'
and s.salary > a.avgsal;


-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', manage.maname as '매니저명', c.dept_name as '부서'
from employees a, dept_emp b, departments c, (select concat(first_name, ' ', last_name) as maname, c.dept_no
											 from dept_manager a, employees b, dept_emp c
											 where a.emp_no = b.emp_no
                                               and b.emp_no = c.emp_no
                                               and a.to_date = '9999-01-01') manage
where a.emp_no = b.emp_no
  and b.dept_no = manage.dept_no
  and b.dept_no = c.dept_no
  and b.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', b.title as '직책', c.salary as '연봉'
from employees a, titles b, salaries c, dept_emp d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.emp_no = d.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and d.dept_no = (select b.dept_no
				   from salaries a, dept_emp b
                   where a.emp_no = b.emp_no
                   and a.to_date = '9999-01-01'
				   and b.to_date = '9999-01-01'
                   group by b.dept_no
                   order by avg(a.salary) desc
                   limit 0, 1)
order by c.salary desc;


-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
select max(avgsal), deptname
from (select avg(salaries.salary) as avgsal, departments.dept_name as deptname from salaries, departments, dept_emp
		where departments.dept_no=dept_emp.dept_no
		and dept_emp.emp_no = salaries.emp_no
		group by departments.dept_no order by avgsal desc) a;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select max(평균연봉) , 직책
from (select titles.title as 직책, avg(salaries.salary) as 평균연봉
	  from salaries, titles
	  where salaries.emp_no=titles.emp_no
	  group by titles.title order by 평균연봉 desc) a;


-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select d.dept_name as '부서', concat(a.first_name, ' ', a.last_name) as '이름', c.salary as '연봉', manage.m_n as '매니저', manage.m_s as '매니저 연봉'
from employees a, dept_emp b, salaries c, departments d, (select concat(a.first_name, ' ', a.last_name) m_n, b.dept_no m_d, c.salary m_s
                                                          from employees a, dept_manager b, salaries c
                                                          where a.emp_no = b.emp_no
															and a.emp_no = c.emp_no
											                and b.to_date = '9999-01-01'
                                                            and c.to_date = '9999-01-01') manage
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.dept_no = d.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.dept_no = manage.m_d
  and c.salary > manage.m_s;