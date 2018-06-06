CREATE TABLE [dbo].[ObjF]
(
	[Id] BIGINT NOT NULL CONSTRAINT pkFileId PRIMARY KEY IDENTITY (1, 1),
	[FileUId] UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL CONSTRAINT uqFileUId UNIQUE DEFAULT NEWID(),
	[HashAlgo] CHAR(10) NOT NULL,
	[Hash] BINARY(64) NOT NULL,
	[Data] VARBINARY(max) FILESTREAM NOT NULL, 
    CONSTRAINT [ckObjFHashAlgo] CHECK ([HashAlgo] in ('MD5', 'SHA1', 'SHA2_256', 'SHA2_512'))
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'PK',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjF',
    @level2type = N'COLUMN',
    @level2name = N'Id'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'unique id',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjF',
    @level2type = N'COLUMN',
    @level2name = N'FileUId'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Algorithm see hashbytes',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjF',
    @level2type = N'COLUMN',
    @level2name = N'HashAlgo'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'hash value of the file',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ObjF',
    @level2type = N'COLUMN',
    @level2name = N'Hash'