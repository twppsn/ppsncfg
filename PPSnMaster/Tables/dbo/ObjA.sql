CREATE TABLE [dbo].[ObjA]
(
	[ObjId] BIGINT NOT NULL CONSTRAINT fkObjAObjKId REFERENCES dbo.[ObjK] ([Id]) ON DELETE NO ACTION,
	[UserId] BIGINT NOT NULL CONSTRAINT fkObjAUserId REFERENCES dbo.[User] ([Id]) ON DELETE CASCADE,
	[Access] BIGINT NOT NULL,
	[Deny] BIGINT NOT NULL,
	PRIMARY KEY ([ObjId], [UserId])
)
GO
ALTER TABLE [dbo].[ObjA] ENABLE CHANGE_TRACKING;
GO
GRANT SELECT, INSERT, UPDATE, DELETE, VIEW CHANGE TRACKING ON [dbo].[ObjA] TO public;
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Table to descripe the access of a user to a specific object.',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjA'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Foreign key to the object',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjA',
    @level2type = N'COLUMN',
    @level2name = N'ObjId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Foreign key to the user',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjA',
    @level2type = N'COLUMN',
    @level2name = N'UserId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Bit mask to grant access',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjA',
    @level2type = N'COLUMN',
    @level2name = N'Access'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Bit mask to deny access',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjA',
    @level2type = N'COLUMN',
    @level2name = N'Deny'