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

The **db_bootstrap.sql** file contains all the database code for this project including schemas and mock-up values created using Mockaroo, ChatGPT and manually.

## Flask App

The **cafe.py** file contains all the api endpoint definitions for the CafeConnect application.

**Endpoint 1: Get All Cafes with Promotions**
URL: /cafe/promotions
Method: GET
Description: Retrieves a list of all cafes currently offering promotions. The response includes details like cafe name, operational times, days, and address.

**Endpoint 2 (GET): Get Promotions by Cafe ID**
URL: /cafe/<cafe_id>/promotions
Method: GET
Description: Fetches a list of all promotions available at a specific cafe, identified by cafe_id. Includes information like cafe name, time, days, and address.

**Endpoint 2 (POST): Add New Promotion**
URL: /cafe/<cafe_id>/promotions
Method: POST
Description: Adds a new promotion to a specific cafe, identified by cafe_id. Requires details like promotion title, description, and duration in the request body.

**Endpoint 2 (DELETE): Delete Promotion**
URL: /cafe/<cafe_id>/promotions/<promo_id>
Method: DELETE
Description: Deletes a specific promotion, identified by promo_id, from a cafe, identified by cafe_id.

**Endpoint 3: Get Cafes with WiFi**
URL: /cafe/wifi
Method: GET
Description: Returns a list of cafes equipped with WiFi. Includes details like operational times, days, and address.

**Endpoint 13: Get Specific Invite for a Customer**
URL: /customers/<customer_id>/<invite_id>
Method: GET
Description: Retrieves details of a specific invite (identified by invite_id) for a customer (identified by customer_id) for a special event.

**Endpoint 16 (GET): Get All Cafes**
URL: /cafe
Method: GET
Description: Fetches a list of all cafes, including details like operational times, days, and addresses.

**Endpoint 16 (POST): Add a Cafe**
URL: /cafe
Method: POST
Description: Adds a new cafe to the database. Requires details like owner ID, operational times, days, website link, and address in the request body.

**Endpoint 16 (DELETE): Delete a Cafe**
URL: /cafe/<cafe_id>
Method: DELETE
Description: Deletes a specific cafe from the database, identified by cafe_id.

**Endpoint 4: Get Cafes with Outlets**
URL: /cafe/outlets
Method: GET
Description: Retrieves a list of cafes that have electrical outlets available. Includes operational times, days, and address.

**Endpoint 5: Get Specific Cafe Details**
URL: /cafe/<cafe_id>
Method: GET
Description: Provides detailed information about a specific cafe, identified by cafe_id. Includes operational times, days, address, and website link.

**Endpoint 5.2: Get Cafe Hours**
URL: /cafe/<cafe_id>/hours
Method: GET
Description: Fetches the operational hours of a specific cafe, identified by cafe_id.

**Endpoint 5.3: Update Cafe Hours**
URL: /cafe/<cafe_id>/hours
Method: PUT
Description: Updates the operational hours of a specific cafe, identified by cafe_id. Requires new time and days in the request body.

**Endpoint 6: Get Cafes with Low Price Rating**
URL: /cafe/low-price
Method: GET
Description: Lists all cafes with a low price rating. Includes cafe details and price rating.

**Endpoint 7: Get Cafes with Fast Service**
URL: /cafe/fast-service
Method: GET
Description: Retrieves a list of cafes known for their fast service. Includes cafe details, price, and service speed rating.

**Endpoint 11: Get Reviews for a Specific Cafe**
URL: /cafe/<cafe_id>/reviews
Method: GET
Description: Fetches all customer reviews for a specific cafe, identified by cafe_id. Includes reviewer's name, rank, and review content.