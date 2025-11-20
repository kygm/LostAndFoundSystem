Created by KYGM for SCSU CSCI 414 Platform Based Development

You need a postgres environment set up for this application to work. Instructions for setup:
1. Create a database `lostAndFoundDb` in postgres
2. Execute every script in ./sql
3. Start the api from ./api : `npm run dev`
4. Start the UI from ./lost-and-found : ng serve  

More detailed instructions:

This is the link to the video with detailed instructions on how to clone, set up (the api and database), and run the project from scratch.
https://mediaspace.minnstate.edu/media/CSCI414ProjectSetup/1_jcsudb1k

Watch the video in its entirety before starting and if your system is not working, consult with the video before reaching out
Rules:
1. Do not push to the main branch, instead create a pull request
2. Don't change the API or database. Instead reach out to me if you need any new functionality added
Requirements:
1. Visual Studio Code
2. Github
3. Node installation https://nodejs.org/en/download
4. A pgadmin4 installation https://www.pgadmin.org/download/pgadmin-4-windows/
5. Pgadmin user: postgres
   Pgadmin password: admin 


When you clone the API, do the following things in the order I have given here:
1. Open pgadmin and create a new database called lostAndFoundDb
2. Open the table creation script in ./sql and run it
3. Open each Functions script in ./sql and run them
4. From a terminal window, navigate to ./api and run `npm install`
5. From a terminal window, navigate to ./lost-and-found and run `npm install`


Once those items are done in that order, exactly as presented, you can:
1. Navigate to ./api and run `npm run dev`
2. In a new terminal window, navigate to ./lost-and-found and run `npm start`
