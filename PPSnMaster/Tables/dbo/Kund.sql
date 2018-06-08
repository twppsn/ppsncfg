CREATE TABLE [dbo].[Kund]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkKundId PRIMARY KEY IDENTITY (1,1), 
	[KtktId] BIGINT NOT NULL CONSTRAINT fkKundKtktId REFERENCES dbo.Ktkt (Id) ON DELETE CASCADE, 
	[LiefNr] NVARCHAR(50) NULL,
	[Inaktiv] SMALLDATETIME NULL,
	[Abc] CHAR NULL, 
	[ZaziId] BIGINT NULL, 
	[VartId] BIGINT NULL, 
	[PstgId] BIGINT NULL, 
)
GO
ALTER TABLE [dbo].[Kund] ENABLE CHANGE_TRACKING;
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Kund] TO public;
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Kontakt',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'KtktId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Inaktiv seit',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'Inaktiv'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Abc-Einteilung',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'Abc'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'PK',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'Id'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Zahlungsziel',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'ZaziId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Versandart',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'VartId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Preistellung',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'PstgId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'ext. Lieferantennummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Kund',
    @level2type = N'COLUMN',
    @level2name = N'LiefNr'