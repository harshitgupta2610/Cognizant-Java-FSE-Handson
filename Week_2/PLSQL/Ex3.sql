-- Scenario 1: Process monthly interest for all savings accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE accounts
    SET balance = balance + (balance * 0.01)
    WHERE account_type = 'Savings';
    
    COMMIT;
END;
/

-- Scenario 2: Update employee salary with bonus in a department
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    dept_id IN NUMBER,
    bonus_pct IN NUMBER -- e.g., pass 10 for 10%
) IS
BEGIN
    UPDATE employees
    SET salary = salary + (salary * bonus_pct / 100)
    WHERE department_id = dept_id;

    COMMIT;
END;
/

-- Scenario 3: Transfer funds between accounts
CREATE OR REPLACE PROCEDURE TransferFunds(
    from_acc_id IN NUMBER,
    to_acc_id IN NUMBER,
    amount IN NUMBER
) IS
    insufficient_funds EXCEPTION;
    v_balance NUMBER;
BEGIN
    -- Check balance of source account
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = from_acc_id
    FOR UPDATE;

    IF v_balance < amount THEN
        RAISE insufficient_funds;
    END IF;

    -- Deduct from source
    UPDATE accounts
    SET balance = balance - amount
    WHERE account_id = from_acc_id;

    -- Add to destination
    UPDATE accounts
    SET balance = balance + amount
    WHERE account_id = to_acc_id;

    COMMIT;

EXCEPTION
    WHEN insufficient_funds THEN
        DBMS_OUTPUT.PUT_LINE('Transfer failed: Insufficient funds.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
        ROLLBACK;
END;
/
