# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## About this project

Our project Cafe Connect will help connect local cafes in the Greater Boston area with caffeine enthusiasts who want to explore their neighborhood or even just grab a quick cup of coffee on the go. Using a database that contains helpful information about the cafes (location, public wifi access, ambiance, electric outlet access, ratings, menus, etc.) we will cater to both the business owners who want to market their local businesses, and people who want to quickly lookup a cafe that matches their preferences based on factors such as their budget, if they want to visit alone or in a group and how long they want to spend at the cafe. This project aims to promote local cafes and help users make plans more efficiently and easier

## Authors

Nandini Ghosh, Gianna Saw, Akash Cheela, Olivia Gao, Jiana Ang
(Source forked from Dr. Mark Fontenot)

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## Database 

The **db_bootstrap.sql** file contains all the database code for this project including schemas and mock-up values created using