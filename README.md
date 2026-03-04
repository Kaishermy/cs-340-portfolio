# cs-340-portfolio
A portfolio showcasing work done in CS 340 at Oregon State University by Kai Sherman. Citations are provided in relevant markdown documents or file comments.
## Portfolio Project
The WIP portfolio project was written by Kevin Phillips and Kai Sherman and was written to run on the remote Oregon State University engineering server.

A DDL file is provided for establishing the sample database in a local MySQL instance. Doing so will require the necessary changes in db-connector.js to run the project. Once the repository has been cloned, the DDL.sql file has executed, and necessary db-connector.js changes have been made, you can activate the website by entering:

```
$ npm run production
```

It can subsequently be stopped by entering:

```
$ npm run stop_production
```

By default, the site runs on port 40508.
