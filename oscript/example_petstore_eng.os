Var uTest;

Function ПолучитьСписокТестов(ЮнитТестирование) Export

	uTest = ЮнитТестирование;

	AllTests = New Array();
	AllTests.Add("Test_CreateNewPet");

	Return AllTests;
EndFunction

Procedure Test_CreateNewPet() Export
	
	PetName = "Барсик";

	ConnectionHTTP = New HTTPConnection("https://petstore.swagger.io/v2/pet/");

	DataJson = New Structure();
	DataJson.Insert("name", PetName);
	DataJson.Insert("status", "available");
	JSONWriter = New JSONWriter();
	JSONWriter.SetString(); 
	WriteJSON(JSONWriter, DataJson);
    JSONString = JSONWriter.Close();

	PostRequest = New HTTPRequest();
	PostRequest.Headers.Insert("Content-type", "application/json");
	PostRequest.SetBodyFromString(JSONString);
	PostResponse = ConnectionHTTP.Post(PostRequest);

	uTest.ПроверитьРавенство(PostResponse.StatusCode, 200);

	JSONReader = New JSONReader();
	JSONReader.SetString(PostResponse.GetBodyAsString("UTF-8"));  		
	ResponseBody = ReadJSON(JSONReader);

	GetRequest = New HTTPRequest(ResponseBody.id);
	GetRequest.Headers.Insert("Content-type", "application/json");
	GetResponse = ConnectionHTTP.Get(GetRequest);

	uTest.ПроверитьРавенство(GetResponse.StatusCode, 200);

	JSONReader = New JSONReader();
	JSONReader.SetString(GetResponse.GetBodyAsString("UTF-8"));  		
	ResponseBody = ReadJSON(JSONReader);
	uTest.AssertEquals(ResponseBody.name, PetName);

EndProcedure
