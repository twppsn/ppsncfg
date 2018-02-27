DECLARE @objkId BIGINT;
DECLARE @ktktId BIGINT;
DECLARE @nr NVARCHAR(20);

-- Kontakte
SET @nr = 'P000001';
IF NOT EXISTS (SELECT Id FROM dbo.Objk WHERE Nr = @nr) 
BEGIN
	INSERT INTO dbo.ObjK ([Guid], [Typ], [MimeType], [Nr], [IsRev]) VALUES (NEWID(), 'crmContacts', 'text/dataset', @nr, 0);
	SET @objkId = @@IDENTITY;

	INSERT INTO [dbo].[Ktkt] ([ObjkId], [ParentId], [Name], [KurzName])
		VALUES (@objkId, NULL,'Matthias Stein','ms');
	SET @ktktId = @@IDENTITY;

	INSERT INTO [dbo].[User] ([Login], [Security], [LoginVersion], [KtktId])
		VALUES ('TecWare\Stein', 'desSys', 0, @ktktId);

	INSERT INTO [dbo].[Pers] ([KtktId]) VALUES (@ktktId);

	INSERT INTO dbo.ObjT ([ObjkId], [ObjRId], [Class], [UserId], [Key], [Value]) 
		VALUES (@objkId, null, 0, 0, 'Name', 'Matthias Stein');
END

SET @nr = 'P000002';
IF NOT EXISTS (SELECT Id FROM dbo.Objk WHERE Nr = @nr) 
BEGIN
	INSERT INTO dbo.ObjK ([Guid], [Typ], [MimeType], [Nr], [IsRev]) VALUES (NEWID(), 'crmContacts', 'text/dataset', @nr, 0);
	SET @objkId = @@IDENTITY;

	INSERT INTO [dbo].[Ktkt] ([ObjkId], [ParentId], [Name], [KurzName])
		VALUES (@objkId, NULL,'Waldemar Hermann','wh');
	SET @ktktId = @@IDENTITY;

	INSERT INTO [dbo].[User] ([Login], [Security], [LoginVersion], [KtktId])
		VALUES ('TecWare\Hermann', 'desSys', 0, @ktktId);

	INSERT INTO [dbo].[Pers] ([KtktId]) VALUES (@ktktId);

	INSERT INTO dbo.ObjT ([ObjkId], [ObjRId], [Class], [UserId], [Key], [Value]) 
		VALUES (@objkId, null, 0, 0, 'Name', 'Waldemar Hermann');
END

SET @nr = 'P000003';
IF NOT EXISTS (SELECT Id FROM dbo.Objk WHERE Nr = @nr) 
BEGIN
	INSERT INTO dbo.ObjK ([Guid], [Typ], [MimeType], [Nr], [IsRev]) VALUES (NEWID(), 'crmContacts', 'text/dataset', @nr, 0);
	SET @objkId = @@IDENTITY;

	INSERT INTO [dbo].[Ktkt] ([ObjkId], [ParentId], [Name], [KurzName])
		VALUES (@objkId, NULL,'Richard Krug','rk');
	SET @ktktId = @@IDENTITY;

	INSERT INTO [dbo].[User] ([Login], [Security], [LoginVersion], [KtktId])
		VALUES ('TecWare\Krug', 'desSys', 0, @ktktId);

	INSERT INTO [dbo].[Pers] ([KtktId]) VALUES (@ktktId);

	INSERT INTO dbo.ObjT ([ObjkId], [ObjRId], [Class], [UserId], [Key], [Value]) 
		VALUES (@objkId, null, 0, 0, 'Name', 'Richard Krug');
END

SET @nr = 'P000004';
IF NOT EXISTS (SELECT Id FROM dbo.Objk WHERE Nr = @nr) 
BEGIN
	INSERT INTO dbo.ObjK ([Guid], [Typ], [MimeType], [Nr], [IsRev]) VALUES (NEWID(), 'crmContacts', 'text/dataset', @nr, 0);
	SET @objkId = @@IDENTITY;

	INSERT INTO [dbo].[Ktkt] ([ObjkId], [ParentId], [Name], [KurzName])
		VALUES (@objkId, NULL,'Wolfgang Schmidt','ws');
	SET @ktktId = @@IDENTITY;

	INSERT INTO [dbo].[User] ([Login], [Security], [LoginVersion], [KtktId])
		VALUES ('TecWare\Schmidt', 'desSys', 0, @ktktId);

	INSERT INTO [dbo].[Pers] ([KtktId]) VALUES (@ktktId);

	INSERT INTO dbo.ObjT ([ObjkId], [ObjRId], [Class], [UserId], [Key], [Value]) 
		VALUES (@objkId, null, 0, 0, 'Name', 'Wolfgang Schmidt');
END

SET @nr = 'P000005';
IF NOT EXISTS (SELECT Id FROM dbo.Objk WHERE Nr = @nr) 
BEGIN
	INSERT INTO dbo.ObjK ([Guid], [Typ], [MimeType], [Nr], [IsRev]) VALUES (NEWID(), 'crmContacts', 'text/dataset', @nr, 0);
	SET @objkId = @@IDENTITY;

	INSERT INTO [dbo].[Ktkt] ([ObjkId], [ParentId], [Name], [KurzName])
		VALUES (@objkId, NULL,'Andreas Schweitzer','as');
	SET @ktktId = @@IDENTITY;

	INSERT INTO [dbo].[User] ([Login], [Security], [LoginVersion], [KtktId])
		VALUES ('TecWare\Schweitzer', 'desSys', 0, @ktktId);

	INSERT INTO [dbo].[Pers] ([KtktId]) VALUES (@ktktId);

	INSERT INTO dbo.ObjT ([ObjkId], [ObjRId], [Class], [UserId], [Key], [Value]) 
		VALUES (@objkId, null, 0, 0, 'Name', 'Andreas Schweitzer');
END

SET @nr = 'P000006';
IF NOT EXISTS (SELECT Id FROM dbo.Objk WHERE Nr = @nr) 
BEGIN
	INSERT INTO dbo.ObjK ([Guid], [Typ], [MimeType], [Nr], [IsRev]) VALUES (NEWID(), 'crmContacts', 'text/dataset', @nr, 0);
	SET @objkId = @@IDENTITY;

	INSERT INTO [dbo].[Ktkt] ([ObjkId], [ParentId], [Name], [KurzName])
		VALUES (@objkId, NULL,'Robert Schweitzer','rs');
	SET @ktktId = @@IDENTITY;

	INSERT INTO [dbo].[User] ([Login], [Security], [LoginVersion], [KtktId])
		VALUES ('TecWare\RSchweitzer', 'desSys', 0, @ktktId);

	INSERT INTO [dbo].[Pers] ([KtktId]) VALUES (@ktktId);

	INSERT INTO dbo.ObjT ([ObjkId], [ObjRId], [Class], [UserId], [Key], [Value]) 
		VALUES (@objkId, null, 0, 0, 'Name', 'Robert Schweitzer');
END
