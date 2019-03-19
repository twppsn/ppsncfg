CREATE TABLE [dbo].[TypA]
(
	[TypId] BIGINT NOT NULL CONSTRAINT fkTypADefId REFERENCES dbo.TypD ([Id]) ON DELETE NO ACTION,
	[UserId] BIGINT NOT NULL CONSTRAINT fkTypAUserId REFERENCES dbo.[User] ([Id]) ON DELETE CASCADE,
	[Allow] BIGINT NOT NULL,
	PRIMARY KEY ([TypId], [UserId])
)
GO
ALTER TABLE [dbo].[TypA] ENABLE CHANGE_TRACKING;
GO
GRANT SELECT, INSERT, UPDATE, DELETE, VIEW CHANGE TRACKING ON [dbo].[TypA] TO public;
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Table to descripe the access of a user to a specific object type.',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypA'
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Bit mask to grant access',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypA',
    @level2type = N'COLUMN',
    @level2name = N'Allow'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Foreign key to the user',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypA',
    @level2type = N'COLUMN',
    @level2name = N'UserId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Foreign key to the typ',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypA',
    @level2type = N'COLUMN',
    @level2name = N'TypId'