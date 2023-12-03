from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

cafe = Blueprint('cafe', __name__)

def get_cafes():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    #query
    query = '''
            SELECT name, street, city, state, zip, Ratings.price 
            FROM Cafe c JOIN Ratings r ON c.cafe_id = r.cafe_id
        '''

    # use cursor to query the database for a list of products
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# --------------
# ENDPOINT 8
# --------------

# 8. METHOD 1 GET 
# Get all details of a cafe including its address 
@cafe.route('/cafe/<cafe_id>', methods=['GET'])
def get_cafe_details(cafe_id):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    #query the database for cafe details
    query = ('''
            SELECT * 
            FROM Cafe c JOIN Ratings r ON c.cafe_id = r.cafe_id JOIN Reviews re ON c.cafe_id = re.cafe_id 
            WHERE id = ''' + str(cafe_id))
    
    #Executing the query
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


#8. METHOD 2 PUT
# Updating cafe information
@cafe.route('/cafe/<cafe_id>', methods=['PUT'])
def update_cafe_details(cafe_id):
    # Collecting data from the request object
    updated_data = request.json
    current_app.logger.info(updated_data)

    # Extracting variables
    # Assuming your cafe table has columns like time, days, website_link, etc.
    # Adjust these variable names based on your actual column names
    time = updated_data.get('time')
    days = updated_data.get('days')
    website_link = updated_data.get('website_link')
    name = updated_data.get('name')
    street = updated_data.get('street')
    city = updated_data.get('city')
    zip_code = updated_data.get('zip')
    state = updated_data.get('state')
    has_wifi = updated_data.get('has_wifi')
    has_outlets = updated_data.get('has_outlets')

    # Constructing the SQL UPDATE query
    query = f'''
        UPDATE cafes
        SET
            time = "{time}",
            days = "{days}",
            website_link = "{website_link}",
            name = "{name}",
            street = "{street}",
            city = "{city}",
            zip = "{zip_code}",
            state = "{state}",
            has_wifi = {has_wifi},
            has_outlets = {has_outlets}
        WHERE cafe_id = {cafe_id}
    '''
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Update successful'


#8.METHOD 3 DELETE
#Deleting cafe
@cafe.route('/cafe/<cafe_id>', methods=['DELETE'])
def delete_cafe(cafe_id):
    # Constructing the SQL DELETE query
    query = f'''
        DELETE FROM cafes
        WHERE cafe_id = {cafe_id}
    '''
    current_app.logger.info(query)

    # Executing and committing the delete statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Cafe deleted'

# --------------
# ENDPOINT 10
# --------------

#10. METHOD 1 GET
#Getting social media links

@cafe.route('/cafe/<cafe_id>/social_links', methods=['GET'])
def get_cafe_social_links(cafe_id):
    # Constructing the SQL SELECT query to retrieve social media and website links
    query = f'''
        SELECT website_link
        FROM cafes
        WHERE cafe_id = {cafe_id}
    '''
    current_app.logger.info(query)

    # Executing the select statement
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # Fetching the data from the cursor
    data = cursor.fetchone()

    # Checking if the cafe exists
    if not data:
        return jsonify({'error': 'Cafe not found'}), 404

    # Extracting the social media and website links
    website_link = data[0]

    # Splitting the website_link into individual social media links
    social_media_links = website_link.split(',')  

    # Constructing the response JSON
    response_data = {
        'cafe_id': cafe_id,
        'website_link': website_link,
    }

    return jsonify(response_data)


#10. METHOD 2 POST
#Adding a link

@cafe.route('/cafe/<cafe_id>/social_links', methods=['POST'])
def add_cafe_social_link(cafe_id):
    # Collecting data from the request object
    request_data = request.json
    current_app.logger.info(request_data)

    # Extracting the new link
    new_link = request_data.get('new_link')

    # Constructing the SQL UPDATE query to append the new link to website_link
    query = f'''
        UPDATE cafes
        SET website_link = CONCAT(website_link, ',', "{new_link}")
        WHERE cafe_id = {cafe_id}
    '''
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Link added successfully'

#10. METHOD 3 PUT
#Updating Social Links

@cafe.route('/cafe/<cafe_id>/social_links', methods=['PUT'])
def update_cafe_social_links(cafe_id):
    # Collecting data from the request object
    request_data = request.json
    current_app.logger.info(request_data)

    # Extracting the new list of links
    new_links = request_data.get('new_links')

    # Constructing the SQL UPDATE query to set the new list of links to website_link
    query = f'''
        UPDATE cafes
        SET website_link = "{new_links}"
        WHERE cafe_id = {cafe_id}
    '''
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Links updated successfully'


#10. METHOD 4 DELETE
# Deleting a link from website_links

@cafe.route('/cafe/<cafe_id>/social_links', methods=['DELETE'])
def delete_cafe_social_link(cafe_id):
    # Collecting data from the request object
    request_data = request.json
    current_app.logger.info(request_data)

    # Extracting the link to be deleted
    link_to_delete = request_data.get('link_to_delete')

    # Constructing the SQL UPDATE query to remove the link from website_link
    query = f'''
        UPDATE cafes
        SET website_link = REPLACE(website_link, "{link_to_delete}", "")
        WHERE cafe_id = {cafe_id}
    '''
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Link deleted successfully'


# --------------
# ENDPOINT 11
# --------------

#11. METHOD 1 GET
#Get all reviews of a cafe

@cafe.route('/cafe/<cafe_id>/reviews', methods=['GET'])
def get_cafe_reviews(cafe_id):
    # Constructing the SQL SELECT query to retrieve reviews for the specified cafe
    query = f'''
        SELECT review_id, content, customer_id
        FROM reviews
        WHERE cafe_id = {cafe_id}
    '''
    current_app.logger.info(query)

    # Executing the SELECT statement
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # Fetching all the reviews for the cafe
    reviews_data = cursor.fetchall()

    # Checking if the cafe exists
    if not reviews_data:
        return jsonify({'error': 'Cafe not found or has no reviews'}), 404

    # Constructing the response JSON
    reviews_list = []
    for review in reviews_data:
        review_dict = {
            'review_id': review[0],
            'content': review[1],
            'customer_id': review[2]
        }
        reviews_list.append(review_dict)

    return jsonify({'reviews': reviews_list})


#11. METHOD 2 POST
#Adding review to a cafe

def is_valid_customer_id(customer_id):
    # Check if the customer_id exists in the 'customers' table
    query = f'SELECT customer_id FROM customers WHERE customer_id = {customer_id}'
    cursor = db.get_db().cursor()
    cursor.execute(query)
    return cursor.fetchone() is not None

@cafe.route('/cafe/<cafe_id>/reviews', methods=['POST'])
def add_cafe_review(cafe_id):
    # Collecting data from the request object
    review_data = request.json
    current_app.logger.info(review_data)

    # Extracting variables
    content = review_data.get('content')
    customer_id = review_data.get('customer_id')

    # Validate customer_id against the 'customers' table
    if not is_valid_customer_id(customer_id):
        return jsonify({'error': 'Invalid customer ID'}), 400

    # Constructing the SQL INSERT query for a new review
    query = f'''
        INSERT INTO reviews (cafe_id, content, customer_id)
        VALUES ({cafe_id}, "{content}", {customer_id})
    '''
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Review added successfully'


#11. METHOD 3 PUT
#Adding review to a cafe THIS IS DIFFERENT FROM OUR MATRIX

@cafe.route('/cafe/<cafe_id>/reviews/<review_id>', methods=['PUT'])
def edit_cafe_review(cafe_id, review_id):
    # Collecting data from the request object
    updated_review_data = request.json
    current_app.logger.info(updated_review_data)

    # Extracting variables
    updated_content = updated_review_data.get('content')

    # Constructing the SQL UPDATE query to edit the existing review
    query = f'''
        UPDATE reviews
        SET content = "{updated_content}"
        WHERE cafe_id = {cafe_id} AND review_id = {review_id}
    '''
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Review edited successfully'


#11. METHOD 4 DELETE
#Deleting a review 

@cafe.route('/cafe/<cafe_id>/reviews/<review_id>', methods=['DELETE'])
def delete_cafe_review(cafe_id, review_id):
    # Constructing the SQL DELETE query to remove the specified review
    query = f'''
        DELETE FROM reviews
        WHERE cafe_id = {cafe_id} AND review_id = {review_id}
    '''
    current_app.logger.info(query)

    # Executing and committing the delete statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Review deleted successfully'





