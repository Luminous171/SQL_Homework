-- Retrieve transactions from a cardholder
SELECT ch.name, cc.card, t.amount
FROM card_holder AS ch
INNER JOIN credit_card AS cc ON ch.id = cc.id_card_holder
LEFT JOIN transaction AS t ON cc.card = t.card
WHERE ch.name = 'John Martin';

-- Largest 100 transactions from the hours of 7am to 9am
CREATE OR REPLACE VIEW top100_large_transactions AS
SELECT *
FROM transaction AS t
WHERE EXTRACT(HOUR FROM date) <= 9 AND
	EXTRACT(HOUR FROM date) >= 7
ORDER BY amount DESC
LIMIT 100;

-- Small transactions less than $2 by cardholder
CREATE OR REPLACE VIEW cardholders_small_transactions AS
SELECT ch.name, COUNT(t.amount) AS "Number_of_small_transactions"
FROM card_holder AS ch
INNER JOIN credit_card AS cc ON ch.id = cc.id_card_holder
LEFT JOIN transaction AS t ON cc.card = t.card
WHERE t.amount < 2
GROUP BY ch.name
ORDER BY COUNT(t.amount) DESC;

-- Analyze Megan Price's transactions for fraud
SELECT ch.name, t.amount, t.date, t.id_merchant
FROM card_holder AS ch
INNER JOIN credit_card AS cc ON ch.id = cc.id_card_holder
LEFT JOIN transaction AS t ON cc.card = t.card
WHERE ch.name = 'Megan Price' AND
	t.amount < 2
ORDER BY date;

-- Top 5 merchants for small transactions
CREATE OR REPLACE VIEW top5_merchants_small_transactions AS
SELECT t.id_merchant, m.name AS "merchant_name", mc.name AS "merchant_cat", COUNT(t.amount) AS "small_transactions"
FROM transaction AS t
INNER JOIN merchant AS m ON t.id_merchant = m.id
LEFT JOIN merchant_category AS mc ON m.id_merchant_category = mc.id
WHERE t.amount < 2
GROUP BY m.name, t.id_merchant, mc.name
ORDER BY COUNT(t.amount) DESC
LIMIT 5;


