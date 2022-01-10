Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--Select *
--From PortfolioProject..CovidVaccinations
--order by 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
order by 1,2

-- Looking at Total Cases vs Total Deaths
--Likelihood of dying(DeathPercentage)
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2

-- Looking at Total Cases vs Population
--Shows what percentage of population got covid
Select Location, date, total_cases, population, (total_cases/population)*100 as CovidPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%' and continent is not null
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population
Select Location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where continent is not null
--Where location like '%states%'
Group by Location, population
order by PercentPopulationInfected desc

--Looking at Highest Death Count per Pop.
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount 
From PortfolioProject..CovidDeaths
Where continent is not null
--Where location like '%states%'
Group by Location
order by TotalDeathCount desc

-- Death Count compared to population for Continents
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount 
From PortfolioProject..CovidDeaths
Where continent is null AND location NOT IN('low income', 'upper middle income', 'high income', 'lower middle income', 'world', 'International')
--Where location like '%states%'
Group by Location
order by TotalDeathCount desc

-- Overall death percentage across all continents
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null
order by 1,2