CREATE TABLE [dbo].[Vika]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkVikaId PRIMARY KEY IDENTITY (1,1), 
	[KtktId] BIGINT NOT NULL CONSTRAINT fkVikaKtktId REFERENCES dbo.Ktkt (Id) ON DELETE CASCADE,
	[ParentId] BIGINT NULL CONSTRAINT fkParentVikaId REFERENCES dbo.Vika (Id),
	[Name] NVARCHAR(100) NOT NULL, 
	[Vorname] NVARCHAR(100) NULL,
	[Titel] NVARCHAR(30) NULL, 
	[Tel] VARCHAR(30) NULL, 
	[Fax] VARCHAR(30) NULL, 
	[Mobil] VARCHAR(30) NULL, 
	[Mail] NVARCHAR(100) NULL, 
	[Std] BIT NOT NULL CONSTRAINT dfVikaStd DEFAULT 0, 
	[Geschl] CHAR NULL, 
	[Funktion] NVARCHAR(50) NULL, 
	[Brief] NVARCHAR(50) NULL, 
	[Postfach] NVARCHAR(20) NULL, 
	[Zusatz] NVARCHAR(20) NULL, 
	[Strasse] NVARCHAR(50) NULL, 
	[Ort] NVARCHAR(50) NULL, 
	[Region] NVARCHAR(50) NULL, 
	[Plz] NVARCHAR(10) NULL, 
	[Adresse] NVARCHAR(512) NULL
)
GO
ALTER TABLE [dbo].[Vika] ENABLE CHANGE_TRACKING;
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Vika] TO public;
GO
CREATE INDEX [idxVikaKtktId] ON [dbo].[Vika] ([KtktId])
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'PK',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Id'
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Name des Ansprechpartners',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Name'
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'akademischer Titel',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Titel'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Telefonnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Tel'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Faxnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Fax'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Mobilnummer (Handy)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Mobil'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Mailadresse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Mail'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Standardansprechpartner',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Std'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Geschlecht (m=männlich, w=weiblich)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Geschl'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Funktion/Abteilung in der Firma',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Funktion'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Briefanrede (z.B. Sehr geehrter Herr, Liebe Frau)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Brief'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Kontakt',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = 'KtktId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Postfach',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Postfach'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Adress-Zusatz',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Zusatz'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Straße mit Nr',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Strasse'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Ort',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Ort'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Region',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Region'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Plz',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Plz'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'vollständige Adresse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Adresse'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Vorname',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'Vorname'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Visitenkarte (Parent -> Übergeordnete Visitenkarte (Bereich))',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Vika',
    @level2type = N'COLUMN',
    @level2name = N'ParentId'
GO