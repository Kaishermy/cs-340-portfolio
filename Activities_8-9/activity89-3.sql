SELECT Customers.CustomerName, Invoices.InvoiceID, SUM(InvoiceDetails.LineTotal) AS LineSum
FROM InvoiceDetails
INNER JOIN Invoices ON InvoiceDetails.InvoiceID = Invoices.InvoiceID
INNER JOIN Customers ON Invoices.CustomerID = Customers.CustomerID
GROUP BY Invoices.InvoiceID
ORDER BY SUM(InvoiceDetails.LineTotal) DESC;