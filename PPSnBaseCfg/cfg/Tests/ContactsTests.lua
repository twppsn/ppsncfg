-- Init code for all test cases
UseNode("/ppsn/crmContacts");

-- we have no reference database at the moment.
local oid;

function NewContact()

	local obj = Objects:CreateNewObject {Typ="crmContacts",Nr=Objects:GetNextNumber("crmContacts",NextNumber)};
	-- print(obj.Id);
	AssertIsNotNull(obj, "Create object failed." .. obj.Id);
	-- AssertAreEqual(23, 20+3, "richtig");

	local ds = DataSetDefinition.CreateDataSet();

	ds.Head:Add{Name="test"};

	AssertIsNotNull(ds, "Create dataset failed.");

	local s = Push(obj, ds);

	AssertAreEqual(s, true, "Push contact failed.")

	oid = obj.Id;

	trans:Commit();
end;

function LoadContact()
	local kt, ob = Pull(oid);

	AssertAreEqual(ob.Id, oid, "Pull contact failed.")
end;

function ManyVikaForContact()
	local kt, ob = Pull(oid);

	for i = 1, 100, 1 do
		kt.Head.First.VikaHead:Add{Name="Bla"..i};
  end;

	local s = Push(ob, kt);

	AssertAreEqual(s, true, "Push contact failed.")

	AssertAreEqual(kt.Vika.Count, 100, "Number of ds is not equal.");

	AssertAreEqual(kt.Vika[99].Name, "Bla100", "Name of Vika is not equal.");
end;

function NewContactWithData()
	--d,o = Pull(oid); --d.Head[0].Id
	--local kid = d.Head[0].Id;
	local obj = Objects:CreateNewObject {Typ="crmContacts",Nr=Objects:GetNextNumber("crmContacts",NextNumber)};
	local ds = DataSetDefinition.CreateDataSet();
	
	-- contact data
	ds.Head:Add{ParentId = nil, Name="testajsndjkfasdjkfkasdbfsbadbfajsbdfjsajdbfjbasdbfadfsadfhbasdhbfsdhfahsdbfsdfs.,asdf,gls,dlfg,sdäf12",
		KurzName="Kurzname", StIdentNr="45678909876", SteuerNr="98765567890z", UstIdNr="98765tzhui90876", Inaktiv="2013-01-01", Iban="987zhjo9876t78987", Bic="98767890o3", WaehId=1, LandId=1, 
		Postfach="53647890", Zusatz="ß09876zuiok", Strasse="09873urjnfm", Ort="98767893090987zhsd", Region="98732zfkisajofdu", Plz="2382388", Adresse="ashdfjasjkdfajklsdfjkasjkfhjkas",
		VAdresse="u8jfidf0899uhfa90ia", RAdresse="7zfhauidfu8q9", KoordL=22.2, KoordB=33.3};
	-- customer data
	ds.Head.First.KundHead:Add{LiefNr="123412341234", Inaktiv="2015-12-12", Abc="C"};
	-- supplier data
	ds.Head.First.LiefHead:Add{KundNr="123412341234", Inaktiv="2017-12-12", Abc="A"};
	-- personal data
	ds.Head.First.PersHead:Add{Tel="3456789iuzhg", Fax="56789i9jhjk", Mobil="kjhaz8i9238uf", Mail="test@test.de", Geburt="2012-07-09", Seit="2013-03-03", Bis=clr.System.DateTime.Now,
		Rfid="9876789009876", VersNr="987678902", FamStand="ledig", StKl=5, Kasse="AOK", KindFrei=2, Staat="0976542"};
	-- business card data
	ds.Head.First.VikaHead:Add{Name="asdfasfasfdsaf", Vorname="asdfasdfasfdas", Titel="asdfasdfasdf", Tel="d234124312341234", Fax="asdfasdf4rwesdfsadf", Mobil="asdfasdfasdfasdfasdf", 
		Mail="test@test.de", Std=0, Geschl="männlich", Funktion="asdfasdfasdfasdf", Brief="asdfasdfasfdsafds", Postfach="asdfasdfasfd", Zusatz="asdfasdfasdfasfdas",
		Strasse="asdfasdfasdfasfd", Ort="asdfasdfasdfasfsaf", Region="asdfasdfasfasf", Plz="asdfasdfas", Adresse="asdfasdfashdfiasf"};

	local s = Push(obj, ds);

	AssertAreEqual(s, true, "Push contact failed.")

	--AssertAreEqual(ds.Head[0].ParentId, d.Head[0].Id, "ParentId is false.");
	
	AssertAreEqual(ds.Head[0].Name, "testajsndjkfasdjkfkasdbfsbadbfajsbdfjsajdbfjbasdbfadfsadfhbasdhbfsdhfahsdbfsdfs.,asdf,gls,dlfg,sdäf1", "Daten nicht gekürzt.");

	AssertAreEqual(ds.Kund[0].LiefNr, "123412341234", "Kund-Data is false.");

	AssertAreEqual(ds.Lief[0].Abc, "A", "Lief-Data is false.");

	AssertAreEqual(ds.Pers[0].Mail, "test@test.de", "Pers-Data is false.");

	AssertAreEqual(ds.Vika[0].Mail, "test@test.de", "Vika-Data is false.");

end;

function UpdateContact()
	local ds, obj = Pull(oid);

	ds.Head[].Name="BlaBla";
	ds.Head[].KurzName="Kurzname"; 
	ds.Head[].StIdentNr="45678909876"; 
	ds.Head[].SteuerNr="98765567890z"; 
	ds.Head[].UstIdNr="98765tzhui90876"; 
	ds.Head[].Inaktiv="2013-01-01"; 
	ds.Head[].Iban="987zhjo9876t78987"; 
	ds.Head[].Bic="98767890o3"; 
	ds.Head[].WaehId=1; 
	ds.Head[].LandId=1;
	ds.Head[].Postfach="53647890"; 
	ds.Head[].Zusatz="ß09876zuiok"; 
	ds.Head[].Strasse="09873urjnfm"; 
	ds.Head[].Ort="98767893090987zhsd"; 
	ds.Head[].Region="98732zfkisajofdu"; 
	ds.Head[].Plz="2382388"; 
	ds.Head[].Adresse="ashdfjasjkdfajklsdfjkasjkfhjkas";
	ds.Head[].VAdresse="u8jfidf0899uhfa90ia";
	ds.Head[].RAdresse="7zfhauidfu8q9";
	ds.Head[].KoordL=22.2;
	ds.Head[].KoordB=33.3;
	-- customer data
	ds.Head.First.KundHead:Add{LiefNr="123412341234", Inaktiv="2015-12-12", Abc="C"};
	-- supplier data
	ds.Head.First.LiefHead:Add{KundNr="123412341234", Inaktiv="2017-12-12", Abc="A"};
	-- personal data
	ds.Head.First.PersHead:Add{Tel="3456789iuzhg", Fax="56789i9jhjk", Mobil="kjhaz8i9238uf", Mail="test@test.de", Geburt="2012-07-09", Seit="2013-03-03", Bis=clr.System.DateTime.Now,
		Rfid="9876789009876", VersNr="987678902", FamStand="ledig", StKl=5, Kasse="AOK", KindFrei=2, Staat="0976542"};
	-- business card data
	ds.Head.First.VikaHead:Add{Name="asdfasfasfdsaf", Vorname="asdfasdfasfdas", Titel="asdfasdfasdf", Tel="d234124312341234", Fax="asdfasdf4rwesdfsadf", Mobil="asdfasdfasdfasdfasdf", 
		Mail="test@test.de", Std=0, Geschl="männlich", Funktion="asdfasdfasdfasdf", Brief="asdfasdfasfdsafds", Postfach="asdfasdfasfd", Zusatz="asdfasdfasdfasfdas",
		Strasse="asdfasdfasdfasfd", Ort="asdfasdfasdfasfsaf", Region="asdfasdfasfasf", Plz="asdfasdfas", Adresse="asdfasdfashdfiasf"};

	local s = Push(obj, ds);

	AssertAreEqual(s, true, "Push contact failed.")

	AssertAreEqual(ds.Head[0].Name, "BlaBla", "Updated Data is false.");

	trans:Commit();
end;

function UpdateContactData()
	local ds, obj = Pull(oid);

	-- customer data
	ds.Kund[0].LiefNr="0815"; 
	ds.Kund[0].Inaktiv=clr.System.DateTime.Now;
	ds.Kund[0].Abc="A";
	-- supplier data
	ds.Lief[0].KundNr="5180"; 
	ds.Lief[0].Inaktiv=clr.System.DateTime.Now;
	ds.Lief[0].Abc="C";
	-- personal data
	ds.Pers[0].Tel="0815"; 
	ds.Pers[0].Fax="5180"; 
	ds.Pers[0].Mobil="00226688"; 
	ds.Pers[0].Mail="pusten@test.de"; 
	ds.Pers[0].Geburt=clr.System.DateTime.Now;
	ds.Pers[0].Seit=clr.System.DateTime.Now;
	ds.Pers[0].Bis=clr.System.DateTime.Now;
	ds.Pers[0].Rfid="0123456789";
	ds.Pers[0].VersNr="9876543210"; 
	ds.Pers[0].FamStand="verheiratet"; 
	ds.Pers[0].StKl=7; 
	ds.Pers[0].Kasse="BAR"; 
	ds.Pers[0].KindFrei=1; 
	ds.Pers[0].Staat="deutsch";
	-- business card data
	ds.Vika[0].Name="Uhu";
	ds.Vika[0].Vorname="Baum"; 
	ds.Vika[0].Titel="Herr"; 
	ds.Vika[0].Tel="0815"; 
	ds.Vika[0].Fax="5180"; 
	ds.Vika[0].Mobil="0000"; 
	ds.Vika[0].Mail="123@test.de"; 
	ds.Vika[0].Std=1; 
	ds.Vika[0].Geschl="Weiblich"; 
	ds.Vika[0].Funktion="Überflieger"; 
	ds.Vika[0].Brief="mein Lieber"; 
	ds.Vika[0].Postfach="098765432"; 
	ds.Vika[0].Zusatz="Um die Ecke";
	ds.Vika[0].Strasse="Hochhinaus 5"; 
	ds.Vika[0].Ort="Baumwipfel"; 
	ds.Vika[0].Region="Baumkrone"; 
	ds.Vika[0].Plz="445566"; 
	ds.Vika[0].Adresse="B B B";

	local s = Push(obj, ds);

	AssertAreEqual(s, true, "Push contact failed.")

	AssertAreEqual(ds.Kund[0].LiefNr, "0815", "Updated Kund-Data is false.");

	AssertAreEqual(ds.Lief[0].KundNr, "5180", "Updated Kund-Data is false.");

	AssertAreEqual(ds.Pers[0].Tel, "0815", "Updated Pers-Data is false.");

	AssertAreEqual(ds.Vika[0].Name, "Uhu", "Updated Vika-Data is false.");
end;

function CleanContact()
	
	Db.Main:ExecuteNoneResult({ sql = "DELETE FROM [dbo].[Kund] FROM [dbo].[Kund] INNER JOIN [dbo].[Ktkt] ON Ktkt.Id = Kund.KtktId WHERE ObjKId = " .. oid});
	Db.Main:ExecuteNoneResult({ sql = "DELETE FROM [dbo].[Lief] FROM [dbo].[Lief] INNER JOIN [dbo].[Ktkt] ON Ktkt.Id = Lief.KtktId WHERE ObjKId = " .. oid});
	Db.Main:ExecuteNoneResult({ sql = "DELETE FROM [dbo].[Pers] FROM [dbo].[Pers] INNER JOIN [dbo].[Ktkt] ON Ktkt.Id = Pers.KtktId WHERE ObjKId = " .. oid});
	Db.Main:ExecuteNoneResult({ sql = "DELETE FROM [dbo].[Vika] FROM [dbo].[Vika] INNER JOIN [dbo].[Ktkt] ON Ktkt.Id = Vika.KtktId WHERE ObjKId = " .. oid});
	Db.Main:ExecuteNoneResult({ sql = "DELETE FROM [dbo].[Ktkt] WHERE ObjKId = " .. oid});
	Db.Main:ExecuteNoneResult({ sql = "UPDATE [dbo].[ObjK] SET HeadRevId = null WHERE Id = " .. oid});
	Db.Main:ExecuteNoneResult({ sql = "DELETE FROM [dbo].[ObjR] WHERE ObjKId = " .. oid});
	Db.Main:ExecuteNoneResult({ sql = "DELETE FROM [dbo].[ObjK] WHERE Id = " .. oid});
	
end;

function test2()
	AssertAreEqual(23, 20+2, "falsch");
end;

function test3()
	AssertAreNotEqual(23, 20+3, "richtig");
end;

