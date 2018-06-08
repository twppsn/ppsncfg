CREATE TABLE [dbo].[Pers]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkPersId PRIMARY KEY IDENTITY (1,1), 
	[KtktId] BIGINT NOT NULL CONSTRAINT fkPersKtktId REFERENCES dbo.Ktkt (Id) ON DELETE CASCADE,
	[Kurz] CHAR(10) NULL,
	[Tel] VARCHAR(30) NULL, 
	[Fax] VARCHAR(30) NULL, 
	[Mobil] VARCHAR(30) NULL, 
	[Mail] NVARCHAR(100) NULL, 
	[Geburt] SMALLDATETIME NULL, 
	[Seit] SMALLDATETIME NULL, 
	[Bis] SMALLDATETIME NULL, 
	[Rfid] NVARCHAR(50) NULL, 
	[VersNr] VARCHAR(50) NULL, 
	[FamStand] VARCHAR(50) NULL, 
	[StKl] TINYINT NULL, 
	[Kasse] VARCHAR(50) NULL, 
	[KindFrei] DECIMAL(4, 2) NULL, 
	[Staat] NVARCHAR(50) NULL,
)
GO
CREATE INDEX [idxPersKtktId] ON [dbo].[Pers] ([KtktId])
GO
ALTER TABLE [dbo].[Pers] ENABLE CHANGE_TRACKING;
GO
GRANT SELECT, INSERT, UPDATE, DELETE, VIEW CHANGE TRACKING ON [dbo].[Pers] TO public;
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'PK',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Id'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'FK, Kontakt',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'KtktId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Geburtstag',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Geburt'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Beschäftigt von',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Seit'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Beschäftigt bis',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Bis'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'RFID-Nummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Rfid'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Versicherungsnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'VersNr'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Familienstand',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'FamStand'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Steuerklasse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'StKl'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Krankenkasse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = 'Kasse'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Kinderfreibetrag',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'KindFrei'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Telefonnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Tel'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Faxnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Fax'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Mobilnummer',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Mobil'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Mail-Adresse',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Mail'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Staatsangehrörigkeit',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Staat'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Kurzbezeichnung',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Pers',
    @level2type = N'COLUMN',
    @level2name = N'Kurz'