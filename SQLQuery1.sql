-- Remove old table safely
IF OBJECT_ID('dbo.friends', 'U') IS NOT NULL
    DROP TABLE dbo.friends;
GO

-- Create table with professional standards
CREATE TABLE dbo.friends (
    id INT IDENTITY(1,1) PRIMARY KEY,          -- Auto-incrementing unique ID
    name VARCHAR(255) NOT NULL,                -- Cannot be empty
    birthday DATE CHECK (birthday < GETDATE()),-- Must be in the past
    email VARCHAR(255) UNIQUE NOT NULL,        -- Must be unique + not null
    created_at DATETIME DEFAULT GETDATE(),     -- Timestamp for record creation
    updated_at DATETIME NULL                   -- Track last update
);
GO

-- Insert data
INSERT INTO dbo.friends (name, birthday, email)
VALUES 
('Ororo Munroe', '1940-05-30', 'storm@codeacademy.com'),
('David Northrup', '1993-05-21', 'davenorth13@gamil.com'),
('Diavonte Lewis', '1995-01-12', 'dialewis@yahoo.com');
GO

-- Update record (with timestamp)
UPDATE dbo.friends
SET name = 'Storm',
    updated_at = GETDATE()
WHERE name = 'Ororo Munroe';
GO

-- Delete with extra safety (checks before deleting)
IF EXISTS (SELECT 1 FROM dbo.friends WHERE name = 'Storm')
BEGIN
    DELETE FROM dbo.friends WHERE name = 'Storm';
END
GO

-- Final result
SELECT * FROM dbo.friends;
GO