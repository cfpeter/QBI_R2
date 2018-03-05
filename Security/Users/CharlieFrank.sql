IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CharlieFrank')
CREATE LOGIN [CharlieFrank] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [CharlieFrank] FOR LOGIN [CharlieFrank]
GO
