/*
 Vorlage für ein Skript vor der Bereitstellung							
--------------------------------------------------------------------------------------
 Diese Datei enthält SQL-Anweisungen, die vor dem Buildskript ausgeführt werden.	
 Schließen Sie mit der SQLCMD-Syntax eine Datei in das Skript vor der Bereitstellung ein.			
 Beispiel:   :r .\myfile.sql								
 Verweisen Sie mit der SQLCMD-Syntax auf eine Variable im Skript vor der Bereitstellung.		
 Beispiel:   :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'clr enabled', 1;  
GO
IF EXISTS (SELECT * FROM sys.configurations WHERE name = 'clr strict security') 
	EXEC sp_configure 'clr strict security', 0;  
GO  
RECONFIGURE;  
GO  