CREATE TABLE [dbo].[TypD]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkTypDId PRIMARY KEY IDENTITY (1, 1), --todo: ref dbo.ObjK.Typ
	[Typ] CHAR(25) NOT NULL CONSTRAINT dfTypDTyp CHECK (LEN(Typ) > 0 )
)
GO
GRANT SELECT ON [dbo].[TypD] TO public;
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Definition of the object types',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypD'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Id of the object type',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypD',
    @level2type = N'COLUMN',
    @level2name = N'Id'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Type name',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'TypD',
    @level2type = N'COLUMN',
    @level2name = N'Typ'