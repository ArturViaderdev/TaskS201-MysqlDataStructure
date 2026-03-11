# TaskS201 Mysql Data Structure

# Level 1

## Exercise 1 - Optics

An optical store called **“Cul d'Ampolla”** wants to computerize the management of its clients and eyeglass sales.

First, the store wants to know who the supplier of each pair of glasses is. Specifically, it wants to know for each supplier:

- Name
- Address (street, number, floor, door, city, postal code, and country)
- Telephone number
- Fax
- Tax ID (NIF)

The store’s purchasing policy is based on the idea that glasses from a specific brand will be purchased from a single supplier (to obtain better prices). However, a supplier can provide glasses of various brands.

For each pair of glasses, the store wants to know:

- Brand
- Lens prescription for each lens
- Frame type (rimless, plastic, or metal)
- Frame color
- Lens color (for each lens)
- Price

For each client, the store wants to store the following information:

- Name
- Postal address
- Telephone number
- Email address
- Registration date

When a new client joins, the system must also record the client who recommended the store (if any).

Finally, the system must indicate which employee sold each pair of glasses.

***Answer***

 designed the database without numeric IDs because the DNI and name are unique and can serve as primary keys. The SQL file is called ***level1exercise1optics.sql***, and the diagram is in **level1exercise1optics.png**.

## Exercise 2 - Pizzeria

You have been hired to design a website that allows users to place food delivery orders online.
Take into account the following guidelines when modeling the database for the project:

### Customer Data

For each customer, store a unique identifier and the following information:

- First name
- Last name
- Address
- Postal code
- City
- Province
- Phone number

City and province data will be stored in separate tables.
A city belongs to a single province, and a province can have many cities.
For each city, store a unique identifier and a name.
For each province, store a unique identifier and a name.

### Orders

A person can place multiple orders, but an order can only be placed by a single person.
For each order, store a unique identifier along with the following information:

- Date and time
- Whether the order is for home delivery or in-store pickup
- The quantity of each selected product type
- The total price

An order can include one or several products.

### Products

Products can be **pizzas**, **burgers**, or **drinks**.
For each product, store a unique identifier and the following details:

- Name
- Description
- Image
- Price

### Pizza Categories

Pizzas belong to categories, which may change their name over the year.
A pizza can only belong to one category, but a category can include many pizzas.
For each category, store a unique identifier and a name.

### Stores

Each order is managed by a single store, and a store can manage many orders.
For each store, store a unique identifier and the following details:

- Address
- Postal code
- City
- Province

### Employees

A store can employ many workers, but each employee works in only one store.
For each employee, store a unique identifier and the following details:

- First name
- Last name
- NIF (Tax ID)
- Phone number
- Job role (either cook or delivery driver)

For delivery orders, it is important to record which delivery driver made the delivery and the date/time it was completed.



***Answer***

I did the exercise. The SQL script is in the **level1exercise2pizzeria.sql** file, and the diagram is in **level1exercise2pizzeria.png**.



# Level 2

## Exercise 1 – YouTube

We will try to create a simple model of what the database for a simplified version of YouTube would look like.

## User

For each user, we store a unique identifier and the following information:

- Email

- Password

- Username

- Date of birth

- Gender

- Country

- Postal code

## Video

A user publishes videos. For each video, we store a unique identifier and the following information:

- Title

- Description

- Size

- Video file name

- Video duration

- Thumbnail

- Number of views

- Number of likes

- Number of dislikes

A video can have three different states: **public**, **hidden**, or **private**.  
A video can have many tags. Each tag is identified by a unique identifier and a tag name.  
We also need to store which user published the video and on what date/time.

## Channel

A user can create a channel. A channel has a unique identifier and the following information:

- Name

- Description

- Creation date

A user can subscribe to other users’ channels.

## Likes and Dislikes

A user can give a **like** or **dislike** to a video only once.  
We must keep a record of which users have liked or disliked a specific video and when (date/time) they did it.

## Playlist

A user can create playlists with the videos they like. Each playlist has a unique identifier and the following information:

- Name

- Creation date

- A status indicating whether it is **public** or **private**

## Comments

A user can write comments on a specific video. Each comment is identified by a unique identifier and contains:

- The comment text

- The date/time it was made

A user can mark a comment as **like** or **dislike**.  
We must keep a record of which users have marked a comment as like/dislike and when (date/time) they did it.
