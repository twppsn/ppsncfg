CREATE TABLE [dbo].[User]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkUserId PRIMARY KEY IDENTITY (1,1),
	[Login] [sys].[sysname] NULL, 
	[Security] NVARCHAR(MAX) NULL, 
	[LoginVersion] BIGINT NOT NULL CONSTRAINT dfUserLoginVersion DEFAULT 0, 
	[KtktId] BIGINT NULL CONSTRAINT fkUserKtktId REFERENCES dbo.Ktkt (Id) ON DELETE SET NULL, 
    [Identicon] INT NOT NULL DEFAULT 0, 
)
GO
ALTER TABLE [dbo].[User] ENABLE CHANGE_TRACKING;
GO
GRANT SELECT, INSERT, UPDATE, DELETE, VIEW CHANGE TRACKING ON [dbo].[User] TO public;
GO
CREATE INDEX [idxUserKtktId] ON [dbo].[User] ([KtktId])
GO
CREATE TRIGGER dbo.UserInsert ON dbo.[User] AFTER INSERT
AS
BEGIN
	UPDATE dbo.[User] 
		SET Identicon = dbo.GetIdenticonFromHash(dbo.GetStringHashCode(i.[Login]))
		FROM inserted i
			INNER JOIN dbo.[User] u ON (i.Id = u.Id);
END;
-- UPDATE dbo.[User] SET Identicon = dbo.GetIdenticonFromHash(dbo.GetStringHashCode([Login])) WHERE Identicon = 0;
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
    @value = N'FK zu Kontakt (Personal)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'User',
    @level2type = N'COLUMN',
    @level2name = N'KtktId'