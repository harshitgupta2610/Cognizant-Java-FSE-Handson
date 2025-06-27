-- Scenario 1: Apply 1% interest discount for customers above 60
BEGIN
    FOR rec IN (SELECT customer_id FROM customers WHERE age > 60) LOOP
        UPDATE loans
        SET interest_rate = interest_rate - 1
        WHERE customer_id = rec.customer_id;
    END LOOP;
    COMMIT;
END;
/



-- Scenario 2: Promote customers to VIP if balance > $10,000
BEGIN
    FOR rec IN (SELECT customer_id FROM customers WHERE balance > 10000) LOOP
        UPDATE customers
        SET isVIP = 'Y'
        WHERE customer_id = rec.customer_id;
    END LOOP;
    COMMIT;
END;
/




-- Scenario 3: Send reminders for loans due in next 30 days
BEGIN
    FOR rec IN (
        SELECT l.loan_id, c.name, l.due_date
        FROM loans l
        JOIN customers c ON l.customer_id = c.customer_id
        WHERE l.due_date <= SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: ' || rec.name || 
                             ' has loan ' || rec.loan_id ||
                             ' due on ' || TO_CHAR(rec.due_date, 'DD-MON-YYYY'));
    END LOOP;
END;
/
