// ########################################
// ########## SETUP

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

const PORT = 40805;

// Database
const db = require('./database/db-connector');

// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ extname: '.hbs' })); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.

// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES
app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/exhibits', async function (req, res) {
    try {
        const query1 = `SELECT 
                            Exhibits.exhibitID,
                            Museums.name AS museumName,
                            Exhibits.title,
                            Exhibits.theme,
                            Exhibits.artPieceCount,
                            DATE_FORMAT(Exhibits.startDate, '%Y-%m-%d') AS startDate,
                            DATE_FORMAT(Exhibits.endDate, '%Y-%m-%d') AS endDate,
                            Exhibits.dailyMaintenanceCost
                        FROM Exhibits
                        JOIN Museums ON Exhibits.museumID = Museums.museumID;`;
        const [exhibits] = await db.query(query1);
        res.render('exhibits', {exhibits: exhibits});
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/museums', async function (req, res) {
    try {
        const query1 = `SELECT * FROM Museums;`;
        const [museums] = await db.query(query1);
        res.render('museums', {museums: museums});
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/staff', async function (req, res) {
    try {
        const query1 = `SELECT 
                            Staff.staffID,
                            Museums.name AS museumName,
                            Staff.name,
                            Staff.role,
                            Staff.hourlyPay,
                            DATE_FORMAT(Staff.hireDate, '%Y-%m-%d') AS hireDate,
                            Staff.isFullTime
                        FROM Staff
                        JOIN Museums ON Staff.museumID = Museums.museumID;`;
        const [staff] = await db.query(query1);
        res.render('staff', {staff: staff});
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/visitors', async function (req, res) {
    try {
        const query1 = `SELECT * FROM Visitors;`;
        const [visitors] = await db.query(query1);
        res.render('visitors', {visitors: visitors});
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

app.get('/visits', async function (req, res) {
    try {
        // Don't use * here since dates need to be formatted properly
        const query1 = `SELECT 
                            Visits.visitID,
                            Visitors.name AS visitorName,
                            Museums.name AS museumName,
                            DATE_FORMAT(Visits.visitDate, '%Y-%m-%d') AS visitDate,
                            Visits.ticketType,
                            Visits.ticketPrice
                        FROM Visits
                        JOIN Visitors ON Visits.visitorID = Visitors.visitorID
                        JOIN Museums ON Visits.museumID = Museums.museumID
                        ORDER BY Visits.visitID ASC;`;
        const query2 = `SELECT visitorID, name FROM Visitors ORDER BY name ASC;`
        const query3 = `SELECT museumID, name FROM Museums ORDER BY name ASC;`
        const [visits] = await db.query(query1);
        const [visitors] = await db.query(query2);
        const [museums] = await db.query(query3);
        res.render('visits', {visits: visits, visitors: visitors, museums: museums});
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});