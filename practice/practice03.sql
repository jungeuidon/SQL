-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select employees.emp_no as 사번, concat(last_name, ' ', first_name) as  이름, salary as 연봉
 from employees 
 inner join salaries on employees.emp_no=salaries.emp_no
 where substr(salaries.to_date,1,4)='9999'
 order by salary desc;
 
-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select employees.emp_no as 사번, concat(last_name, ' ', first_name) as  이름, title as 직책 
from employees 
inner join titles on employees.emp_no=titles.emp_no
where substr(titles.to_date,1,4)='9999'
order by concat(employees.last_name, ' ', employees.first_name);

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
select employees.emp_no  as 사번, concat(last_name, ' ', first_name) as  이름, departments.dept_name as 부서
from dept_emp
inner join employees on dept_emp.emp_no=employees.emp_no
inner join departments on dept_emp.dept_no=departments.dept_no
where substr(dept_emp.to_date,1,4)='9999'
order by concat(last_name, ' ', first_name);


-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.   ** 현재라고 안적혀있다.
select employees.emp_no  as 사번, concat(last_name, ' ', first_name) as  이름, salaries.salary as 연봉, titles.title as 직책, departments.dept_name as 부서
from employees
inner join salaries on employees.emp_no=salaries.emp_no
inner join titles on employees.emp_no=titles.emp_no
inner join dept_emp on employees.emp_no=dept_emp.emp_no
inner join departments on dept_emp.dept_no=departments.dept_no
order by concat(last_name, ' ', first_name);

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
select employees.emp_no  as 사번, concat(last_name, ' ', first_name) as  이름
from titles
inner join employees on employees.emp_no = titles.emp_no
where titles.title='Technique Leader' and not(substr(titles.to_date,1,4)='9999');

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select concat(last_name, ' ', first_name) as  이름, departments.dept_name as 부서, titles.title as 직책
from employees
inner join titles on employees.emp_no=titles.emp_no
inner join dept_emp on employees.emp_no=dept_emp.emp_no
inner join departments on departments.dept_no = dept_emp.dept_no
where employees.last_name like 'S%';

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
  select concat(last_name , ' ', first_name) as  이름, titles.title as 직책, salaries.salary as 급여
 from employees
 inner join titles on employees.emp_no = titles.emp_no
 inner join salaries on employees.emp_no = salaries.emp_no
 where titles.title='Engineer' 
 and salaries.salary>=40000 
 and substr(titles.to_date,1,4)='9999' 
 and substr(salaries.to_date,1,4)='9999'
 order by salaries.salary desc;


-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
select titles.title as 직책, salaries.salary as 급여
from titles
inner join salaries on titles.emp_no = salaries.emp_no
where salaries.salary > 50000 
and substr(salaries.to_date,1,4) = '9999' 
and substr(titles.to_date,1,4)='9999'
order by salaries.salary desc;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select avg(salaries.salary) as '부서별 평균 연봉' , departments.dept_name as 부서명
from salaries
inner join dept_emp on dept_emp.emp_no = salaries.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no
where substr(salaries.to_date,1,4) = '9999'
and substr(dept_emp.to_date,1,4) = '9999'
group by departments.dept_name
order by avg(salaries.salary) desc;




-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select titles.title as 직책, avg(salaries.salary) as '직책별 평균 연봉'
from salaries
inner join titles on salaries.emp_no=titles.emp_no
where substr(salaries.to_date,1,4) = '9999'
and substr(titles.to_date,1,4) = '9999'
group by titles.title
order by avg(salaries.salary) desc;
