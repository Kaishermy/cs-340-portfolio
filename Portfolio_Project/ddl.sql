-- Create the Visitors, Museums, Exhibits, Staff, and Visits tables
CREATE TABLE Visitors (
    visitorID int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    phoneNum varchar(12),
    email varchar(50),
    PRIMARY KEY (visitorID)
);

CREATE TABLE Museums (
    museumID int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    location varchar(50) NOT NULL,
    maxCapacity int(10) UNSIGNED NOT NULL,
    PRIMARY KEY (museumID)
);

CREATE TABLE Exhibits (
    exhibitID int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    museumID int(10) UNSIGNED NOT NULL,
    title varchar(100) NOT NULL,
    theme varchar(100) NOT NULL,
    artPieceCount int(10) UNSIGNED NOT NULL,
    startDate date NOT NULL,
    endDate date,
    dailyMaintenanceCost decimal(8,2) NOT NULL,
    PRIMARY KEY (exhibitID),
    FOREIGN KEY (museumID) REFERENCES Museums(museumID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Staff (
    staffID int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    museumID int(10) UNSIGNED NOT NULL,
    name varchar(50) NOT NULL,
    role varchar(50) NOT NULL,
    hourlyPay decimal(4,2) NOT NULL,
    hireDate date NOT NULL,
    isFullTime boolean NOT NULL,
    PRIMARY KEY (staffID),
    FOREIGN KEY (museumID) REFERENCES Museums(museumID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Visits (
    visitID int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    visitorID int(10) UNSIGNED NOT NULL,
    museumID int(10) UNSIGNED NOT NULL,
    visitDate date NOT NULL,
    ticketType varchar(50) NOT NULL,
    ticketPrice decimal(5,2) NOT NULL,
    PRIMARY KEY (visitID),
    FOREIGN KEY (visitorID) REFERENCES Visitors(visitorID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (museumID) REFERENCES Museums(museumID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Add data to the Visitors table
INSERT INTO Visitors
(
    name,
    phoneNum,
    email
)
VALUES
(
    "James Museumson",
    "472-258-0571",
    "museumJames@website.com"
),
(
    "Smith Sonian",
    "551-474-3233",
    "smithsonian@website.com"
),
(
    "Solomon Guggenheim",
    "305-494-2390",
    "guggSolo@website.com"
);

-- Add data to the Museums table
INSERT INTO Museums
(
    name,
    location,
    maxCapacity
)
VALUES
(
    "Museum of Extremely Fine Arts",
    "Northern Museuchusetts",
    10
),
(
    "Unnatural History Museum",
    "Eastern Museuchusetts",
    1000
),
(
    "Wax Museum",
    "Southern Museuchusetts",
    50000
),
(
    "Botanical Garden",
    "Western Museuchusetts",
    10000
),
(
    "Museuchusetts Museum of Museums",
    "Central Museuchusetts",
    50000
);

-- Add data to the Visits table
INSERT INTO Visits
(
    visitorID,
    museumID,
    visitDate,
    ticketType,
    ticketPrice
)
VALUES
(
    (SELECT visitorID FROM Visitors WHERE name = "James Museumson"),
    (SELECT museumID FROM Museums WHERE name = "Museuchusetts Museum of Museums"),
    "2026-01-01",
    "Adult",
    100.00
),
(
    (SELECT visitorID FROM Visitors WHERE name = "Solomon Guggenheim"),
    (SELECT museumID FROM Museums WHERE name = "Museum of Extremely Fine Arts"),
    "2026-01-06",
    "Senior",
    75.00
),
(
    (SELECT visitorID FROM Visitors WHERE name = "James Museumson"),
    (SELECT museumID FROM Museums WHERE name = "Wax Museum"),
    "2026-01-06",
    "Adult",
    5.00
),
(
    (SELECT visitorID FROM Visitors WHERE name = "Smith Sonian"),
    (SELECT museumID FROM Museums WHERE name = "Unnatural History Museum"),
    "2026-01-31",
    "Child",
    250.00
),
(
    (SELECT visitorID FROM Visitors WHERE name = "Smith Sonian"),
    (SELECT museumID FROM Museums WHERE name = "Museuchusetts Museum of Museums"),
    "2026-02-02",
    "Child",
    50.00
);

-- Add data to the Exhibits table
INSERT INTO Exhibits
(
    museumID,
    title,
    theme,
    artPieceCount,
    startDate,
    endDate,
    dailyMaintenanceCost
)
VALUES
(
    (SELECT museumID FROM Museums WHERE name = "Museum of Extremely Fine Arts"),
    "The Finer Art",
    "Modern",
    100,
    "2020-01-01",
    "2029-12-31",
    10000.00
),
(
    (SELECT museumID FROM Museums WHERE name = "Botanical Garden"),
    "Some Trees",
    "Nature",
    15,
    "1900-10-14",
    NULL,
    5.00
),
(
    (SELECT museumID FROM Museums WHERE name = "Museum of Extremely Fine Arts"),
    "The Finest Art",
    "Modern",
    10,
    "2020-01-02",
    "2030-01-01",
    10001.00
),
(
    (SELECT museumID FROM Museums WHERE name = "Wax Museum"),
    "The Founders",
    "Historical",
    50,
    "2025-06-01",
    NULL,
    500.00
);

-- Add data to the Staff table
INSERT INTO Staff
(
    museumID,
    name,
    role,
    hourlyPay,
    hireDate,
    isFullTime
)
VALUES
(
    (SELECT museumID FROM Museums WHERE name = "Museum of Extremely Fine Arts"),
    "Museum Murphy",
    "Manager",
    99.99,
    "2025-01-01",
    1
),
(
    (SELECT museumID FROM Museums WHERE name = "Wax Museum"),
    "Waxon Carver",
    "Wax Sculptor",
    25.00,
    "2020-05-05",
    0
),
(
    (SELECT museumID FROM Museums WHERE name = "Unnatural History Museum"),
    "Odysseus",
    "Mythical Figure",
    7.25,
    "2026-07-17",
    0
);
