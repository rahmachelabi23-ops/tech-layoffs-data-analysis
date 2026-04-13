select *
FROM layoffs;

create table layoffs_staging
like layoffs;


select *
FROM layoffs_staging;

INSERT layoffs_staging
select *
from layoffs;

select * ,
row_number() over(
partition by company,location,total_laid_off,percentage_laid_off,`date`, stage , country ,
 funds_raised_millions) as row_num
from layoffs_staging;
WITH duplicate_cte as

(
select * ,
row_number() over(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`,stage,
 country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1 ;

select *
from layoffs_staging
where company ='casper' ;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_staging2
where row_num> 1;


insert into layoffs_staging2
select * ,
row_number() over(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`,stage,
 country, funds_raised_millions) as row_num
from layoffs_staging;

SET SQL_SAFE_UPDATES = 0;

delete
from layoffs_staging2
where row_num> 1;


select *
from layoffs_staging2;

select company , trim(company)
from layoffs_staging2;

update layoffs_staging2 
set company = trim(company);


select distinct industry 
from layoffs_staging2
order by 1;

select*
from layoffs_staging2
where industry like 'Crypto%';

SET SQL_SAFE_UPDATES = 0;

update layoffs_staging2
set industry = 'Crypto'
 where industry like 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

select distinct location
from layoffs_staging2
order by 1 ;

select distinct country
from layoffs_staging2
order by 1 ;

select *
from layoffs_staging2
where country like 'United State%'
order by 1 ;
select distinct country , trim(trailing '.' from country )
from layoffs_staging2
order by 1 ;
update layoffs_staging2
set country = trim(trailing '.' from country )
where country like 'United State%' ;
 
select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

SET SQL_SAFE_UPDATES = 0;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y') ;

select `date`
from layoffs_staging2 ;

SET SQL_SAFE_UPDATES = 0;

alter TABLE layoffs_staging2 
modify column `date` DATE;


select * 
from layoffs_staging2 
where total_laid_off IS NULL
 AND percentage_laid_off is null ;   
  
CREATE TABLE layoffs_staging_temp AS
SELECT DISTINCT * FROM layoffs_staging2;

DROP TABLE layoffs_staging2;

ALTER TABLE layoffs_staging_temp RENAME TO layoffs_staging2;

SELECT * FROM layoffs_staging2 ;

select * 
from layoffs_staging2 
where industry IS NULL
 or industry = '' ; 

select *
from layoffs_staging2
where company = 'airbnb' ;

select t1.industry , t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null ;
 

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry =t2.industry
where (t1.industry is null or t1.industry='')
and t2.industry is not null
and t2.industry != '' ;


select * 
from layoffs_staging2 
where total_laid_off IS NULL
 AND percentage_laid_off is null ;   

delete
from layoffs_staging2 
where total_laid_off IS NULL;


select * 
from layoffs_staging2 ;

alter table layoffs_staging2
drop column row_num ;






