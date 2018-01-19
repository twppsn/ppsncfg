CREATE TABLE [dbo].[User]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkUserId PRIMARY KEY IDENTITY (1,1),
	[Login] [sys].[sysname] NULL, 
	[Security] NVARCHAR(MAX) NULL, 
	[LoginVersion] BIGINT NOT NULL CONSTRAINT dfUserLoginVersion DEFAULT 0, 
    [PersId] BIGINT NULL CONSTRAINT fkUserPersId REFERENCES dbo.Pers (Id), 
)
GO
ALTER TABLE [dbo].[User] ENABLE CHANGE_TRACKING;
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Security mask (tokens),für den Nutzer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'User',
    @level2type = N'COLUMN',
    @level2name = N'Security'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Loginname des Nutzers',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'User',
    @level2type = N'COLUMN',
    @level2name = N'Login'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Version, falls Logindaten im System geändert wurden',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'User',
    @level2type = N'COLUMN',
    @level2name = N'LoginVersion'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'User Pers assignment',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'User',
    @level2type = N'COLUMN',
    @level2name = N'PersId'