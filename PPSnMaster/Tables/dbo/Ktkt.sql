CREATE TABLE [dbo].[Ktkt]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkKtktId PRIMARY KEY IDENTITY (1,1),
	[ObjkId] BIGINT NOT NULL CONSTRAINT fkKtktObjkId REFERENCES dbo.ObjK (Id), 
	[ParentId] BIGINT NULL CONSTRAINT fkParentKtktId REFERENCES dbo.Ktkt (Id), 
	[Name] NVARCHAR(100) NOT NULL,
	[KurzName] NVARCHAR(25) NULL,
	[StIdentNr] VARCHAR(25) NULL, 
	[SteuerNr] VARCHAR(25) NULL, 
	[UstIdNr] CHAR(16) NULL, 
	[Inaktiv] SMALLDATETIME NULL,
	[Iban] CHAR(34) NULL, 
	[Bic] CHAR(11) NULL, 
	[WaehId] BIGINT NULL CONSTRAINT fkKtktWaehId REFERENCES dbo.Waeh (Id),
	[LandId] BIGINT NULL CONSTRAINT fkKtktLandId REFERENCES dbo.Land (Id),
	[Postfach] NVARCHAR(20) NULL, 
	[Zusatz] NVARCHAR(20) NULL, 
	[Strasse] NVARCHAR(50) NULL, 
	[Ort] NVARCHAR(50) NULL, 
	[Region] NVARCHAR(50) NULL, 
	[Plz] NVARCHAR(10) NULL, 
	[Adresse] NVARCHAR(512) NULL, 
	[VAdresse] NVARCHAR(512) NULL, 
	[RAdresse] NVARCHAR(512) NULL,
	[KoordL] FLOAT NULL,
	[KoordB] FLOAT NULL, 
	--[Facebook] NVARCHAR(256) NULL, 
	--[Twitter] NVARCHAR(256) NULL, 
	--[LinkedIn] NVARCHAR(256) NULL, 
	--[Instagram] NVARCHAR(256) NULL,
)
GO
ALTER TABLE [dbo].[Ktkt] ENABLE CHANGE_TRACKING;
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Objk',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'ObjkId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Name des Kontakts',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Name'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Steuerliche Identifikationsnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = 'StIdentNr'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Steuernummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'SteuerNr'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Mehrwertsteuer-Identifikationsnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = 'UstIdNr'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Inaktiv seit',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Inaktiv'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Iban-Nummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Iban'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Bic-Nummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Bic'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Kurzname des Kontakts',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'KurzName'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'PK',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Id'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Adressse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Adresse'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Versandadresse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'VAdresse'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Währung',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = 'WaehId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Land',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'LandId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Rechnungsadresse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'RAdresse'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Postfach',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Postfach'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Adresszusatz (z.B. Wohnungsnummer)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Zusatz'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Strasse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Strasse'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Stadt',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Ort'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Region (z.B. Bundesstaat)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Region'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Postleitzahl',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'Plz'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Breitengrad Koordinate',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'KoordB'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Längengrad Koordinate',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'KoordL'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK zu Ktkt (Parent -> übergeordnetes Unternehmen)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Ktkt',
    @level2type = N'COLUMN',
    @level2name = N'ParentId'
GO