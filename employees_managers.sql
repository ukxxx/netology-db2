-- Создаем таблицу отделов
create table Departments (
  id serial primary key,
  name varchar(255) not null
);

-- Создаем таблицу сотрудников
create table Employees (
  id serial primary key,
  name varchar(255) not null,
  department_id integer references Departments(id),
  manager_id integer references Employees(id)
);