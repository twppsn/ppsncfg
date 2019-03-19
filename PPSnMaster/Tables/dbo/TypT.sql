CREATE TABLE [dbo].[TypT]
(
	[MaskId] BIGINT NOT NULL,
	[TypId] BIGINT NOT NULL CONSTRAINT fkTypTDefId REFERENCES dbo.TypD ([Id]) ON DELETE NO ACTION,
	[Token] CHAR(30) NOT NULL,
	PRIMARY KEY ([MaskId], [TypId])
)
GO
GO
GRANT SELECT ON [dbo].[TypT] TO public;
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Token access bit definition',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypT'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Token of the right',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypT',
    @level2type = N'COLUMN',
    @level2name = N'Token'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Assigned bit the first for bits a reserved for (read, write, unknown, unknown)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypT',
    @level2type = N'COLUMN',
    @level2name = N'MaskId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Foreign key to the object type',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypT',
    @level2type = N'COLUMN',
    @level2name = N'TypId'