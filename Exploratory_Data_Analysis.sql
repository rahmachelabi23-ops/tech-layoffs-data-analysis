
SELECT * 
FROM layoffs_staging2;


SELECT max(total_laid_off),max(percentage_laid_off)
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

SELECT company , sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc ;

SELECT min(`date`) , max(`date`)
FROM layoffs_staging2;

SELECT industry , sum(total_laid_off)
FROM layoffs_staging2
group by industry  
order by 2 desc ;

SELECT country , sum(total_laid_off) 
FROM layoffs_staging2
group by country  
order by 2 desc ;

SELECT * 
FROM layoffs_staging2 ;  

SELECT year(`date`) , sum(total_laid_off) 
FROM layoffs_staging2
group by year(`date`) 
order by 1 desc ;


select  month(`date`) `month` , sum(total_laid_off)
from layoffs_staging2
group by `month`
order by 1 asc ;


select  substring(`date`,1,7) as `month` , sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc ;


with Rolling_Total as 
(
select  substring(`date`,1,7) as `month` , sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
 )
 select `month`,total_off ,sum(total_off) over(order by `month` asc) as rolling_total
 from Rolling_Total ;


SELECT company ,year(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company , year(`date`)
order by 3 desc ;


with Company_Year(company,years,total_laid_off) as 
(
SELECT company ,year(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company , year(`date`)
 ),
 company_year_rank as(
 select *,
 dense_rank()over(partition by years order by total_laid_off desc) as ranking
 from Company_Year 
 where years is not null
 )
 select *
 from company_year_rank
 where ranking <= 5;
    
select  stage , round(avg(percentage_laid_off), 2) as avg_percentage
from layoffs_staging2
where percentage_laid_off is not null
group by stage
order by 2 asc ;













