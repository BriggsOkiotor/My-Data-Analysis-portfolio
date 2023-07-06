Select*from BriggsPortfolioProject1..CovidDeaths
where continent is not null
order by 3,4

--Select*from BriggsPortfolioProject1..CovidVaccins
--order by 3,4


Select location, date, total_cases, new_cases, total_deaths, population
from BriggsPortfolioProject1..CovidDeaths
order by 1,2

--Likelyhood of dying if your country is affected by covid
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage 
from BriggsPortfolioProject1..CovidDeaths
where location like '%nigeria%'
order by 1,2

--Total cases vs Total population with covid in Nigeria
Select location, date, population, total_cases,  (total_cases/population)*100 as PopulationPercentageInfected
from BriggsPortfolioProject1..CovidDeaths
where location like '%nigeria%'
order by 1,2

--Countries with hihgest infection Rate compared to population
Select location, population, Max(total_cases) as HighestinfectionCount, Max(total_cases/population)*100 
as PopulationPercentageInfected 
from BriggsPortfolioProject1..CovidDeaths
group by location, population
--where location like '%nigeria%'
order by PopulationPercentageInfected desc

-- Countries with the highest death count
Select location, max(cast (total_deaths as int)) as Deathcount
from BriggsPortfolioProject1..CovidDeaths
where continent is not null
group by location
--where location like '%nigeria%'
order by Deathcount desc


-- Continent with the highest death count
Select continent, max(cast (total_deaths as int)) as Deathcount
from BriggsPortfolioProject1..CovidDeaths
where continent is not null
group by continent
--where location like '%nigeria%'
order by Deathcount desc


 
 -- Join table, looking at total population vs vaccinations
Select  det.continent, det.location, det.date, det.population, vac.new_vaccinations
, SUM(cast (vac.new_vaccinations as int)) over (partition by det.location order by  det.location,det.date)
as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from BriggsPortfolioProject1..CovidVaccins vac join BriggsPortfolioProject1..CovidDeaths det
on det.location = vac.location and det.date = vac.date
where det.continent is not null
order by 2,3

         --USING CTE
with PopvsVac (continent, location, date, population, New_vaccination, RollingPeopleVaccinated)
as
(
--Join table, looking at total population vs vaccinations
Select  det.continent, det.location, det.date, det.population, vac.new_vaccinations
, SUM(cast (vac.new_vaccinations as int)) over (partition by det.location order by  det.location,det.date)
as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from BriggsPortfolioProject1..CovidVaccins vac join BriggsPortfolioProject1..CovidDeaths det
on det.location = vac.location and det.date = vac.date
where det.continent is not null
--order by 2,3
)
select *,(RollingPeopleVaccinated/population)*100
from PopvsVac



   --THE END--

